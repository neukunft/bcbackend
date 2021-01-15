package io.fusee

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication
import org.springframework.transaction.annotation.EnableTransactionManagement
import org.springframework.transaction.annotation.Transactional


@SpringBootApplication
@EnableTransactionManagement(proxyTargetClass = true)
class Application

fun main(args: Array<String>) {
    runApplication<Application>(*args)
}
