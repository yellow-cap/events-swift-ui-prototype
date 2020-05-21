import SwiftUI
import Foundation

class Fetcher {
    func fetchEvents() -> [Event] {
        return [
            Event(
                    id: 0,
                    name: "Horse riding",
                    category: EventCategory.light,
                    imgUrl: "HorseRiding",
                    location: "Izhevsk",
                    price: 1500,
                    currency: "₽",
                    persons: 5
            ),
            Event(
                    id: 1,
                    name: "Paintball",
                    category: EventCategory.normal,
                    imgUrl: "Paintball",
                    location: "Glazov",
                    price: 2000,
                    currency: "₽",
                    persons: 15
            ),
            Event(
                    id: 2,
                    name: "Rafting",
                    category: EventCategory.normal,
                    imgUrl: "Rafting",
                    location: "Sarapul",
                    price: 2300,
                    currency: "₽",
                    persons: 7
            ),
            Event(
                    id: 3,
                    name: "Paragliding",
                    category: EventCategory.hard,
                    imgUrl: "Paragliding",
                    location: "Votkinks",
                    price: 5000,
                    currency: "₽",
                    persons: 1
            )
        ]
    }
}
