package de.bluecat.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.Auction
import de.bluecat.repository.AuctionRepository
import org.springframework.stereotype.Component

@Component
class AuctionQueryResolver(
    private val auctionRepository: AuctionRepository
): GraphQLQueryResolver {

    fun getAuctions(): List<Auction> {
        return auctionRepository.findAll()
    }
}
