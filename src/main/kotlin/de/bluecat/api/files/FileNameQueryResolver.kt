package de.bluecat.api.files

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.File
import de.bluecat.entity.FileName
import de.bluecat.repository.FileNameRepository
import org.springframework.stereotype.Component
import java.lang.Exception
import java.util.*

@Component
class FileNameQueryResolver(
    private val fileNameRepository: FileNameRepository
): GraphQLQueryResolver {

    fun getFileNames(): List<FileName> = fileNameRepository.findAll()

    fun getFilename(id: UUID): FileName = fileNameRepository
        .findById(id)
        .orElseThrow { Exception("Can not find file with id: $id") }


}
