import SwiftUI

struct MenuView: View {
    @State var target: Double
    var newTargetSelected: (Double) -> Void
    var body: some View {
        VStack {
            Text("New target")
            Text(target.toMilliliters())
            Button(action: {
                self.newTargetSelected(self.target)
            }) {
                Text("Save")
                .padding(16)
            }
        }
        .focusable()
        .digitalCrownRotation($target, from: 100.0, through: 10000.0)
    }
}
    
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(target: 2000) { target in
            print(target)
        }
    }
}
