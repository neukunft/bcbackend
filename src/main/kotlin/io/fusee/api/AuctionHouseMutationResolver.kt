package io.fusee.api

import com.coxautodev.graphql.tools.GraphQLMutationResolver
import io.fusee.entity.AuctionHouseRecord
import io.fusee.repository.AuctionHouseRepository
import org.springframework.stereotype.Component
import java.util.*

@Component
class AuctionHouseMutationResolver(
    private val auctionHouseRepository: AuctionHouseRepository
): GraphQLMutationResolver {

    fun setAuctionHouse(name: String, url: String, description: String): UUID {
        val auctionHouseRecord = AuctionHouseRecord(id = UUID.randomUUID(), name = name, url = url, description = description)
        auctionHouseRepository.addAuctionHouse(auctionHouseRecord)
        return auctionHouseRecord.id
    }
}
