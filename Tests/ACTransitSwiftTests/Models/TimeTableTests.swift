@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimeTable")
final class TimeTableTests {
    @Test("TimeTableTripStop make() applies overrides independently")
    func timeTableTripStopMakeOverrides() {
        let result = TimeTableTripStop.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.passingTime == TimeTableTripStop.sample.passingTime)
    }

    @Test("TimeTableStop make() applies overrides independently")
    func timeTableStopMakeOverrides() {
        let result = TimeTableStop.make(stopId: 99999)
        #expect(result.stopId == 99999)
        #expect(result.stopDescription == TimeTableStop.sample.stopDescription)
        #expect(result.placeId == TimeTableStop.sample.placeId)
        #expect(result.stopLongitude == TimeTableStop.sample.stopLongitude)
        #expect(result.stopLatitude == TimeTableStop.sample.stopLatitude)
    }

    @Test("TimeTableTrip make() applies overrides independently")
    func timeTableTripMakeOverrides() {
        let result = TimeTableTrip.make(tripId: 99999)
        #expect(result.tripId == 99999)
        #expect(result.tripStartTime == TimeTableTrip.sample.tripStartTime)
        #expect(result.tripDestination == TimeTableTrip.sample.tripDestination)
        #expect(result.tripStops.count == TimeTableTrip.sample.tripStops.count)
    }

    @Test("TimeTable make() applies overrides independently")
    func timeTableMakeOverrides() {
        let result = TimeTable.make(routeId: "51")
        #expect(result.routeId == "51")
        #expect(result.bookingId == TimeTable.sample.bookingId)
        #expect(result.destination == TimeTable.sample.destination)
        #expect(result.direction == TimeTable.sample.direction)
        #expect(result.dayCode == TimeTable.sample.dayCode)
    }
}
