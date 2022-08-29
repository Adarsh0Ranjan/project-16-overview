//
//  ContentView.swift
//  project-16-overview
//
//  Created by Roro Solutions on 26/08/22.
//

import SwiftUI
import SamplePackage
let possibleNumbers = Array(1...60)
struct ContentView: View {
    var body: some View {
        Text(results)
    }
    var results: String {
        let selected = possibleNumbers.random(7).sorted() //Inside there we’re going to select seven random numbers from our range, which can be done using the extension you got from my SamplePackage framework. This provides a random() method that accepts an integer and will return up to that number of random elements from your sequence, in a random order. Lottery numbers are usually arranged from smallest to largest, so we’re going to sort them.
        let strings = selected.map(String.init) //Next, we need to convert that array of integers into strings. This only takes one line of code in Swift, because sequences have a map() method that lets us convert an array of one type into an array of another type by applying a function to each element. In our case, we want to initialize a new string from each integer, so we can use String.init as the function we want to call.
        return strings.joined(separator: ", ") //At this point strings is an array of strings containing the seven random numbers from our range, so the last step is to join them all together with commas in between. 
    }
}
//lecture-8-Scheduling local notifications
//import UserNotifications
//struct ContentView: View {
//    var body: some View{
//        VStack {
//            Button("Request Permission") {
//                // first
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set!")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//            Button("Schedule Notification") {
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the cat"
//                content.subtitle = "It looks hungry"
//                content.sound = UNNotificationSound.default
//
//                // show this notification five seconds from now
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//
//                // choose a random identifier
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                // add our notification request
//                UNUserNotificationCenter.current().add(request)
//            }
//        }
//
//    }
//}



//lecture-7-Adding custom row swipe actions to a List
//struct ContentView: View {
//    var body: some View{
//        List {
//            Text("Taylor Swift")
//                .swipeActions {
//                    Button(role: .destructive) {
//                        print("Hi")
//                    } label: {
//                        Label("Delete", systemImage: "trash")
//                    }
//                }
//                .swipeActions(edge: .leading) {
//                    Button {
//                        print("Hi")
//                    } label: {
//                        Label("Pin", systemImage: "pin")
//                    }
//                    .tint(.orange)
//                }
//        }
//    }
//}


    
//lecture-6-Creating context menus -press and hold
//struct ContentView: View {
//    @State private var backgroundColor = Color.red
//
//    var body: some View {
//        VStack {
//            Text("Hello, World!")
//                .padding()
//                .background(backgroundColor)
//
//            Text("Change Color")
//                .padding()
//                .contextMenu {
////                    Button("Red") {
////                        backgroundColor = .red
////                    }
//                    Button (role: .destructive){
//                        backgroundColor = .red
//                    } label: {
//                        Label("Red", systemImage: "checkmark.circle.fill")
//                            .foregroundColor(.red)
//                    }
//
//                    Button("Green") {
//                        backgroundColor = .green
//                    }
//
//                    Button("Blue") {
//                        backgroundColor = .blue
//                    }
//                }
//        }
//    }
//}



