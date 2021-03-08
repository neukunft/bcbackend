package de.bluecat.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.Auction
import de.bluecat.helper.parseISODate
import de.bluecat.repository.AuctionRepository
import org.springframework.data.domain.PageRequest
import org.springframework.data.domain.Sort
import org.springframework.stereotype.Component
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.util.*
import java.time.Instant

import java.time.temporal.TemporalAccessor




@Component
class AuctionQueryResolver(
    private val auctionRepository: AuctionRepository
) : GraphQLQueryResolver {

    fun getAuctions(count: Int, offset: Int): MutableIterable<Auction> = auctionRepository
        .findAll(PageRequest.of(offset, count, Sort.by(Sort.Direction.DESC, "dateFrom")))

    fun getUpcomingAuctions(date: String): MutableIterable<Auction> {
        val tempDate = parseISODate(date)
        return auctionRepository.findByDateFromGreaterThan(tempDate)
    }

    fun getAuction(id: UUID): Auction = auctionRepository
        .findById(id)
        .orElseThrow { Exception("Can not find auction with id: $id") }

}
