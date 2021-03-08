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
class Auction(
    @Id
    @GeneratedValue
    @Column(name = "id")
    var id: UUID,

    @ManyToOne
    @JoinColumn(name = "fk_auction_house_location")
    var auctionHouseLocation: AuctionHouseLocation,

//    @ManyToOne
//    @JoinColumn(name = "fk_catalog_file")
//    var catalogFile: File? = null,
//
//    @ManyToOne
//    @JoinColumn(name = "fk_result_file")
//    var resultFile: File? = null,

    @Column(name = "date_from")
    var dateFrom: Date?,

    @Column(name = "date_to")
    var dateTo: Date?,

    @Column(name = "title")
    var title: String?,

    @Column(name = "comment")
    var comment: String?,

    @Column(name = "codename")
    var codename: String?,

    @Column(name = "total_lots")
    var totalLots: Int?,

    @Column(name = "sale_total")
    var saleTotal: Int?,

    @Column(name = "url")
    var url: String?,

    @Column(name = "was_crawled")
    var wasCrawled: Boolean?,

    @Column(name = "web_record", columnDefinition = "jsonb")
    @Type(type = "jsonb")
    var webRecord: JsonNode?,

    @Column(name = "filemaker_record", columnDefinition = "jsonb")
    @Type(type = "jsonb")
    var filemakerRecord: JsonNode?,

    @Column(name = "is_online_only")
    var isOnlineOnly: Boolean?,

    @Column(name = "requires_manual_attention")
    var requiresManualAttention: Boolean?,

    @Column(name = "filemaker_id")
    var filemakerId: UUID?,

    @Column(name = "was_only_source_filemaker")
    var wasOnlySourceFilemaker: Boolean?
)
