package de.bluecat.repository

import de.bluecat.entity.AuctionHouse
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
interface AuctionHouseRepository : JpaRepository<AuctionHouse, UUID>
