import SwiftUI

class EventsState: ObservableObject {
    @Published var events: [Event] = []
}