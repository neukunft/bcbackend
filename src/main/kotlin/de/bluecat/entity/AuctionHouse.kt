package de.bluecat.entity

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "auction_house")
open class AuctionHouse {

    @get:Id
    @get:GeneratedValue
    @get:Column(name = "id")
    open var id: UUID? = null

    @get:OneToMany(mappedBy = "auctionHouse")
    open var auctionHouseLocations = mutableListOf<AuctionHouseLocation>()

    @get:Column(name = "name")
    open var name: String? = null

    @get:Column(name = "description")
    open var description: String? = null

    @get:Column(name = "url")
    open var url: String? = null

}
