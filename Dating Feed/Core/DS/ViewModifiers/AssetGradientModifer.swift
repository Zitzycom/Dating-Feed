import SwiftUI

struct AssetGradientModifier: ViewModifier {
    let colors: [Color]
    let startPoint: UnitPoint
    let endPoint: UnitPoint

    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: colors),
                    startPoint: startPoint,
                    endPoint: endPoint
                )
            )
    }
}

extension View {
    func assetGradient(colors: [Color], startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom) -> some View {
        self.modifier(AssetGradientModifier(colors: colors, startPoint: startPoint, endPoint: endPoint))
    }
}
