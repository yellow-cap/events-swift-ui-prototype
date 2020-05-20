import SwiftUI
import Foundation

class Fetcher {
    func fetchEvents() -> [Event] {
        return [
            Event(id: 0, name: "Horse riding", category: EventCategory.light, imgUrl: "HorseRiding"),
            Event(id: 1, name: "Paintball", category: EventCategory.normal, imgUrl: "Paintball")
        ]
    }
}
