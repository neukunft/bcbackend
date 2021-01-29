package de.bluecat.entity

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "file")
open class File {
    @get:Id
    @get:GeneratedValue
    @get:Column(name = "id")
    open var id: UUID? = null

    @get:OneToMany(mappedBy = "file")
    open var fileNames = mutableListOf<FileName>()

//    @get:OneToMany(mappedBy = "catalogFile")
//    open var auctionsByCatalog = mutableListOf<Auction>()
//
//    @get:OneToMany(mappedBy = "resultFile")
//    open var auctionsByResult = mutableListOf<Auction>()

    @get:Column(name = "shasum256")
    open var shasum256: String? = null

    @get:Column(name = "filepath")
    open var filepath: String? = null

    @get:Column(name = "filename")
    open var filename: String? = null

    @get:Column(name = "extension")
    open var extension: String? = null

    @get:Column(name = "filetype")
    open var filetype: String? = null

    @get:Column(name = "filesize")
    open var filesize: Integer? = null

    @get:Column(name = "mime_type")
    open var mimeType: String? = null

}
