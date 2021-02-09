import Foundation
import UIKit

class WaterViewModel: ObservableObject {
    @Published
    var drinkingAmount: Double = 100.0
    var drinkingTarget = 2000.0
    var waterLevel: CGFloat = .zero
    var isFirstUserInteraction: Bool {
        if let status = UserDefaults.standard.value(forKey: UserDefaultsConstant.firstUserInteraction) as? Bool {
            return status
        } else {
            return true
        }
    }
    
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
        drinkingTarget -= round(drinkingAmount)
        waterLevel += CGFloat(drinkingAmount / 10)
        drinkingAmount = min(drinkingAmount, drinkingTarget)
        saveToHealthKit()
    }
    
    private func saveToHealthKit() {
        let healthKit = HealthKitSetupAssistant()
        if isFirstUserInteraction {
            healthKit.requestPermissions()
            UserDefaults.standard.setValue(false, forKey: UserDefaultsConstant.firstUserInteraction)
        }
        healthKit.addWater(waterAmount: drinkingAmount, forDate: Date())
    }
    
    func didTapReset() {
        waterLevel = .zero
        drinkingTarget = 2000
        drinkingAmount = 100
    }
}
