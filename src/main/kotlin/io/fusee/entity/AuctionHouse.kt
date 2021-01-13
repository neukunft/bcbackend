package io.fusee.entity

import org.jetbrains.exposed.dao.UUIDEntity
import org.jetbrains.exposed.dao.UUIDEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import org.jetbrains.exposed.dao.id.UUIDTable
import java.util.*

object AuctionHouseTable : UUIDTable("auction_house") {
    val name = text("name").uniqueIndex()
    val description = text("description").nullable()
    val url = text("url").nullable().uniqueIndex()
}

class AuctionHouse(id: EntityID<UUID>): UUIDEntity(id) {
    companion object: UUIDEntityClass<AuctionHouse>(AuctionHouseTable)

    var name by AuctionHouseTable.name
    var description by AuctionHouseTable.description
    var url by AuctionHouseTable.url
}
