import SwiftUI

struct OrderDetailsProps {
    let order: Order
}

struct OrderDetails: View {
    let props: OrderDetailsProps

    var body: some View {
        Text("Order id: \(props.order.id)")
                .navigationBarTitle("Order details")
    }
}
