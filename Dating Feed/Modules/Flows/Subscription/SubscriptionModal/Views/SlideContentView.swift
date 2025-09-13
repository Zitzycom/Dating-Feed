import SwiftUI

struct SlideContentView: View {
    let slide: SubscriptionSlide
    let containerSize: CGSize

    var body: some View {
        Image(slide.imageName)
            .resizable()
            .scaledToFit()
            .clipped()
    }
}
