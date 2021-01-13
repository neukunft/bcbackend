package io.fusee.repository

import io.fusee.entity.AuctionHouse
import io.fusee.entity.AuctionHouseLocation
import io.fusee.entity.AuctionHouseTable
import org.jetbrains.exposed.dao.with
import org.jetbrains.exposed.sql.transactions.transaction
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Repository
@Service
class AuctionHouseLocationRepository {

    fun findAll(): List<AuctionHouseLocation> {
        val list = mutableListOf<AuctionHouseLocation>()
        transaction {
            for (auctionHouseLocation in AuctionHouseLocation.all()) {
                println("Added ${auctionHouseLocation.locationDetail} for ${auctionHouseLocation.auctionHouse.name}")
                list.add(auctionHouseLocation)
            }
        }

        return list

//        return transaction {
//            AuctionHouseLocation.all().toList()
//        }
    }

}
