package io.fusee.repository

import io.fusee.entity.AuctionHouse
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.sql.transactions.transaction
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service
import java.util.*

@Repository
@Service
class AuctionHouseRepository {

    fun findAll(): List<AuctionHouse> {
        val list = mutableListOf<AuctionHouse>()
        transaction {
            for (auctionHouse in AuctionHouse.all()) {
                list.add(auctionHouse)
                println("Added Auction House: ${auctionHouse.name}, id: ${auctionHouse.id}")
            }
        }
        return list
    }

    fun addAuctionHouse(name: String, url: String, description: String?): UUID? {

        var new: EntityID<UUID>? = null

        transaction {
            new = AuctionHouse.new {
                this.name = name
                this.url = url
                this.description = description
            }.id
        }

        return new?.value
    }

}
