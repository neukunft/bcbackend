package de.bluecat.entity

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "file_name")
class FileName(
    @Id
    @GeneratedValue
    @Column(name = "id")
    var id: UUID? = null,

    @ManyToOne
    @JoinColumn(name = "fk_file")
    var file: File,

    @Column(name = "original_filepath")
    var originalFilepath: String,

    @Column(name = "original_filename")
    var originalFilename: String,

    @Column(name = "original_extension")
    var originalExtension: String
)
//
//open class FileName {
//    @get:Id
//    @get:GeneratedValue
//    @get:Column(name = "id")
//    open var id: UUID? = null
//
//    @get:ManyToOne
//    @get:JoinColumn(name = "fk_file")
//    open lateinit var file: File
//
//    @get:Column(name = "original_filepath")
//    open var originalFilepath: String? = null
//
//    @get:Column(name = "original_filename")
//    open var originalFilename: String? = null
//
//    @get:Column(name = "original_extension")
//    open var originalExtension: String? = null
//}
