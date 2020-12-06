package io.fusee.entity

import org.jetbrains.exposed.dao.id.UUIDTable

object AuctionHouses : UUIDTable("auction_house") {
    val name = text("name").uniqueIndex()
    val description = text("description").nullable()
    val url = text("url").uniqueIndex()
    val someThingNew = varchar("some_thing_new", 40).nullable()
}
