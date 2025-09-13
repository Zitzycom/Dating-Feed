import SwiftUI

struct UnderlineModifier: ViewModifier {
    var color: Color = .white
    var thickness: CGFloat = 1
    var offsetY: CGFloat = 6

    func body(content: Content) -> some View {
        content
            .overlay(
                Rectangle()
                    .fill(color)
                    .frame(height: thickness)
                    .offset(y: offsetY),
                alignment: .bottom
            )
    }
}

extension View {
    func customUnderline(color: Color = .white, thickness: CGFloat = 1, offsetY: CGFloat = 6) -> some View {
        self.modifier(UnderlineModifier(color: color, thickness: thickness, offsetY: offsetY))
    }
}
