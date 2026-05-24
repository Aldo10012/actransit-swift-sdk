@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TripInstruction")
final class TripInstructionTests {
    @Test("TimePointInstruction sample sanity check")
    func timePointInstructionSample() {
        let sample = TimePointInstruction.sample
        #expect(sample.tripId == 11_861_464)
        #expect(sample.sequence == 1)
        #expect(sample.latitude == 37.9135)
        #expect(sample.longitude == -122.3022)
    }

    @Test("TimePointInstruction make() applies overrides independently")
    func timePointInstructionMakeOverrides() {
        let result = TimePointInstruction.make(sequence: 5)
        #expect(result.sequence == 5)
        #expect(result.instruction == TimePointInstruction.sample.instruction)
        #expect(result.tripId == TimePointInstruction.sample.tripId)
        #expect(result.latitude == TimePointInstruction.sample.latitude)
        #expect(result.longitude == TimePointInstruction.sample.longitude)
    }

    @Test("TripInstruction make() applies overrides independently")
    func tripInstructionMakeOverrides() {
        let result = TripInstruction.make(tripId: 99999)
        #expect(result.tripId == 99999)
        #expect(result.routeName == TripInstruction.sample.routeName)
        #expect(result.scheduleType == TripInstruction.sample.scheduleType)
        #expect(result.startTime == TripInstruction.sample.startTime)
        #expect(result.direction == TripInstruction.sample.direction)
    }

    @Test("TripInstruction decodes with non-nil timePoints")
    func decodesWithTimePoints() throws {
        let json = """
        [
            {
                "TimePoints": [
                    {
                        "Instruction": "R SAN PABLO AV",
                        "TripId": 11861464,
                        "Sequence": 1,
                        "Latitude": 37.9135,
                        "Longitude": -122.3022
                    }
                ],
                "InstructionsText": "VIA CAMPUS DR",
                "TripId": 11861464,
                "RouteName": "72",
                "ScheduleType": 0,
                "StartTime": "2000-01-01T04:52:00",
                "Direction": "Southbound"
            }
        ]
        """
        let results = try JSONDecoder().decode([TripInstruction].self, from: Data(json.utf8))
        #expect(results.count == 1)
        #expect(results[0].timePoints?.count == 1)
        #expect(results[0].timePoints?[0].sequence == 1)
    }
}
