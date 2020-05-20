import SwiftUI

class AppState: ObservableObject {
    @Published var events: [Event] = []
}