package de.bluecat.api.files

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.FileName
import de.bluecat.repository.FileNameRepository
import org.springframework.stereotype.Component

@Component
class FileNameQueryResolver(
    private val fileNameRepository: FileNameRepository
): GraphQLQueryResolver {

    fun getFileNames(): List<FileName> {
        return fileNameRepository.findAll()
    }

}
