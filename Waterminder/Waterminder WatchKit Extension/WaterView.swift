import SwiftUI

struct WaterView: View {
    var body: some View {
        ZStack(alignment: .center) {
            WavingBackground()
            VStack {
                Text("Target: 2000ml")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                
                Button(action: {
                    print("Há!")
                }) {
                    Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
                }.frame(width: 40, height: 40)
            }
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WaterView_Previews: PreviewProvider {
    static var previews: some View {
        WaterView()
    }
}
