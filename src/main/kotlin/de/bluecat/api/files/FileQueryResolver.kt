package de.bluecat.api.files

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.File
import de.bluecat.repository.FileRepository
import org.springframework.stereotype.Component

@Component
class FileQueryResolver(
    private val fileRepository: FileRepository
): GraphQLQueryResolver {

    fun getFiles(): List<File> {
        return fileRepository.findAll()
    }

}
