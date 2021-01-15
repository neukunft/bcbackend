package io.fusee.entity

import java.util.*
import javax.persistence.*


@Entity
@Table(name = "auction")
open class Auction {
    @get:Id
    @get:GeneratedValue
    @get:Column(name = "id")
    open var id: UUID? = null

    @get:Column(name = "date_from")
    open var dateFrom: Date? = null
}
