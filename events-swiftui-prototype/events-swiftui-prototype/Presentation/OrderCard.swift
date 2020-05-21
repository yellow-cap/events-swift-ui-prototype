import SwiftUI

struct OrderCardProps {
    let order: Order
}

struct OrderCard: View {
    let props: OrderCardProps

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
                Text(props.order.name).font(.headline)
                Text("Location: \(props.order.location)")
                Text("Date: \(props.order.date)")
                Text("Time: \(props.order.time)")
                Divider()
                Text("Price: \(props.order.price)\(props.order.currency) per \(props.order.persons) pax")
                        .padding(.top, 6)
            }
                .padding(.horizontal, 12)
                .frame(width: 220, height: 160, alignment: .leading)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
    }
}