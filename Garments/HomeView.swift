//
//  HomeView.swift
//  Garments
//
//  Created by Kruthay Donapati on 8/30/23.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Garment.name, ascending: true)], animation: .easeInOut(duration: 0.5)) private var garments: FetchedResults<Garment>
    @State private var sortBy = SortType.name
    @EnvironmentObject var controller : GarmentsDataController
    var body: some View {
        Text("\(garments.count)")
        NavigationStack {
            //Custom Border to make it closely resemble the sample UI
            let customBorder = Rectangle().fill(.secondary).frame(height: 1)
            customBorder
            Picker(selection: $sortBy, label: Text("Sort Garments")) {
                Text("Alpha").tag(SortType.name)
                Text("Creation Time").tag(SortType.creationDate)
            }
            .pickerStyle(.segmented)
            .padding()
            ListView(garments: garments)
        }
        .onChange(of: sortBy) { newSortedValue in
            switch newSortedValue {
            case .name:
                garments.nsSortDescriptors = [NSSortDescriptor(keyPath: \Garment.name, ascending: true)]
            case .creationDate:
                garments.nsSortDescriptors = [NSSortDescriptor(keyPath: \Garment.creationDate, ascending: false)]
            }
        }
    }
}

enum SortType {
    case name
    case creationDate
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
