import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TimePointInstruction
public struct TimePointInstruction: Codable, Sendable {
    /// The instruction to take at a time point on a trip.
    public let instruction: String
    /// The Trip for which this timepoint and sequence are valid.
    public let tripId: Int
    /// The order this timepoint falls along the path for the given trip.
    public let sequence: Int
    public let latitude: Double
    public let longitude: Double

    public init(instruction: String, tripId: Int, sequence: Int, latitude: Double, longitude: Double) {
        self.instruction = instruction
        self.tripId = tripId
        self.sequence = sequence
        self.latitude = latitude
        self.longitude = longitude
    }

    enum CodingKeys: String, CodingKey {
        case instruction = "Instruction"
        case tripId = "TripId"
        case sequence = "Sequence"
        case latitude = "Latitude"
        case longitude = "Longitude"
    }

    // MARK: - Mock Data

    public static let sample = TimePointInstruction(
        instruction: "L\\ SAN PABLO AV",
        tripId: 11_861_464,
        sequence: 1,
        latitude: 37.9135,
        longitude: -122.3022
    )

    public static func make(
        instruction: String = sample.instruction,
        tripId: Int = sample.tripId,
        sequence: Int = sample.sequence,
        latitude: Double = sample.latitude,
        longitude: Double = sample.longitude
    ) -> TimePointInstruction {
        TimePointInstruction(instruction: instruction, tripId: tripId, sequence: sequence, latitude: latitude, longitude: longitude)
    }
}

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=TripInstruction
public struct TripInstruction: Codable, Sendable {
    /// The operator driving instructions at each time point.
    public let timePoints: [TimePointInstruction]?
    /// The operator driving instructions as text.
    public let instructionsText: String
    public let tripId: Int
    /// The route which this trip is currently running
    public let routeName: String
    /// The schedule for which this trip is being run
    public let scheduleType: TripScheduleType
    /// The scheduled start time for the trip. The date portion is always `2000-01-01`; only the time component is meaningful.
    public let startTime: String
    /// The direction the current trip is heading
    public let direction: String

    public init(
        timePoints: [TimePointInstruction]?,
        instructionsText: String,
        tripId: Int,
        routeName: String,
        scheduleType: TripScheduleType,
        startTime: String,
        direction: String
    ) {
        self.timePoints = timePoints
        self.instructionsText = instructionsText
        self.tripId = tripId
        self.routeName = routeName
        self.scheduleType = scheduleType
        self.startTime = startTime
        self.direction = direction
    }

    enum CodingKeys: String, CodingKey {
        case timePoints = "TimePoints"
        case instructionsText = "InstructionsText"
        case tripId = "TripId"
        case routeName = "RouteName"
        case scheduleType = "ScheduleType"
        case startTime = "StartTime"
        case direction = "Direction"
    }

    // MARK: - Mock Data

    public static let sample = TripInstruction(
        timePoints: nil,
        instructionsText: "VIA CAMPUS DR, INTO MISSION BELL DR, R\\ COLLEGE LN, L\\ SAN PABLO AV",
        tripId: 11_861_464,
        routeName: "72",
        scheduleType: .weekday,
        startTime: "2000-01-01T04:52:00",
        direction: "Southbound"
    )

    public static let minimal = TripInstruction(
        timePoints: nil,
        instructionsText: "",
        tripId: 0,
        routeName: "",
        scheduleType: .weekday,
        startTime: "",
        direction: ""
    )

    public static func make(
        timePoints: [TimePointInstruction]? = sample.timePoints,
        instructionsText: String = sample.instructionsText,
        tripId: Int = sample.tripId,
        routeName: String = sample.routeName,
        scheduleType: TripScheduleType = sample.scheduleType,
        startTime: String = sample.startTime,
        direction: String = sample.direction
    ) -> TripInstruction {
        TripInstruction(
            timePoints: timePoints,
            instructionsText: instructionsText,
            tripId: tripId,
            routeName: routeName,
            scheduleType: scheduleType,
            startTime: startTime,
            direction: direction
        )
    }
}
