package io.fusee.repository

import io.fusee.entity.AuctionHouseLocation
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
@Transactional
interface AuctionHouseLocationRepository : JpaRepository<AuctionHouseLocation, UUID>
