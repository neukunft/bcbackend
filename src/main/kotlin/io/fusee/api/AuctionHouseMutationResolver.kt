package io.fusee.api

import com.coxautodev.graphql.tools.GraphQLMutationResolver
import io.fusee.repository.AuctionHouseRepository
import org.springframework.stereotype.Component
import java.util.*

@Component
class AuctionHouseMutationResolver(
    private val auctionHouseRepository: AuctionHouseRepository
): GraphQLMutationResolver {

    fun setAuctionHouse(name: String, url: String, description: String?): UUID? {
        return auctionHouseRepository.addAuctionHouse(name, url, description)
    }
}
