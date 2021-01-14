package io.fusee.repository

import io.fusee.entity.AuctionHouseLocation
import org.springframework.stereotype.Repository
import org.springframework.stereotype.Service
import org.springframework.transaction.annotation.Transactional

@Repository
@Service
@Transactional
class AuctionHouseLocationRepository {

    fun findAll(): List<AuctionHouseLocation> {
        val list = AuctionHouseLocation.all().toList()
        for (auctionHouseLocation in list) {
            println("Auction House name ${auctionHouseLocation.auctionHouse.name}")
        }
        return list
    }


}
