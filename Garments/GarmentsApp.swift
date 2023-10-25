//
//  GarmentsApp.swift
//  Garments
//
//  Created by Kruthay Donapati on 8/30/23.
//

import SwiftUI

@main
struct GarmentsApp: App {
    @StateObject private var controller = GarmentsDataController()
    @State var numberOfItems = 1
    var body: some Scene {
        WindowGroup {
            HStack {
                Spacer()
                Button("Save \(numberOfItems) Items") {
                    controller.saveItems(numberOfItems: numberOfItems )
                }
                TextField("NumberOfItems", value: $numberOfItems, formatter: NumberFormatter())
                    .textFieldStyle(.roundedBorder)
                Spacer()
            }
            
            Button ("Delete ALL") {
                controller.deleteAll()
            }
            NavigationStack {
                NavigationLink("ScrollView + LazyVStack", destination: HomeView())
                NavigationLink("List", destination: NewHomeView())
            }
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(controller)
        }
    }
}


