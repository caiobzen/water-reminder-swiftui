import SwiftUI

struct WavingBackground <Content: View>: View {
    private let content: Content
    private var fill: CGFloat = 0.0
    @State private var offsetY: CGFloat = 70
    @State private var offsetX: CGFloat = 0
    @State private var backgroundOffsetY: CGFloat = 75
    @State private var backgroundOffsetX: CGFloat = 70
    
    private var repeatingAnimation: Animation {
        Animation
            .easeInOut
            .speed(0.15)
            .repeatForever()
    }
    
    init(fill: CGFloat = .zero, @ViewBuilder content: () -> Content) {
        self.fill = fill
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            VStack {
                waves()
                fillingRectangle()
            }
            .offset(x: 0, y: 40)
            .foregroundColor(Color(red: 0, green: 0.8, blue: 1))
            .frame(minWidth: .zero, maxWidth: .infinity, minHeight: .zero, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            
            content
        }
    }
}

extension WavingBackground {
    func waves() -> some View {
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
    }
    
    func fillingRectangle() -> some View {
        Rectangle()
        .frame(width: 200, height: fill)
    }
}

struct WavingBackground_Previews: PreviewProvider {
    static var previews: some View {
        WavingBackground(fill: 60) {
            Text("Hey!")
        }
    }
}
