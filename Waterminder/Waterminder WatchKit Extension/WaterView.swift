import SwiftUI

struct WaterView: View {
    @State var amount = 100.0
    @State var target = 2000.0
    @State var fillValue: CGFloat = .zero
    @State var isShowingMenu = false
    
    private var targetText: String {
        target == .zero
            ? "Nice job!"
            : "Target: \(target.toMilliliters())"
    }
    
    private func drink() {
        guard round(target - amount) >= .zero else { return }
        target -= amount
        fillValue += CGFloat(amount / 10)
        amount = min(amount, target)
    }
    
    private func reset() {
        fillValue = .zero
        target = 2000
        amount = 100
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            WavingBackground(fill: fillValue)
            VStack {
                targetLabel()
                if target != .zero {
                    DrinkButton(text: amount.toMilliliters(), action: self.drink)
                } else {
                    resetButton()
                }
            }
        }
        .focusable()
        .digitalCrownRotation($amount, from: 50, through: self.target, sensitivity: .medium)
        .edgesIgnoringSafeArea(.all)
        .contextMenu(menuItems: {
            Button(action: {
                self.isShowingMenu.toggle()
            }) { Text("Setup").padding() }
        })
        .sheet(isPresented: $isShowingMenu) {
            MenuView()
        }
    }
}

extension WaterView {
    func targetLabel() -> some View {
        Text(targetText)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
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
