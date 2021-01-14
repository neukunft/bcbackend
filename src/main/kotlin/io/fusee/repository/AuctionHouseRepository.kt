package io.fusee.repository

import io.fusee.entity.AuctionHouse
import io.fusee.entity.AuctionHouseTable
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.sql.transactions.transaction
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
@Service
@Transactional
class AuctionHouseRepository {

    fun findAll(): List<AuctionHouse> {
        return AuctionHouse.all().toList()
    }

    fun addAuctionHouse(name: String, url: String?, description: String?): EntityID<UUID> {
        return AuctionHouse.new {
                this.name = name
                this.url = url
                this.description = description
            }.id
    }

    fun findOne(id: UUID): AuctionHouse? {
        return AuctionHouse.findById(id)
    }

}
