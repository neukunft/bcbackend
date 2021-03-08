package de.bluecat.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.AuctionHouse
import de.bluecat.repository.AuctionHouseRepository
import org.springframework.stereotype.Component
import java.lang.Exception
import java.util.*

@Component
class AuctionHouseQueryResolver(
    private val auctionHouseRepository: AuctionHouseRepository
) : GraphQLQueryResolver {

    fun getAuctionHouses(): List<AuctionHouse> = auctionHouseRepository
        .findAll()

    fun getAuctionHouse(id: UUID): AuctionHouse = auctionHouseRepository
        .findById(id)
        .orElseThrow { Exception("Can not find auction with id: $id") }

}
