import SwiftUI

struct SubscriptionModalView: View {
    @ObservedObject private var viewModel = SubscriptionModalViewModel()
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            if isPresented {
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        ZStack {
                            background(containerSize: geo.size)

                            VStack(spacing: 0) {
                                topBar

                                titleView(for: viewModel.slides[safe: viewModel.currentIndex] ?? viewModel.slides[0])
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 22)
                                    .padding(.top, 30)

                                TabView(selection: $viewModel.currentIndex) {
                                    ForEach(Array(viewModel.slides.enumerated()), id: \.1.id) { idx, slide in
                                        SlideContentView(slide: slide, containerSize: geo.size)
                                            .tag(idx)
                                    }
                                }
                                .frame(height: geo.size.height * 0.45)
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                .padding(.top, 5)

                                pageIndicators
                                Spacer(minLength: 0)
                                bottomPanel
                            }
                        }
                    }
                }
            }
        }
    }

    private func background(containerSize: CGSize) -> some View {
        let designSize = CGSize(width: 375, height: 812)

        let ellipseDesignSize = CGSize(width: 1270, height: 732)
        let ellipseLeftDesign: CGFloat = -447
        let ellipseTopDesign: CGFloat = -142

        let scale = containerSize.width / designSize.width

        let ellipseWidth = ellipseDesignSize.width * scale
        let ellipseHeight = ellipseDesignSize.height * scale
        let ellipseOffsetX = ellipseLeftDesign * scale
        let ellipseOffsetY = ellipseTopDesign * scale

        let gradientColors: [Color] = [
            Color.subscriptionModalBackgoundUp,
            Color.subscriptionModalBackgoundDown
        ]

        return Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: gradientColors),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .overlay(alignment: .topLeading) {
                Ellipse()
                    .fill(Color.white)
                    .frame(width: ellipseWidth, height: ellipseHeight)
                    .offset(x: ellipseOffsetX, y: ellipseOffsetY)
                    .blendMode(.normal)
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea()
    }

    @ViewBuilder
    private var topBar: some View {
        HStack {
            Button(action: {
                viewModel.closeModal {
                    isPresented = false
                }
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.silver)
                    .frame(width: 17, height: 16)
            }
            .padding(.leading, 19)

            Spacer()

            Button("Restore") {
                viewModel.restoreTapped()
            }
            .font(.system(size: 16, weight: .regular))
            .foregroundColor(.silver)
            .padding(.trailing, 24)
        }
        .padding(.top, 12)
    }

    @ViewBuilder
    private func titleView(for slide: SubscriptionSlide) -> some View {
        let title = slide.title
        if let highlight = slide.highlight, !highlight.isEmpty,
           let range = title.range(of: highlight, options: .caseInsensitive) {

            let before = String(title[..<range.lowerBound])
            let highlighted = String(title[range])
            let after = String(title[range.upperBound...])

            (
                Text(before)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.main)
                +
                Text(highlighted)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.rosePink)
                +
                Text(after)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.main)
            )
            .frame(maxHeight: 59)
        } else {
            Text(title)
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.main)
        }
    }

    @ViewBuilder
    private var pageIndicators: some View {
        HStack(spacing: 8) {
            ForEach(0..<viewModel.slides.count, id: \.self) { idx in
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(idx == viewModel.currentIndex ? .purple : .gray.opacity(0.35))
            }
        }
        .padding(.top, 26)
        .padding(.bottom, 8)
    }

    @ViewBuilder
    private var bottomPanel: some View {
        VStack(spacing: 0) {
            VStack(spacing: 6) {
                Text("Subscribe for $0.99 weekly")
                    .font(.system(size: 16, weight: .semibold))
                Text("Plan automatically renews. Cancel anytime.")
                    .font(.system(size: 13, weight: .regular))
            }
            .foregroundColor(.white)
            .padding(.bottom, 19)

            Button("Subscribe") {
                viewModel.subscribeTapped()
            }
            .font(.system(size: 18, weight: .semibold))
            .frame(maxWidth: .infinity)
            .frame(height: 48)
            .assetGradient(
                colors: [.subscriptionModalSubscribeLeading, .subscriptionModalSubscribeTrailing],
                startPoint: .leading,
                endPoint: .trailing
            )
            .cornerRadius(44)
            .foregroundColor(.white)
            .padding(.horizontal, 32)
            .padding(.bottom, 14)

            HStack {
                Button("Terms of Use") {
                    viewModel.termsTapped()
                }
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.white)
                .customUnderline(color: .white, thickness: 1, offsetY: 1)
                Spacer()
                Button("Privacy & Policy") {
                    viewModel.privacyTapped()
                }
                .font(.system(size: 13, weight: .regular))
                .foregroundColor(.white)
                .customUnderline(color: .white, thickness: 1, offsetY: 1)
            }
            .padding(.horizontal, 50)
            .padding(.bottom, 43)
        }
    }
}

#Preview {
    SubscriptionModalView(isPresented: .constant(true))
}
