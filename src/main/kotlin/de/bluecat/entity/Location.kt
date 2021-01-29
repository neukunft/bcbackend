package de.bluecat.entity

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "location")
open class Location {

    @get:Id
    @get:GeneratedValue
    @get:Column(name = "id")
    open var id: UUID? = null

    @get:OneToMany(mappedBy = "location")
    open var auctionHouseLocations = mutableListOf<AuctionHouseLocation>()

    @Column(name = "city")
    open var city: String? = null

    @Column(name = "country")
    open var country: String? = null

    @Column(name = "base_currency")
    open var baseCurrency: String? = null

}
