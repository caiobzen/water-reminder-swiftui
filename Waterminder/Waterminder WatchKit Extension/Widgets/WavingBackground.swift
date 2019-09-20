import SwiftUI

struct WavingBackground: View {
    var fill: CGFloat = 0.0
    @State var offsetY: CGFloat = 70
    @State var offsetX: CGFloat = 0
    @State var backgroundOffsetY: CGFloat = 75
    @State var backgroundOffsetX: CGFloat = 70
    
    var repeatingAnimation: Animation {
        Animation
            .easeInOut
            .speed(0.15)
            .repeatForever()
    }
    
    var body: some View {
        VStack {
            ZStack {
                Wave(graphWidth: 1, amplitude: 0.05)
                    .offset(x: offsetX, y: offsetY)
                    .onAppear {
                        self.offsetY = 65
                        self.offsetX = -5
                }
                
                Wave(graphWidth: 1, amplitude: 0.05)
                     .opacity(0.7)
                     .offset(x: backgroundOffsetX, y: backgroundOffsetY)
                     .onAppear {
                        self.backgroundOffsetY = 70
                        self.backgroundOffsetX = 75
                }
            }
            .animation(repeatingAnimation)
            .frame(width: 200, height: 200)
            
            Rectangle()
            .frame(width: 200, height: fill)
        }
        .offset(x: 0, y: 40)
        .foregroundColor(Color(red: 0, green: 0.8, blue: 1))
        .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct WavingBackground_Previews: PreviewProvider {
    static var previews: some View {
        WavingBackground(fill: 0)
    }
}
