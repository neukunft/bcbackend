package io.fusee

import io.fusee.entity.AuctionHouseLocationTable
import io.fusee.entity.AuctionHouseTable
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
//        SchemaUtils.drop(AuctionHouseTable, AuctionHouseLocationTable)
//        SchemaUtils.create(AuctionHouseTable, AuctionHouseLocationTable)
        SchemaUtils.createMissingTablesAndColumns(AuctionHouseTable, AuctionHouseLocationTable)
    }

    runApplication<Application>(*args)
}
