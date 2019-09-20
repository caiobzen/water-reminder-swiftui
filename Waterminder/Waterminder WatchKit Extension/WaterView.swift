import SwiftUI

struct WaterView: View {
    @State var drinkingAmount = 100.0
    @State var drinkingTarget = 2000.0
    @State var waterLevel: CGFloat = .zero
    @State var isShowingMenu = false
        
    var body: some View {
        ZStack(alignment: .center) {
            WavingBackground(fill: waterLevel)
            VStack {
                targetLabel()
                if isGoalReached {
                    resetButton()
                } else {
                    DrinkButton(text: drinkingAmount.toMilliliters(), action: self.drink)
                }
            }
        }
        .focusable()
        .digitalCrownRotation($drinkingAmount, from: minimumInterval,
                                    through: self.drinkingTarget,
                                         by: 50,
                                sensitivity: .medium)
        .edgesIgnoringSafeArea(.all)
        .contextMenu(menuItems: { setupButton() })
        .sheet(isPresented: $isShowingMenu) { self.menu() }
    }
    
    private func drink() {
        guard floor(drinkingTarget - drinkingAmount) >= .zero else { return }
        drinkingTarget -= round(drinkingAmount)
        waterLevel += CGFloat(drinkingAmount / 10)
        drinkingAmount = min(drinkingAmount, drinkingTarget)
    }
    
    private func reset() {
        waterLevel = .zero
        drinkingTarget = 2000
        drinkingAmount = 100
    }
}

extension WaterView {
    private var isGoalReached: Bool {
        round(drinkingTarget) == .zero
    }
    
    private var minimumInterval: Double {
        min(50, drinkingTarget)
    }
    
    private var targetText: String {
        isGoalReached
            ? "💦 Nice job! 💦"
            : "Target: \(drinkingTarget.toMilliliters())"
    }
    
    func targetLabel() -> some View {
        Text(targetText)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
    }
    
    func menu() -> some View {
        MenuView(target: self.drinkingTarget) { newTarget in
            self.reset()
            self.drinkingTarget = newTarget
            self.isShowingMenu.toggle()
        }
    }
    
    func setupButton() -> some View {
        Button(action: {
            self.isShowingMenu.toggle()
        }) { Text("Setup").padding() }
    }
    
    func resetButton() -> some View {
        Button(action: {
            withAnimation { self.reset() }
        }) { Text("Reset!") }
        .frame(width: 80, height: 40)
        .accentColor(.black)
        .offset(x: 0, y: 30)
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
