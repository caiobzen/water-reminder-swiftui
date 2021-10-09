import SwiftUI

struct MenuView: View {
    @State var target: Double
    @State var selectedUnit: UnitVolume
    var newSelections: (_ target: Double, _ unit: UnitVolume) -> Void
    var body: some View {
        VStack {
            Text("Select the target")
                .font(.system(.headline, design: .rounded))
            Spacer()
            Text(target.toMilliliters())
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(.init(red: 0, green: 0.8, blue: 1))
                .onTapGesture {
                    selectedUnit = selectedUnit == .milliliters ? .fluidOunces : .milliliters
                }
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .padding(EdgeInsets(top: -2, leading: -8, bottom: -2, trailing: -8))
                        .foregroundColor(.gray.opacity(selectedUnit == .milliliters ? 0.5 : 0))
                )
            Spacer()
            Text(target.toOunces())
                .font(.system(size: 24, weight: .semibold, design: .rounded))
                .foregroundColor(.init(red: 0, green: 0.8, blue: 1))
                .onTapGesture {
                    selectedUnit = selectedUnit == .milliliters ? .fluidOunces : .milliliters
                }
                .background(
                    RoundedRectangle(cornerRadius: 25.0)
                        .padding(EdgeInsets(top: -2, leading: -8, bottom: -2, trailing: -8))
                        .foregroundColor(.gray.opacity(selectedUnit == .fluidOunces ? 0.5 : 0))
                )
            Spacer()
            Button(action: {
                self.newSelections(self.target, self.selectedUnit)
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
        MenuView(target: 2000, selectedUnit: .milliliters) { target, unit in
            print(target)
        }
    }
}
