import SwiftUI

struct Dashboard: View {
    @EnvironmentObject var eventsState: AppState
    @State var isEventDetailsActive: Bool = false
    @State var selectedEventId: Int? = nil
    let fetcher = Fetcher()

    init() {
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        VStack {
            List {
                ForEach(self.eventsState.events) { event in
                    DashboardCard(props: DashboardCardProps(
                            name: event.name,
                            imgUrl: event.imgUrl,
                            category: event.category
                    ))
                            .onTapGesture {
                                self.selectedEventId = event.id
                                self.isEventDetailsActive = true
                    }
                }
            }

            if isEventDetailsActive {
                NavigationLink(
                        destination: EventDetails(props:
                        EventDetailsProps(
                                event: self.eventsState.events.first { $0.id == self.selectedEventId }!
                        )),
                        isActive: $isEventDetailsActive
                ) {
                    EmptyView()
                }
            }
        }
                .navigationBarTitle("Dashboard")
                .onAppear {
                    self.fetchEvents()
                }
    }
    
    private func fetchEvents() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.eventsState.events = self.fetcher.fetchEvents()
        }
    }
}
