import SwiftUI

enum Segments: Int {
    case all = 0
    case light = 1
    case normal = 2
    case hard = 3
}

struct Dashboard: View {
    @EnvironmentObject var appState: AppState
    @State var selectedEventId: Int? = nil
    @State var isEventDetailsActive: Bool = false
    @State var selectedOrderId: Int? = nil
    @State var isOrderDetailsActive: Bool = false
    @State private var selectedSegment = Segments.all.rawValue
    let fetcher = Fetcher()

    init() {
        UITableView.appearance().separatorStyle = .none
    }

    var body: some View {
        VStack {
            if self.selectedSegment == Segments.all.rawValue {
                self.list(
                        events: self.appState.events,
                        orders: self.appState.orders
                )
            } else if self.selectedSegment == Segments.light.rawValue {
                self.list (
                        events: self.appState.events.filter { $0.category == EventCategory.light },
                        orders: self.appState.orders.filter { $0.category == EventCategory.light }
                )
            } else if self.selectedSegment == Segments.normal.rawValue {
                self.list (
                        events: self.appState.events.filter { $0.category == EventCategory.normal },
                        orders: self.appState.orders.filter { $0.category == EventCategory.normal }
                )
            } else if self.selectedSegment == Segments.hard.rawValue {
                self.list (
                        events: self.appState.events.filter { $0.category == EventCategory.hard },
                        orders: self.appState.orders.filter { $0.category == EventCategory.hard }
                )
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

            if self.isOrderDetailsActive {
                NavigationLink(
                        destination: OrderDetails(props:
                        OrderDetailsProps(
                                order: self.appState.orders.first { $0.id == self.selectedOrderId }!
                        )),
                        isActive: self.$isOrderDetailsActive
                ) {
                    EmptyView()
                }
            }
        }
            .navigationBarTitle("Dashboard")
            .onAppear {
                if self.appState.events.isEmpty {
                    self.fetchEvents()
                }

                if self.appState.orders.isEmpty {
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
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(Color.white)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .pickerStyle(SegmentedPickerStyle())
    }

    private func list(events: [Event], orders: [Order]) -> some View {
        List {
            Section(header: self.picker(activeSegment: self.$selectedSegment)) {
                if !orders.isEmpty {
                    self.orders(orders: orders)

                    if !events.isEmpty {
                        Text("Events").font(.largeTitle)
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
            }
        }
                .listStyle(PlainListStyle())
                .animation(nil)
    }

    private func orders(orders: [Order]) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("My orders").font(.largeTitle)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center) {
                    Text("")
                    ForEach(orders) { order in
                        OrderCard(props: OrderCardProps(order: order))
                                .onTapGesture {
                                    self.selectedOrderId = order.id
                                    self.isOrderDetailsActive = true
                                }
                                .padding(.trailing, 16)
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
