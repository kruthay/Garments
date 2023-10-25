//
//  ListView.swift
//  Garments
//
//  Created by Kruthay Donapati on 8/30/23.
//

import SwiftUI

struct NewListView: View {
    var garments: FetchedResults<Garment>
    @State var editViewButton = false
    var body: some View {
        // Tried using List but it's too slow for more than 10000 records
            List (garments) { garment in
                        if let garmentName = garment.name {
                            Text(garmentName)
                        }
            }.id(UUID())
            .navigationBarTitle("List")
    }
}

