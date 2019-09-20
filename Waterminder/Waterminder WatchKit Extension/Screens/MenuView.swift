import SwiftUI

struct MenuView: View {
    @State var target: Double
    var newTargetSelected: (Double) -> Void
    var body: some View {
        VStack {
            Text("Select the target")
                .font(.system(.headline, design: .rounded))
            Spacer()
            Text(target.toMilliliters())
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(.init(red: 0, green: 0.8, blue: 1))
            Spacer()
            Button(action: {
                self.newTargetSelected(self.target)
            }) {
                Text("Save")
            }
            .padding(.horizontal, 20)
        }
        .focusable()
        .digitalCrownRotation($target, from: 100.0, through: 10000.0, by: 50)
    }
}
    
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(target: 2000) { target in
            print(target)
        }
    }
}
