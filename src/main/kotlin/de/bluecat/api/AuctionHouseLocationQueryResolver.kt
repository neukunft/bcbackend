package de.bluecat.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.AuctionHouseLocation
import de.bluecat.repository.AuctionHouseLocationRepository
import org.springframework.stereotype.Component

@Component
class AuctionHouseLocationQueryResolver(
    private val auctionHouseLocationRepository: AuctionHouseLocationRepository
): GraphQLQueryResolver {

    fun getAuctionHouseLocations(): List<AuctionHouseLocation> {
        return auctionHouseLocationRepository.findAll()
    }

}
