package de.bluecat.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.AuctionHouseLocation
import de.bluecat.repository.AuctionHouseLocationRepository
import org.springframework.stereotype.Component
import java.util.*

@Component
class AuctionHouseLocationQueryResolver(
    private val auctionHouseLocationRepository: AuctionHouseLocationRepository
) : GraphQLQueryResolver {

    fun getAuctionHouseLocations(): List<AuctionHouseLocation> = auctionHouseLocationRepository
        .findAll()

    fun getAuctionHouseLocation(id: UUID): AuctionHouseLocation = auctionHouseLocationRepository
        .findById(id)
        .orElseThrow { Exception("Can not find auctionHouseLocation with id: $id") }

}
