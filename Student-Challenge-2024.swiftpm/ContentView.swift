import SwiftUI

struct ContentView: View {
    @State private var currentPage = 1
    @State var selectedImage: UIImage?
    var body: some View {
        TabView(selection: $currentPage){
            
            HomeView(currentPage: $currentPage)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(1)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

            CameraView()
                .tabItem{
                    Label("Photo", systemImage: "photo")
                }
                .tag(2)
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                
            
        }
        .accentColor(.orange)

    
    }
}

#Preview {
    ContentView()
}
