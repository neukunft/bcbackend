package de.bluecat.repository

import de.bluecat.entity.AuctionHouseLocation
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface AuctionHouseLocationRepository : JpaRepository<AuctionHouseLocation, UUID>
