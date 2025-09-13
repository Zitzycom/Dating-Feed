import SwiftUI

struct CoinLabelView: View {
    let coin: String

    var body: some View {
        HStack(spacing: 6) {
            Text(coin)
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.white)
                .padding(.leading, 13)

            Image(.iconCoin)
                .padding(.vertical, 4)
                .padding(.trailing, 4)
        }
        .background(.silver)
        .cornerRadius(55)
    }
}

#Preview {
    CoinLabelView(coin: "11")
}
