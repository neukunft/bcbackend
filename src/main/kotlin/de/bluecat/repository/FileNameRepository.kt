package de.bluecat.repository

import de.bluecat.entity.FileName
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface FileNameRepository : JpaRepository<FileName, UUID>
