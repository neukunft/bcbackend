package de.bluecat.repository

import de.bluecat.entity.Location
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
interface LocationRepository : JpaRepository<Location, UUID>
