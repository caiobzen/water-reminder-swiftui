import Foundation
import UIKit

class WaterViewModel: ObservableObject {
    @Published
    var drinkingAmount: Double = 100.0
    var waterLevel: CGFloat = .zero
    var isMilliliters: Bool {
        chosenUnit == .milliliters
    }
    var isFirstUserInteraction: Bool {
        if let status = UserDefaults.standard.value(forKey: UserDefaultsConstant.firstUserInteraction) as? Bool {
            return status
        } else {
            return true
        }
    }
    var drinkingTarget: Double = {
        guard let target = UserDefaults.standard.value(forKey: UserDefaultsConstant.waterTarget) as? Double else {
            return 2000.0
        }
        return target
    }()
    var chosenUnit: UnitVolume = {
        guard let unit = UserDefaults.standard.string(forKey: UserDefaultsConstant.chosenUnit) else {
            return .milliliters
        }
        return unit == UnitVolume.milliliters.symbol ? .milliliters : .fluidOunces
    }()
    
    var isGoalReached: Bool {
        round(drinkingTarget) == .zero
    }
    
    var targetText: String {
        let targetString = isMilliliters ? drinkingTarget.toMilliliters() : drinkingTarget.toOunces()
        return isGoalReached
            ? "💦 Nice job! 💦"
            : "Target: \(targetString)"
    }
    
    var minimumInterval: Double {
        min(50, drinkingTarget)
    }
    
    var drinkText: String {
        isMilliliters ? drinkingAmount.toMilliliters() : drinkingAmount.toOunces()
    }
    
    func didTapDrink() {
        guard floor(drinkingTarget - drinkingAmount) >= .zero else { return }
        saveToHealthKit()
        drinkingTarget -= round(drinkingAmount)
        waterLevel += CGFloat(drinkingAmount / 10)
        drinkingAmount = min(drinkingAmount, drinkingTarget)
    }
    
    private func saveToHealthKit() {
        let healthKit = HealthKitSetupAssistant()
        if isFirstUserInteraction {
            healthKit.requestPermissions()
            UserDefaults.standard.setValue(false, forKey: UserDefaultsConstant.firstUserInteraction)
        }
        healthKit.addWater(waterAmount: drinkingAmount, forDate: Date())
    }
    
    func updateTarget(newTarget: Double) {
        drinkingTarget = newTarget
        UserDefaults.standard.setValue(drinkingTarget, forKey: UserDefaultsConstant.waterTarget)
    }

    func updateUnit(newUnit: UnitVolume) {
        chosenUnit = newUnit
        UserDefaults.standard.setValue(chosenUnit.symbol, forKey: UserDefaultsConstant.chosenUnit)
    }
    
    func didTapReset() {
        waterLevel = .zero
        if let target = UserDefaults.standard.value(forKey: UserDefaultsConstant.waterTarget) as? Double {
            drinkingTarget = target
        } else {
            drinkingTarget = 2000.0
        }
        drinkingAmount = 100
    }
}
