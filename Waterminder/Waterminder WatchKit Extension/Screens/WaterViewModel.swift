import Foundation
import UIKit

class WaterViewModel: ObservableObject {
    @Published
    var drinkingAmount: Double = 100.0
    var drinkingTarget = 2000.0
    var waterLevel: CGFloat = .zero
    
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
    }
    
    func didTapReset() {
        waterLevel = .zero
        drinkingTarget = 2000
        drinkingAmount = 100
    }
}
