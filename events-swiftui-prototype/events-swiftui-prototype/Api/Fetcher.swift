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
                    persons: 5,
                    isFavorite: false
            ),
            Event(
                    id: 1,
                    name: "Paintball",
                    category: EventCategory.normal,
                    imgUrl: "Paintball",
                    location: "Glazov",
                    price: 2000,
                    currency: "₽",
                    persons: 15,
                    isFavorite: false
            ),
            Event(
                    id: 2,
                    name: "Rafting",
                    category: EventCategory.normal,
                    imgUrl: "Rafting",
                    location: "Sarapul",
                    price: 2300,
                    currency: "₽",
                    persons: 7,
                    isFavorite: false
            ),
            Event(
                    id: 3,
                    name: "Paragliding",
                    category: EventCategory.hard,
                    imgUrl: "Paragliding",
                    location: "Votkinks",
                    price: 5000,
                    currency: "₽",
                    persons: 1,
                    isFavorite: false
            )
        ]
    }

    func fetchOrders() -> [Order] {
        [
            Order(
                    id: 0,
                    name: "Horse riding",
                    category: EventCategory.light,
                    location: "Izhevsk",
                    date: "22.05.2020",
                    time: "13:00",
                    price: 4500,
                    persons: 3,
                    currency: "₽"
            ),
            Order(
                    id: 1,
                    name: "Rafting",
                    category: EventCategory.normal,
                    location: "Sarapul",
                    date: "01.06.2020",
                    time: "14:00",
                    price: 16100,
                    persons: 7,
                    currency: "₽"
            ),
            Order(
                    id: 3,
                    name: "Rafting",
                    category: EventCategory.normal,
                    location: "Sarapul",
                    date: "02.06.2020",
                    time: "13:00",
                    price: 9200,
                    persons: 4,
                    currency: "₽"
            )
        ]
    }
}
