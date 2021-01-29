package de.bluecat.entity

import com.fasterxml.jackson.databind.JsonNode
import com.vladmihalcea.hibernate.type.json.JsonBinaryType
import org.hibernate.annotations.Type
import org.hibernate.annotations.TypeDef
import java.util.*
import javax.persistence.*


@Entity
@Table(name = "auction")
@TypeDef(name = "jsonb", typeClass = JsonBinaryType::class)
open class Auction {
    @get:Id
    @get:GeneratedValue
    @get:Column(name = "id")
    open var id: UUID? = null

    @get:ManyToOne
    @get:JoinColumn(name = "fk_auction_house_location")
    open lateinit var auctionHouseLocation: AuctionHouseLocation

    @get:ManyToOne
    @get:JoinColumn(name = "fk_catalog_file")
    open var catalogFile: File? = null

    @get:ManyToOne
    @get:JoinColumn(name = "fk_result_file")
    open var resultFile: File? = null

    @get:Column(name = "date_from")
    open var dateFrom: Date? = null

    @get:Column(name = "date_to")
    open var dateTo: Date? = null

    @get:Column(name = "title")
    open var title: String? = null

    @get:Column(name = "comment")
    open var comment: String? = null

    @get:Column(name = "codename")
    open var codename: String? = null

    @get:Column(name = "total_lots")
    open var totalLots: Int? = null

    @get:Column(name = "sale_total")
    open var saleTotal: Int? = null

    @get:Column(name = "url")
    open var url: String? = null

    @get:Column(name = "was_crawled")
    open var wasCrawled: Boolean? = null

    @get:Column(name = "web_record", columnDefinition = "jsonb")
    @get:Type(type = "jsonb")
    open var webRecord: JsonNode? = null

    @get:Column(name = "filemaker_record", columnDefinition = "jsonb")
    @get:Type(type = "jsonb")
    open var filemakerRecord: JsonNode? = null

    @get:Column(name = "is_online_only")
    open var isOnlineOnly: Boolean? = null

    @get:Column(name = "requires_manual_attention")
    open var requiresManualAttention: Boolean? = null

    @get:Column(name = "filemaker_id")
    open var filemakerId: UUID? = null

    @get:Column(name = "was_only_source_filemaker")
    open var wasOnlySourceFilemaker: Boolean? = null
}
