import SwiftUI

struct IconCircleButton: View {
    let name: ImageResource
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(name)
                .padding(10)
                .background(
                    Circle()
                        .fill(.clear)
                )
        }
    }
}

#Preview {
    IconCircleButton(name: .iconChatLabel, action: {})
}
