import SwiftUI

struct DashboardCardProps {
    let event: Event
}

struct DashboardCard: View {
    let props: DashboardCardProps

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(props.event.imgUrl)
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: nil, idealWidth: nil, maxWidth: UIScreen.main.bounds.width, minHeight: nil, idealHeight: nil, maxHeight: 300, alignment: .center)
                    .clipped()
            VStack(alignment: .leading, spacing: 6) {
                Text(props.event.name)
                Text("Category: \(props.event.category.rawValue)")
                Text("Location: \(props.event.location)")
                Divider()
                HStack {
                    Text("Price: \(props.event.price)\(props.event.currency) per person")
                    Spacer()
                    Text("Max pax: \(props.event.persons)")
                }
            }
                    .padding(8)
        }
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
    }
}
