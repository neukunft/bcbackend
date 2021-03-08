package de.bluecat.api.files

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.File
import de.bluecat.repository.FileRepository
import org.springframework.stereotype.Component
import java.lang.Exception
import java.util.*

@Component
class FileQueryResolver(
    private val fileRepository: FileRepository
): GraphQLQueryResolver {

    fun getFiles(): MutableIterable<File> = fileRepository.findAll()

    fun getFile(id: UUID): File = fileRepository
        .findById(id)
        .orElseThrow { Exception("Can not find file with id: $id") }

}
