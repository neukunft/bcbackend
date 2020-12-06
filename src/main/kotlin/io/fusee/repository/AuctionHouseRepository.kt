package io.fusee.repository

import io.fusee.entity.AuctionHouseRecord
import io.fusee.entity.AuctionHouseTable
import io.fusee.entity.rowToAuctionHouseRecord
import org.jetbrains.exposed.sql.Database
import org.jetbrains.exposed.sql.insert
import org.jetbrains.exposed.sql.selectAll
import org.jetbrains.exposed.sql.transactions.transaction
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service
import java.util.*

@Repository
@Service
class AuctionHouseRepository {

    fun findAll(): List<AuctionHouseRecord> {
        val list = mutableListOf<AuctionHouseRecord>()
        transaction {
            for (auctionHouseRecord in AuctionHouseTable.selectAll()) {
                val auctionHouse = AuctionHouseTable.rowToAuctionHouseRecord(auctionHouseRecord)
                list.add(auctionHouse)
                println("Added Auction House: ${auctionHouse.name}, id: ${auctionHouse.id}")
            }
        }
        return list
    }

    fun addAuctionHouse(auctionHouseRecord: AuctionHouseRecord) {

        transaction {
            AuctionHouseTable.insert {
                it[id] = auctionHouseRecord.id
                it[name] = auctionHouseRecord.name
                it[url] = auctionHouseRecord.url
            }
        }

    }

}
