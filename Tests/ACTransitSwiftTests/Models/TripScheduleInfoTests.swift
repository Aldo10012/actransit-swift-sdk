@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripScheduleInfo")
final class TripScheduleInfoTests {
    @Test("RouteProfile make() applies overrides independently")
    func routeProfileMakeOverrides() {
        let result = RouteProfile.make(routeId: "1T")
        #expect(result.routeId == "1T")
        #expect(result.profile == RouteProfile.sample.profile)
    }

    @Test("ServiceException make() applies overrides independently")
    func serviceExceptionMakeOverrides() {
        let result = ServiceException.make(exceptionCode: "EX999")
        #expect(result.exceptionCode == "EX999")
        #expect(result.patternId == ServiceException.sample.patternId)
        #expect(result.tripId == ServiceException.sample.tripId)
        #expect(result.operatingDays == ServiceException.sample.operatingDays)
        #expect(result.exceptionDates == ServiceException.sample.exceptionDates)
        #expect(result.exceptionNotices == ServiceException.sample.exceptionNotices)
    }

    @Test("DateException make() applies overrides independently")
    func dateExceptionMakeOverrides() {
        let result = DateException.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.serviceExceptions.count == DateException.sample.serviceExceptions.count)
    }

    @Test("TripScheduleStop make() applies overrides independently")
    func tripScheduleStopMakeOverrides() {
        let result = TripScheduleStop.make(stopId: "99999")
        #expect(result.stopId == "99999")
        #expect(result.placeName == TripScheduleStop.sample.placeName)
        #expect(result.placeId == TripScheduleStop.sample.placeId)
        #expect(result.stopDescription == TripScheduleStop.sample.stopDescription)
        #expect(result.longitude == TripScheduleStop.sample.longitude)
        #expect(result.latitude == TripScheduleStop.sample.latitude)
        #expect(result.city == TripScheduleStop.sample.city)
    }

    @Test("TripScheduleStopTime make() applies overrides independently")
    func tripScheduleStopTimeMakeOverrides() {
        let result = TripScheduleStopTime.make(stopTime: "06:00:00")
        #expect(result.stopTime == "06:00:00")
        #expect(result.stopId == TripScheduleStopTime.sample.stopId)
        #expect(result.placeId == TripScheduleStopTime.sample.placeId)
        #expect(result.occupancy == TripScheduleStopTime.sample.occupancy)
    }

    @Test("TripScheduleTrip make() applies overrides independently")
    func tripScheduleTripMakeOverrides() {
        let result = TripScheduleTrip.make(startTime: "06:00:00")
        #expect(result.startTime == "06:00:00")
        #expect(result.patternId == TripScheduleTrip.sample.patternId)
        #expect(result.tripId == TripScheduleTrip.sample.tripId)
        #expect(result.status == TripScheduleTrip.sample.status)
        #expect(result.stopTimes.count == TripScheduleTrip.sample.stopTimes.count)
    }

    @Test("TripScheduleRoute make() applies overrides independently")
    func tripScheduleRouteMakeOverrides() {
        let result = TripScheduleRoute.make(routeId: "51A")
        #expect(result.routeId == "51A")
        #expect(result.lineDirection == TripScheduleRoute.sample.lineDirection)
        #expect(result.lineDestination == TripScheduleRoute.sample.lineDestination)
        #expect(result.dayCode == TripScheduleRoute.sample.dayCode)
        #expect(result.operatingDOW == TripScheduleRoute.sample.operatingDOW)
        #expect(result.trips.count == TripScheduleRoute.sample.trips.count)
    }

    @Test("TripScheduleInfo make() applies overrides independently")
    func tripScheduleInfoMakeOverrides() {
        let result = TripScheduleInfo.make(bookingId: "2605FA")
        #expect(result.bookingId == "2605FA")
        #expect(result.routeProfiles.count == TripScheduleInfo.sample.routeProfiles.count)
        #expect(result.stops.count == TripScheduleInfo.sample.stops.count)
        #expect(result.routes.count == TripScheduleInfo.sample.routes.count)
    }
}
