import Foundation
import UIKit

class WaterViewModel: ObservableObject {
    @Published
    var drinkingAmount: Double = 100.0
    var waterLevel: CGFloat = .zero
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
    
    var isGoalReached: Bool {
        round(drinkingTarget) == .zero
    }
    
    var targetText: String {
        isGoalReached
            ? "💦 Nice job! 💦"
            : "Target: \(drinkingTarget.toMilliliters())"
    }
    
    var minimumInterval: Double {
        min(50, drinkingTarget)
    }
    
    var drinkText: String {
        drinkingAmount.toMilliliters()
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
