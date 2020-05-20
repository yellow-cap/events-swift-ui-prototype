import SwiftUI

struct DashboardCardProps {
    let name: String
    let imgUrl: String
    let category: EventCategory
}

struct DashboardCard: View {
    let props: DashboardCardProps

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(props.imgUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                    .clipped()
            VStack(alignment: .leading, spacing: 6) {
                Text(props.name)
                Text("Category: \(props.category.rawValue)")
                Text("Location: Izhevsk")
                Divider()
                HStack {
                    Text("Price: 1500₽ per person")
                    Spacer()
                    Text("Max pax: 3")
                }
            }
                    .padding(8)
        }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
    }
}
