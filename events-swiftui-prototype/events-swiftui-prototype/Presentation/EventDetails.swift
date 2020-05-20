import SwiftUI

struct EventDetailsProps {
    let event: Event
}

struct EventDetails: View {
    let props: EventDetailsProps

    var body: some View {
        Text(props.event.name)
    }
}
