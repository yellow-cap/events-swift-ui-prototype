import SwiftUI

enum Segments: Int {
    case all = 0
    case light = 1
    case normal = 2
    case hard = 3
}

struct Dashboard: View {
    @EnvironmentObject var eventsState: AppState
    @State var isEventDetailsActive: Bool = false
    @State var selectedEventId: Int? = nil
    @State private var selectedSegment = Segments.all.rawValue
    let fetcher = Fetcher()

    init() {
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        VStack {
            List {
                Section(header: self.picker()) {
                    EmptyView()
                }
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
    
    private func picker() -> some View {
        Picker("Xui", selection: $selectedSegment) {
            Text("All")
                    .tag(0)
            Text("Light")
                    .tag(1)
            Text("Normal")
                    .tag(2)
            Text("Hard")
                    .tag(3)
        }
                .pickerStyle(SegmentedPickerStyle())
    }
    
    private func fetchEvents() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.eventsState.events = self.fetcher.fetchEvents()
        }
    }
}
