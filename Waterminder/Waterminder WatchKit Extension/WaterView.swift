import SwiftUI

struct WaterView: View {
    @State var amount = 100.0
    @State var target = 2000.0
    @State var fillValue: CGFloat = 0.0
    
    private var amountText: String {
        "\(Int(amount).description)ml"
    }
    
    private var targetText: String {
        target == .zero
            ? "Nice job!"
            : "Target: \(Int(target).description)ml"
    }
    
    private func drink() {
        guard target - amount >= .zero else { return }
        target -= amount
        fillValue += CGFloat(amount / 10)
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            WavingBackground(fill: fillValue)
            VStack {
                Text(targetText)
                .font(.system(size: 20, weight: .semibold, design: .rounded))
                    
                if target != .zero {
                    Button(action: {
                        withAnimation { self.drink() }
                    }) {
                        HStack(alignment: .center, spacing: 24) {
                            Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            Text(amountText)
                        }
                        }
                    .frame(width: 130, height: 50)
                }
            }
            .shadow(radius: 1)
        }
        .focusable()
        .digitalCrownRotation($amount, from: 50, through: 1000, by: 50, sensitivity: .medium)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
