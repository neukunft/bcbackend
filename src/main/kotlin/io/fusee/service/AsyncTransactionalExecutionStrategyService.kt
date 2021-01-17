package io.fusee.service

import graphql.ExecutionResult
import graphql.execution.AsyncExecutionStrategy
import graphql.execution.ExecutionContext
import graphql.execution.ExecutionStrategyParameters
import graphql.execution.NonNullableFieldWasNullException
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.concurrent.CompletableFuture

@Service
class AsyncTransactionalExecutionStrategyService : AsyncExecutionStrategy() {

    @Transactional
    @Throws(NonNullableFieldWasNullException::class)
    override fun execute(executionContext: ExecutionContext, parameters: ExecutionStrategyParameters): CompletableFuture<ExecutionResult> {
        return super.execute(executionContext, parameters)
    }
}
