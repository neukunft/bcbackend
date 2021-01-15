package io.fusee.entity

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "auction_house_location")
open class AuctionHouseLocation {

    @get:Id
    @get:GeneratedValue
    @get:Column(name = "id")
    open var id: UUID? = null

    @Column(name = "location_detail")
    open var locationDetail: String? = null

    @get:ManyToOne
    @get:JoinColumn(name = "fk_auction_house")
    open lateinit var auctionHouse: AuctionHouse

    @get:ManyToOne
    @get:JoinColumn(name = "fk_location")
    open lateinit var location: Location

}
