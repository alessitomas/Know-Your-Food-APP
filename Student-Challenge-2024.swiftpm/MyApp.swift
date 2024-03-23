import SwiftUI

@main
struct MyApp: App {
    @StateObject var data = NutrientsInfo()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
            }
            .environmentObject(data)
            
        }
        
    }
    
}


