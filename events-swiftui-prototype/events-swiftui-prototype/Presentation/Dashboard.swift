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
        GeometryReader { gr in
            VStack {
                self.picker(activeSegment: self.$selectedSegment)
                self.orders(orders: self.appState.orders, gr: gr)

                if self.selectedSegment == Segments.all.rawValue {
                    self.events(events: self.appState.events)
                } else if self.selectedSegment == Segments.light.rawValue {
                    self.events (events: self.appState.events.filter { $0.category == EventCategory.light })
                } else if self.selectedSegment == Segments.normal.rawValue {
                    self.events (events: self.appState.events.filter { $0.category == EventCategory.normal })
                } else if self.selectedSegment == Segments.hard.rawValue {
                    self.events (events: self.appState.events.filter { $0.category == EventCategory.hard })
                }

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
                    .navigationBarTitle("Dashboard")
                    .onAppear {
                        self.fetchEvents()
                        self.fetchOrders()
                    }
        }
    }
    
    private func picker(activeSegment: Binding<Int>) -> some View {
        Picker("Picker", selection: activeSegment) {
            Text("All").tag(0)
            Text("Light").tag(1)
            Text("Normal").tag(2)
            Text("Hard").tag(3)
        }
                .padding(.bottom, 12)
                .background(Color.white)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .pickerStyle(SegmentedPickerStyle())
    }

    private func events(events: [Event]) -> some View {
        List {
            Section {
                Text("Events").font(.largeTitle)
            }
            ForEach(events) { event in
                DashboardCard(props: DashboardCardProps(
                        event: event
                ))
                        .onTapGesture {
                            self.selectedEventId = event.id
                            self.isEventDetailsActive = true
                        }
            }
        }
                .listStyle(PlainListStyle())
                .animation(nil)
    }

    private func orders(orders: [Order], gr: GeometryProxy) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("My orders")
                    .padding(.horizontal, 16)
                    .font(.largeTitle)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 20) {
                    Text("")
                    ForEach(orders) { order in
                        OrderCard(props: OrderCardProps(order: order))
                    }
                    Text("")
                }.frame(height: 180)
            }
        }
    }
    
    private func fetchEvents() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.appState.events = self.fetcher.fetchEvents()
        }
    }

    private func fetchOrders() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.appState.orders = self.fetcher.fetchOrders()
        }
    }
}
