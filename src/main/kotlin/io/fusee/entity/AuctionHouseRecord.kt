package io.fusee.entity

import org.jetbrains.exposed.sql.ResultRow
import org.jetbrains.exposed.sql.Table
import java.util.*

object AuctionHouseTable : Table("auction_house") {
    val id = uuid("id")
    override val primaryKey: PrimaryKey = PrimaryKey(id, name = "auction_house_pkey")
    val name = text("name").uniqueIndex()
    val description = text("description").nullable()
    val url = text("url").uniqueIndex()
    val someThingNew = varchar("some_thing_new", 40).nullable()
}

data class AuctionHouseRecord(
    val id: UUID,
    val name: String,
    val description: String?,
    val url: String
)

fun AuctionHouseTable.rowToAuctionHouseRecord(row: ResultRow): AuctionHouseRecord =
    AuctionHouseRecord(
        id = row[id],
        name = row[name],
        description = row[description],
        url = row[url],
    )

