package io.fusee.repository

import io.fusee.entity.AuctionHouse
import io.fusee.entity.AuctionHouseTable
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.sql.transactions.transaction
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service
import java.util.*

@Repository
@Service
class AuctionHouseRepository {

    fun findAll(): List<AuctionHouse> {
        return transaction {
            AuctionHouse.all().toList()
        }
    }

    fun addAuctionHouse(name: String, url: String?, description: String?): EntityID<UUID> {

        var new: EntityID<UUID>? = null

        return transaction {
             AuctionHouse.new {
                this.name = name
                this.url = url
                this.description = description
            }.id
        }

//        return new?.value
    }

}
