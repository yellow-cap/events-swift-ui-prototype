import SwiftUI

struct Favorites: View {
    @EnvironmentObject var appState: AppState
    @State var selectedEventId: Int? = nil
    @State var isEventDetailsActive: Bool = false

    var body: some View {
        list(events: self.appState.events.filter { $0.isFavorite })
                .navigationBarTitle("Favorites")
    }

    private func list(events: [Event]) -> some View {
        if events.isEmpty {
            return AnyView(
                    Text("No favorite events")
            )
        } else {
            return AnyView(
                    VStack {
                        List {
                            if !events.isEmpty {
                                ForEach(events) { event in
                                    DashboardCard(props: DashboardCardProps(
                                            event: event,
                                            onFavoriteTap: self.onFavoriteTap
                                    ))
                                            .onTapGesture {
                                                self.selectedEventId = event.id
                                                self.isEventDetailsActive = true
                                            }
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                        .animation(nil)

                if self.isEventDetailsActive {
                    NavigationLink(
                            destination: EventDetails(props:
                            EventDetailsProps(
                                    event: self.appState.events.first { $0.id == self.selectedEventId }!
                            )),
                            isActive: self.$isEventDetailsActive
                    ) {
                        EmptyView()
                    }
                }
            }
            )
        }
    }

    private func onFavoriteTap(_ event: Event) {
        guard let index = self.appState.events.firstIndex(where: { $0.id == event.id }) else {
            return
        }

        self.appState.events[index] = Event(
                id: event.id,
                name: event.name,
                category: event.category,
                imgUrl: event.imgUrl,
                location: event.location,
                price: event.price,
                currency: event.currency,
                persons: event.persons,
                isFavorite: event.isFavorite ? false : true
        )
    }
}
