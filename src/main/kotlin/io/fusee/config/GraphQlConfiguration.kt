package io.fusee.config

import graphql.language.StringValue
import graphql.schema.CoercingParseLiteralException

import graphql.schema.CoercingParseValueException

import graphql.schema.CoercingSerializeException

import graphql.schema.Coercing

import graphql.schema.GraphQLScalarType
import org.jetbrains.exposed.dao.DaoEntityID
import org.jetbrains.exposed.dao.id.EntityID
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.util.*

// ###################################################
// https://devsquad.10m.de/graphql_spring_backend.html
// ###################################################

@Configuration
class GraphQlConfiguration {
    @Bean
    fun addScalarUuid(): GraphQLScalarType {
        return GraphQLScalarType
            .newScalar()
            .name("UUID")
            .description("java.util.UUID")
            .coercing(object : Coercing<UUID, String> {
                @Throws(CoercingSerializeException::class)
                override fun serialize(dataFetcherResult: Any): String {
                    if (dataFetcherResult is EntityID<*>) {
                        return (dataFetcherResult._value as? UUID)?.toString()
                            ?: throw IllegalArgumentException(
                                ("Unable to serialize " + dataFetcherResult
                                        + " as UUID to String. Wrong Type. Expected EntityID<*>.class, Got " + dataFetcherResult.javaClass)
                            )
                    }
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
