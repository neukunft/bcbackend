package io.fusee.entity

import org.jetbrains.exposed.dao.UUIDEntity
import org.jetbrains.exposed.dao.UUIDEntityClass
import org.jetbrains.exposed.dao.id.EntityID
import java.util.*


class AuctionHouse(id: EntityID<UUID>): UUIDEntity(id) {
    companion object: UUIDEntityClass<AuctionHouse>(AuctionHouses)

    var name by AuctionHouses.name
    var description by AuctionHouses.description
    var url by AuctionHouses.url
    var someThingNew by AuctionHouses.someThingNew
}
