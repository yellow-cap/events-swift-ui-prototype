import SwiftUI

struct DashboardCardProps {
    let name: String
    let imgUrl: String
}

struct DashboardCard: View {
    let props: DashboardCardProps

    var body: some View {
        ZStack {
            Image(props.imgUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                    .clipped()
            Text(props.name)
        }
    }
}
