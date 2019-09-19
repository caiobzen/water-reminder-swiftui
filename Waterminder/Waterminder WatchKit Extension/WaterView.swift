import SwiftUI

struct WaterView: View {
    var body: some View {
        ZStack {
            WavingBackground()
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
