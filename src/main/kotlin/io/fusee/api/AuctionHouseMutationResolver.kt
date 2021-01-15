package io.fusee.api

import com.coxautodev.graphql.tools.GraphQLMutationResolver
import io.fusee.entity.AuctionHouse
import io.fusee.repository.AuctionHouseRepository
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
