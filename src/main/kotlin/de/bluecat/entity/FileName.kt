package de.bluecat.entity

import java.util.*
import javax.persistence.*

@Entity
@Table(name = "file_name")
open class FileName {
    @get:Id
    @get:GeneratedValue
    @get:Column(name = "id")
    open var id: UUID? = null

    @get:ManyToOne
    @get:JoinColumn(name = "fk_file")
    open lateinit var file: File

    @get:Column(name = "original_filepath")
    open var originalFilepath: String? = null

    @get:Column(name = "original_filename")
    open var originalFilename: String? = null

    @get:Column(name = "original_extension")
    open var originalExtension: String? = null
}
