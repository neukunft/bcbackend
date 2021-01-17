package io.fusee.config

import graphql.execution.ExecutionStrategy
import graphql.language.StringValue
import graphql.schema.*
import io.fusee.service.AsyncTransactionalExecutionStrategyService
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.util.*

// ###################################################
// https://devsquad.10m.de/graphql_spring_backend.html
// ###################################################

@Configuration
class GraphQlConfiguration (
    private val asyncTransactionalExecutionStrategyService: AsyncTransactionalExecutionStrategyService
    ) {


    /*
    ** https://blog.akquinet.de/2020/04/16/part-2-graphql-with-spring-boot-jpa-and-kotlin/
    */
    @Bean
    fun executionStrategies(): Map<String, ExecutionStrategy> {
        val executionStrategyMap = HashMap<String, ExecutionStrategy>()
        executionStrategyMap["queryExecutionStrategy"] = asyncTransactionalExecutionStrategyService
        return executionStrategyMap
    }

    @Bean
    fun addScalarUuid(): GraphQLScalarType {
        return GraphQLScalarType
            .newScalar()
            .name("UUID")
            .description("java.util.UUID")
            .coercing(object : Coercing<UUID, String> {
                @Throws(CoercingSerializeException::class)
                override fun serialize(dataFetcherResult: Any): String {
                    return (dataFetcherResult as? UUID)?.toString()
                        ?: throw IllegalArgumentException(
                            ("Unable to serialize " + dataFetcherResult
                                    + " as UUID to String. Wrong Type. Expected UUID.class, Got " + dataFetcherResult.javaClass)
                        )
                }

                @Throws(CoercingParseValueException::class)
                override fun parseValue(input: Any): UUID {
                    return if (input is String) {
                        UUID.fromString(input)
                    } else {
                        throw IllegalArgumentException(
                            "Unable to serialize " + input
                                    + " as UUID to String. Wrong Type. Expected String.class, Got " + input.javaClass
                        )
                    }
                }

                @Throws(CoercingParseLiteralException::class)
                override fun parseLiteral(input: Any): UUID {
                    return if (input is StringValue) {
                        UUID.fromString(input.value)
                    } else {
                        throw IllegalArgumentException(
                            ("Unable to serialize " + input
                                    + " as UUID to String. Wrong Type. Expected StringValue.class, Got " + input.javaClass)
                        )
                    }
                }
            })
            .build()
    }
}
