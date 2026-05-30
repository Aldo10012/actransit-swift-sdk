@testable import ACTransitSwift
import Foundation
import Testing

@Suite("Test TimePointInstruction")
final class TimePointInstructionTests {
    @Test("sample sanity check")
    func sampleSanityCheck() {
        let sample = TimePointInstruction.sample
        #expect(sample.tripId == 11_861_464)
        #expect(sample.sequence == 1)
        #expect(sample.latitude == 37.9135)
        #expect(sample.longitude == -122.3022)
    }

    @Test("make() applies overrides independently")
    func makeOverridesIndependently() {
        let result = TimePointInstruction.make(sequence: 5)
        #expect(result.sequence == 5)
        #expect(result.instruction == TimePointInstruction.sample.instruction)
        #expect(result.tripId == TimePointInstruction.sample.tripId)
        #expect(result.latitude == TimePointInstruction.sample.latitude)
        #expect(result.longitude == TimePointInstruction.sample.longitude)
    }
}
