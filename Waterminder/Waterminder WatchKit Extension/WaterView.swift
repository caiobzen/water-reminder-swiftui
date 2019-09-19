import SwiftUI

struct WaterView: View {
    @State var amount = 100.0
    
    private var amountText: String {
        "\(Int(amount).description)ml"
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            WavingBackground()
            VStack {
                Text("Target: 2000ml")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                                
                Button(action: {
                   print("drink!")
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
        .focusable()
        .digitalCrownRotation($amount, from: 100, through: 1000, by: 50, sensitivity: .medium)
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
