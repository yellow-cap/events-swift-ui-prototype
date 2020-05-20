import SwiftUI
import Foundation

class Fetcher {
    func fetchEvents() -> [Event] {
        return [
            Event(id: 0, name: "Horse riding"),
            Event(id: 1, name: "Paintball")
        ]
    }
}
