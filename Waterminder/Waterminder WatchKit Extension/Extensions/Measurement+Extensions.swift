import Foundation

extension Measurement where UnitType: UnitVolume {
    var string: String {
        MeasurementFormatter.volumeFormatter.string(from: self)
    }
}
