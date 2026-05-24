import Foundation

/// https://api.actransit.org/transit/Help/ResourceModel?modelName=VehicleCharacteristics
public struct VehicleCharacteristics: Codable, Sendable {
    /// Alphanumeric string representing the vehicle ID (ie. bus number).
    public let vehicleId: String
    /// Boolean value indicating if the vehicle is operative.
    public let isActive: Bool
    /// Contains a brief description of the vehicle such as maker and propulsion type.
    public let description: String
    /// Alphanumeric code categorizing the vehicle type.
    public let vehicleType: String
    /// Brief explanation of the vehicle's classification.
    public let vehicleTypeDescription: String
    /// String indicating the maker of the vehicle.
    public let manufacturer: String
    /// String indicating the serial number of the vehicle.
    public let serialNumber: String
    /// String indicating the license number of the vehicle (when available).
    public let licenseNumber: String?
    /// String value indicating the vehicle length in feet.
    public let length: String
    /// String value that represents the propulsion type of the vehicle - Fuel Cell, Diesel, Electric, etc.
    public let propulsionType: String
    /// Boolean value that indicates if the vehicle has WiFi available onboard.
    public let hasWiFi: Bool
    /// Boolean value that indicates if the vehicle has Air Conditioning onboard.
    public let hasAC: Bool
    /// Recommended standing passenger capacity per manufacturer specs.
    public let standingCapacity: String?
    /// Recommended seated passenger capacity per manufacturer specs.
    public let seatingCapacity: String?
    /// This numeric value indicates the actual number of passengers that the vehicle can carry as determined by the Transit Agency.
    public let limitCapacity: String

    public init(
        vehicleId: String,
        isActive: Bool,
        description: String,
        vehicleType: String,
        vehicleTypeDescription: String,
        manufacturer: String,
        serialNumber: String,
        licenseNumber: String?,
        length: String,
        propulsionType: String,
        hasWiFi: Bool,
        hasAC: Bool,
        standingCapacity: String?,
        seatingCapacity: String?,
        limitCapacity: String
    ) {
        self.vehicleId = vehicleId
        self.isActive = isActive
        self.description = description
        self.vehicleType = vehicleType
        self.vehicleTypeDescription = vehicleTypeDescription
        self.manufacturer = manufacturer
        self.serialNumber = serialNumber
        self.licenseNumber = licenseNumber
        self.length = length
        self.propulsionType = propulsionType
        self.hasWiFi = hasWiFi
        self.hasAC = hasAC
        self.standingCapacity = standingCapacity
        self.seatingCapacity = seatingCapacity
        self.limitCapacity = limitCapacity
    }

    enum CodingKeys: String, CodingKey {
        case vehicleId = "VehicleId"
        case isActive = "IsActive"
        case description = "Description"
        case vehicleType = "VehicleType"
        case vehicleTypeDescription = "VehicleTypeDescription"
        case manufacturer = "Make"
        case serialNumber = "SerialNumber"
        case licenseNumber = "LicenseNumber"
        case length = "Length"
        case propulsionType = "PropulsionType"
        case hasWiFi = "HasWiFi"
        case hasAC = "HasAC"
        case standingCapacity = "StandingCapacity"
        case seatingCapacity = "SeatingCapacity"
        case limitCapacity = "LimitCapacity"
    }

    // MARK: - Mock Data

    public static let sample = VehicleCharacteristics(
        vehicleId: "1505",
        isActive: true,
        description: "Gillig - Diesel",
        vehicleType: "40",
        vehicleTypeDescription: "Standard Bus",
        manufacturer: "Gillig",
        serialNumber: "12345",
        licenseNumber: "1234567",
        length: "40",
        propulsionType: "Diesel",
        hasWiFi: true,
        hasAC: true,
        standingCapacity: "30",
        seatingCapacity: "38",
        limitCapacity: "60"
    )

    public static let minimal = VehicleCharacteristics(
        vehicleId: "1505",
        isActive: true,
        description: "Gillig - Diesel",
        vehicleType: "40",
        vehicleTypeDescription: "Standard Bus",
        manufacturer: "Gillig",
        serialNumber: "12345",
        licenseNumber: nil,
        length: "40",
        propulsionType: "Diesel",
        hasWiFi: false,
        hasAC: false,
        standingCapacity: nil,
        seatingCapacity: nil,
        limitCapacity: "60"
    )

    public static func make(
        vehicleId: String = sample.vehicleId,
        isActive: Bool = sample.isActive,
        description: String = sample.description,
        vehicleType: String = sample.vehicleType,
        vehicleTypeDescription: String = sample.vehicleTypeDescription,
        manufacturer: String = sample.manufacturer,
        serialNumber: String = sample.serialNumber,
        licenseNumber: String? = sample.licenseNumber,
        length: String = sample.length,
        propulsionType: String = sample.propulsionType,
        hasWiFi: Bool = sample.hasWiFi,
        hasAC: Bool = sample.hasAC,
        standingCapacity: String? = sample.standingCapacity,
        seatingCapacity: String? = sample.seatingCapacity,
        limitCapacity: String = sample.limitCapacity
    ) -> VehicleCharacteristics {
        VehicleCharacteristics(
            vehicleId: vehicleId,
            isActive: isActive,
            description: description,
            vehicleType: vehicleType,
            vehicleTypeDescription: vehicleTypeDescription,
            manufacturer: manufacturer,
            serialNumber: serialNumber,
            licenseNumber: licenseNumber,
            length: length,
            propulsionType: propulsionType,
            hasWiFi: hasWiFi,
            hasAC: hasAC,
            standingCapacity: standingCapacity,
            seatingCapacity: seatingCapacity,
            limitCapacity: limitCapacity
        )
    }
}
