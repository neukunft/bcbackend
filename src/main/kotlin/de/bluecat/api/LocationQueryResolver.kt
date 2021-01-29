package de.bluecat.api

import com.coxautodev.graphql.tools.GraphQLQueryResolver
import de.bluecat.entity.Location
import de.bluecat.repository.LocationRepository
import org.springframework.stereotype.Component

@Component
class LocationQueryResolver(
    private val locationRepository: LocationRepository
): GraphQLQueryResolver {

    fun getLocations(): List<Location> {
        return locationRepository.findAll()
    }
}
