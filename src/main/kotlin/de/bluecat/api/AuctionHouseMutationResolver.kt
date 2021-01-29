package de.bluecat.api

import com.coxautodev.graphql.tools.GraphQLMutationResolver
import de.bluecat.entity.AuctionHouse
import de.bluecat.repository.AuctionHouseRepository
import org.springframework.stereotype.Component
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Component
class AuctionHouseMutationResolver(
    private val auctionHouseRepository: AuctionHouseRepository
): GraphQLMutationResolver {

    fun setAuctionHouse(name: String, url: String?, description: String?): UUID? {
        val newAuctionHouse = AuctionHouse()
        newAuctionHouse.name = name
        newAuctionHouse.url = url
        newAuctionHouse.description = description
        return auctionHouseRepository.save(newAuctionHouse).id
    }
}
