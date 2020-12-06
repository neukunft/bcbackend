package io.fusee

import io.fusee.entity.AuctionHouses
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.SchemaUtils
import org.jetbrains.exposed.sql.transactions.transaction
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class Application

fun main(args: Array<String>) {

//    SETUP DB
    Database.connect(url = "jdbc:postgresql://127.0.0.1:5439/fusee", user = "dbuser", password = "fuseE3000!")
    transaction {
        SchemaUtils.drop(AuctionHouses)
        SchemaUtils.create(AuctionHouses)
        SchemaUtils.createMissingTablesAndColumns(AuctionHouses)
    }

    runApplication<Application>(*args)
}
