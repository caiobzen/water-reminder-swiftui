import Combine
import SwiftUI

struct WaterView: View {
    @ObservedObject var viewModel: WaterViewModel
    @State var isShowingMenu = false
        
    var body: some View {
        WavingBackground(fill: viewModel.waterLevel) {
            VStack {
                targetLabel()
                if viewModel.isGoalReached {
                    resetButton()
                } else {
                    DrinkButton(text: viewModel.drinkText, action: viewModel.didTapDrink)
                }
            }
        }
        .focusable()
        .digitalCrownRotation($viewModel.drinkingAmount, from: viewModel.minimumInterval, through: viewModel.drinkingTarget, by: 50, sensitivity: .low)
        .edgesIgnoringSafeArea(.all)
        .contextMenu(menuItems: {
            setupButton()
        })
        .sheet(isPresented: $isShowingMenu) { self.menu() }
    }
}

extension WaterView {
    func targetLabel() -> some View {
        Text(viewModel.targetText)
        .font(.system(size: 20, weight: .semibold, design: .rounded))
    }
    
    func menu() -> some View {
        MenuView(target: viewModel.drinkingTarget) { newTarget in
            self.viewModel.didTapReset()
            self.viewModel.drinkingTarget = newTarget
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
            withAnimation { self.viewModel.didTapReset() }
        }) { Text("Reset!") }
        .padding(.horizontal, 40)
        .offset(x: 0, y: 40)
        .accentColor(.black)
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView(viewModel: WaterViewModel())
    }
}
