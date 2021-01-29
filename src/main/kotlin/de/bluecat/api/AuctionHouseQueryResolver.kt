package de.bluecat.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.AuctionHouse
import de.bluecat.repository.AuctionHouseRepository
import org.springframework.stereotype.Component

@Component
class AuctionHouseQueryResolver(
    private val auctionHouseRepository: AuctionHouseRepository
): GraphQLQueryResolver {

    fun getAuctionHouses(): List<AuctionHouse> {
        return auctionHouseRepository.findAll()
    }

}
