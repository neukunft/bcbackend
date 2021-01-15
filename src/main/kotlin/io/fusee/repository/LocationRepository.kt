package io.fusee.repository

import io.fusee.entity.Location
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import org.springframework.transaction.annotation.Transactional
import java.util.*

@Repository
@Transactional
interface LocationRepository : JpaRepository<Location, UUID>