//lecture-5-Controlling image interpolation in SwiftUI
//struct ContentView: View {
//    var body: some View {
////        Image("example")
////            .resizable()
////            .scaledToFit()
////            .frame(maxHeight: .infinity)
////            .background(.black)
////            .ignoresSafeArea()
//
//        /*That renders the alien character against a black background to make it easier to see, and because it’s resizable SwiftUI will stretch it up to fill all available space.
//
//         Take a close look at the edges of the colors: they look jagged, but also blurry. The jagged part comes from the original image because it’s only 66x92 pixels in size, but the blurry part is where SwiftUI is trying to blend the pixels as they are stretched to make the stretching less obvious.
//
//         Often this blending works great, but it struggles here because the source picture is small (and therefore needs a lot of blending to be shown at the size we want), and also because the image has lots of solid colors so the blended pixels stand out quite obviously.
//
//         For situations just like this one, SwiftUI gives us the interpolation() modifier that lets us control how pixel blending is applied. There are multiple levels to this, but realistically we only care about one: .none. This turns off image interpolation entirely, so rather than blending pixels they just get scaled up with sharp edges.*/
//        Image("example")
//            .interpolation(.none)
//            .resizable()
//            .scaledToFit()
//            .frame(maxHeight: .infinity)
//            .background(.black)
//            .ignoresSafeArea()
//        //Now you’ll see the alien character retains its pixellated look, which not only is particularly popular in retro games but is also important for line art that would look wrong when blurred.
//    }
//}


    
//lecture-4-Understanding Swift’s Result type
//struct ContentView: View {
//    @State private var output = ""
//
//    var body: some View {
//        Text(output)
//            .task {
//                await fetchReadings()
//            }
//    }
//
////    func fetchReadings() async {
////        do {
////            let url = URL(string: "https://hws.dev/readings.json")!
////            let (data, _) = try await URLSession.shared.data(from: url)
////            let readings = try JSONDecoder().decode([Double].self, from: data)
////            output = "Found \(readings.count) readings"
////        } catch {
////            print("Download error")
////        }
////    }
//
//    /*That code works just fine, but it doesn’t give us a lot of flexibility – what if we want to stash the work away somewhere and do something else while it’s running? What if we want to read its result at some point in the future, perhaps handling any errors somewhere else entirely? Or what if we just want to cancel the work because it’s no longer needed?
//
//     Well, we can get all that by using Result, and it’s actually available through an API you’ve met previously: Task.*/
//
//    func fetchReadings() async {
//        let fetchTask = Task { () -> String in //here we’ve given the Task object the name of fetchTask – that’s what gives us the extra flexibility to pass it around, or cancel it if needed
//            let url = URL(string: "https://hws.dev/readings.json")!
//            let (data, _) = try await URLSession.shared.data(from: url)
//            let readings = try JSONDecoder().decode([Double].self, from: data)
//            return "Found \(readings.count) readings"
//        }
//
//        let result = await fetchTask.result  //If you look at the type of result, you’ll see it’s a Result<String, Error> – if it succeeded it will contain a string, but it might also have failed and will contain an error.
//
//        //You can read the successful value directly from the Result if you want, but you’ll need to make sure and handle errors appropriately, like this:
//        do {
//            output = try result.get()
//        } catch {
//            output = "Error: \(error.localizedDescription)"
//        }
//
//        //Alternatively, you can switch on the Result, and write code to check for both the success and failure cases. Each of those cases have their values inside (the string for success, and an error for failure), so Swift lets us read those values out using a specially crafted case match:
//        switch result {
//            case .success(let str):
//                output = str
//            case .failure(let error):
//                output = "Error: \(error.localizedDescription)"
//        }
//    }
//}



//lecture-3-Manually publishing ObservableObject changes
//@MainActor class DelayedUpdater: ObservableObject {
////@Published var value = 0 // if we remove publish from here then our content will not change with the chnage of value and alterb=native for that is objectWillChange
//
//    var value = 0 {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//
//    init() {
//        for i in 1...10 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
//                self.value += 1
//            }
//        }
//    }
//}
//struct ContentView: View {
//    @StateObject var updater = DelayedUpdater()
//
//    var body: some View {
//        Text("Value is: \(updater.value)")
//    }
//}


//lecture-2-Creating tabs with TabView and tabItem()
//struct ContentView: View {
//    @State private var selectedTab = "One"
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            Text("Tab 1")
//                .onTapGesture {
//                    selectedTab = "Two"
//                }
//                .tabItem {
//                    Label("One", systemImage: "star")
//                }
//                .tag("One")
//
//            Text("Tab 2")
//                .onTapGesture {
//                    selectedTab = "one"
//                }
//
//                .tabItem {
//                    Label("Two", systemImage: "circle")
//                }
//                .tag("Two")
//        }
//    }
//}



//lecture-1-Reading custom values from the environment with @EnvironmentObject
//@MainActor class User: ObservableObject {
//    @Published var name = "Taylor Swift"
//}
//struct EditView: View {
//    @EnvironmentObject var user: User
//
//    var body: some View {
//        TextField("Name", text: $user.name)
//    }
//}
//
//struct DisplayView: View {
//    @EnvironmentObject var user: User
//
//    var body: some View {
//        Text(user.name)
//    }
//}
//struct ContentView: View {
//    @StateObject private var xuser = User()
//
//    var body: some View {
////        VStack {
////            EditView().environmentObject(user)
////            DisplayView().environmentObject(user)
////        }
//
//        VStack {
//            EditView()
//            DisplayView()
//        }
//        .environmentObject(xuser) //it works identically
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
