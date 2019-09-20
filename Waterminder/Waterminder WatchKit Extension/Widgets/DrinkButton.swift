import SwiftUI

struct DrinkButton: View {
    var text: String
    var action: () -> Void
    var body: some View {
        Button(action: {
            withAnimation { self.action() }
        }) {
            HStack(spacing: 20) {
                Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 20, height: 20)
                Text(text)
            }
        }
        .frame(width: 120, height: 50)
    }
}

struct DrinkButton_Previews: PreviewProvider {
    static var previews: some View {
        DrinkButton(text: "100ml") { }
    }
}
