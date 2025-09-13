import SwiftUI

struct FeedView: View {
    @StateObject private var viewModel: FeedViewModel
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    init(rc: RemoteConfigManager) {
        _viewModel = StateObject(wrappedValue: FeedViewModel(rc: rc))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Feed")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.main)
                
                Spacer()
                CoinLabelView(coin: "54")
            }
            .padding(.horizontal, 17)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.tabs, id: \.self) { tab in
                        Button(action: { viewModel.selectTab(tab) }) {
                            Text(tab)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(viewModel.selectedTab == tab ? .main : .silver)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                        }
                    }
                }
                .padding(.leading, 20)
            }
            
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 12) {
                    ForEach(viewModel.filteredProfiles) { profile in
                        ProfileCardView(profile: profile)
                            .frame(height: 238)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
        }
        .onAppear { viewModel.fetchRemoteConfig() }
    }
}

#Preview {
    FeedView(rc: RemoteConfigManager())
}
