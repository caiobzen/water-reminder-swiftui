import SwiftUI

struct WavingBackground: View {
    @State var offsetY: CGFloat = 70
    @State var backgroundOffsetY: CGFloat = 75
    
    var repeatingAnimation: Animation {
        Animation
            .easeInOut
            .delay(0)
            .speed(0.15)
            .repeatForever()
    }
    
    var body: some View {
        ZStack {
            Wave(graphWidth: 1, amplitude: 0.05)
                .offset(x: 0, y: offsetY)
                .onAppear { self.offsetY = 65 }
            
            Wave(graphWidth: 1, amplitude: 0.05)
                 .opacity(0.7)
                 .offset(x: 70, y: backgroundOffsetY)
                 .onAppear { self.backgroundOffsetY = 65 }
        }
        .animation(repeatingAnimation)
        .foregroundColor(Color(red: 0, green: 0.8, blue: 1))
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WavingBackground_Previews: PreviewProvider {
    static var previews: some View {
        WavingBackground()
    }
}
