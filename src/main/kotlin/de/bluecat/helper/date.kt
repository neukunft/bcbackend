package de.bluecat.helper

import java.time.Instant
import java.time.format.DateTimeFormatter
import java.util.*

fun parseISODate(dateInput: String): Date {
    val timeFormatter = DateTimeFormatter.ISO_DATE_TIME
    val accessor = timeFormatter.parse(dateInput)
    return Date.from(Instant.from(accessor))
}
