struct Order: Identifiable {
    let id: Int
    let name: String
    let category: EventCategory
    let location: String
    let date: String
    let time: String
    let price: Int
    let persons: Int
    let currency: String
}