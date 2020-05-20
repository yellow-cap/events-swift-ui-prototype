import SwiftUI
import Foundation

class Fetcher {
    func fetchEvents() -> [Event] {
        return [
            Event(id: 0, name: "Horse riding", imgUrl: "HorseRiding"),
            Event(id: 1, name: "Paintball", imgUrl: "Paintball")
        ]
    }
}
