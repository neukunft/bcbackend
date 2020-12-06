package io.fusee.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import io.fusee.entity.AuctionHouse
import io.fusee.repository.AuctionHouseRepository
import org.springframework.stereotype.Component

@Component
class AuctionHouseQueryResolver(
    private val auctionHouseRepository: AuctionHouseRepository
): GraphQLQueryResolver {

    fun getAuctionHouses(): List<AuctionHouse> {
        return auctionHouseRepository.findAll()
    }

}
