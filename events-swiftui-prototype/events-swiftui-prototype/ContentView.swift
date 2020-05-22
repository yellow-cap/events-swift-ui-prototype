import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                Dashboard()
            }.tabItem {
                Image(systemName: "list.dash")
                Text("Dashboard")
            }

            NavigationView {
                Favorites()
            }.tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
            }

            NavigationView {
                More()
            }.tabItem {
                Image(systemName: "ellipsis")
                Text("More")
            }
        }
    }
}
