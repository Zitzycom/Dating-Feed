import SwiftUI

struct ProfileCardView: View {
    let profile: Profile

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .foregroundColor(.secondary)

            if let url = profile.images?.first {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Color.gray.opacity(0.2)
                    case .success(let image):
                        image
                            .resizable()
                            .clipped()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    case .failure:
                        Color.gray
                    @unknown default:
                        Color.gray
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Color.gray.opacity(0.2)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.0),
                    Color.black.opacity(0.52),
                    Color.black
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .opacity(0.7)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .padding(.top, 104)

            VStack(spacing: 0) {
                HStack {
                    statusView
                    Spacer()
                }
                Spacer()

                HStack(spacing: 8) {
                    if let cc = profile.countryCode {
                        Text(cc.flagEmoji)
                    }
                    Text("\(profile.name), \(profile.age)")
                        .font(.system(size: 15, weight: .bold))
                }

                HStack(spacing: 0) {
                    IconCircleButton(name: .iconChatLabel, action: {})
                    IconCircleButton(name: .iconBtnLive, action: {})
                    IconCircleButton(name: .iconFavorite, action: {})
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 13)
            }
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .cornerRadius(12)
    }

    @ViewBuilder
    private var statusView: some View {
        HStack(spacing: 3) {
            Circle()
                .fill(statusColor)
                .frame(width: 7, height: 7)
                .padding(.vertical, 6)
                .padding(.leading, 6)
            Text(profile.status?.rawValue ?? "")
                .font(.caption)
                .font(.system(size: 10, weight: .bold))
                .padding(.trailing, 7)
        }
        .background(Color.black.opacity(0.4))
        .cornerRadius(55)
        .padding(9)
    }

    private var statusColor: Color {
        switch profile.status {
        case .online: return .green
        case .offline: return .gray
        case .recently: return .yellow
        default: return .gray
        }
    }
}

#Preview {
    ProfileCardView(profile: PreviewMocks.profile)
        .frame(width: 166, height: 238)
        .environmentObject(RemoteConfigManager())
}
