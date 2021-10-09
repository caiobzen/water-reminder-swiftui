import Foundation

extension Double {
    func toMilliliters() -> String {
        Measurement(value: self, unit: UnitVolume.milliliters).string
    }

    func toOunces() -> String {
        Measurement(value: self, unit: UnitVolume.milliliters)
            .converted(to: .fluidOunces).string
    }
}
