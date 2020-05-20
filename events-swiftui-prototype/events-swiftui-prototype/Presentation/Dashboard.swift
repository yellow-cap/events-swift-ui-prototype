import SwiftUI

struct DashboardProps {
    let events: [Event]
}

struct Dashboard: View {
    @EnvironmentObject var eventsState: EventsState
    let eventsFetcher = EventsFetcher()

    var body: some View {
        List {
            ForEach(self.eventsState.events) { event in
                Text(event.name)
            }
        }.onAppear {
            self.eventsState.events = self.eventsFetcher.fetchEvents()
        }
    }
}
