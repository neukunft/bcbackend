package io.fusee.entity

import org.jetbrains.exposed.dao.UUIDEntity
import org.jetbrains.exposed.dao.UUIDEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.UUIDTable
import java.util.*

object AuctionHouseLocationTable: UUIDTable("auction_house_location") {
    val auctionHouse = reference("fk_auction_house", AuctionHouseTable)
    val locationDetail = text("location_detail").nullable()
}

class AuctionHouseLocation(id: EntityID<UUID>): UUIDEntity(id) {
    companion object: UUIDEntityClass<AuctionHouseLocation>(AuctionHouseLocationTable)

    var auctionHouse by AuctionHouse referencedOn AuctionHouseLocationTable.auctionHouse
    var locationDetail by AuctionHouseLocationTable.locationDetail
}
