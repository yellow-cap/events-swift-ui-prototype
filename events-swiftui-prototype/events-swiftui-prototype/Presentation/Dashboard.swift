import SwiftUI

enum Segments: Int {
    case all = 0
    case light = 1
    case normal = 2
    case hard = 3
}

struct Dashboard: View {
    @EnvironmentObject var appState: AppState
    @State var isEventDetailsActive: Bool = false
    @State var selectedEventId: Int? = nil
    @State private var selectedSegment = Segments.all.rawValue
    let fetcher = Fetcher()

    init() {
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        VStack {
            if self.selectedSegment == Segments.all.rawValue {
                list(events: self.appState.events)
            } else if self.selectedSegment == Segments.light.rawValue {
                list (events: self.appState.events.filter { $0.category == EventCategory.light })
            } else if self.selectedSegment == Segments.normal.rawValue {
                list (events: self.appState.events.filter { $0.category == EventCategory.normal })
            } else if self.selectedSegment == Segments.hard.rawValue {
                list (events: self.appState.events.filter { $0.category == EventCategory.hard })
            }

            if isEventDetailsActive {
                NavigationLink(
                        destination: EventDetails(props:
                        EventDetailsProps(
                                event: self.appState.events.first { $0.id == self.selectedEventId }!
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
    
    private func picker(activeSegment: Binding<Int>) -> some View {
        Picker("Picker", selection: activeSegment) {
            Text("All").tag(0)
            Text("Light").tag(1)
            Text("Normal").tag(2)
            Text("Hard").tag(3)
        }.pickerStyle(SegmentedPickerStyle())
    }

    private func list(events: [Event]) -> some View {
        List {
            Section(header: self.picker(activeSegment: $selectedSegment)) {
                EmptyView()
            }
            ForEach(events) { event in
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
    }
    
    private func fetchEvents() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.appState.events = self.fetcher.fetchEvents()
        }
    }
}
