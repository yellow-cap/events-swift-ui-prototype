import SwiftUI

class AppState: ObservableObject {
    @Published var events: [Event] = []
    @Published var orders: [Order] = []
}