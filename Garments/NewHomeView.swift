//
//  NewHomeView.swift
//  Garments
//
//  Created by Kruthay Donapati on 9/21/23.
//

import Foundation
//
//  HomeView.swift
//  Garments
//
//  Created by Kruthay Donapati on 8/30/23.
//

import SwiftUI

struct NewHomeView: View {
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Garment.name, ascending: true)], animation: .easeInOut(duration: 0.5)) private var garments: FetchedResults<Garment>
    @EnvironmentObject var controller : GarmentsDataController
    var body: some View {
        Text("\(garments.count)")
            NewListView(garments: garments)
    }
}
