package io.fusee.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import io.fusee.entity.AuctionHouseLocation
import io.fusee.repository.AuctionHouseLocationRepository
import org.springframework.stereotype.Component

@Component
class AuctionHouseLocationQueryResolver(
    private val auctionHouseLocationRepository: AuctionHouseLocationRepository
): GraphQLQueryResolver {

    fun getAuctionHouseLocations(): List<AuctionHouseLocation> {
        return auctionHouseLocationRepository.findAll()
    }

}
