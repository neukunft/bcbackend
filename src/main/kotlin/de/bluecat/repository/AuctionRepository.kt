package de.bluecat.repository

import de.bluecat.entity.Auction
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface AuctionRepository : JpaRepository<Auction, UUID> {

    fun findByDateFromGreaterThan(date: Date): MutableIterable<Auction>
}


