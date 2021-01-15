package io.fusee.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import io.fusee.entity.Location
import io.fusee.repository.LocationRepository
import org.springframework.stereotype.Component

@Component
class LocationQueryResolver(
    private val locationRepository: LocationRepository
): GraphQLQueryResolver {

    fun getLocations(): List<Location> {
        return locationRepository.findAll()
    }
}
