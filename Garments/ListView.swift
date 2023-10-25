//
//  ListView.swift
//  Garments
//
//  Created by Kruthay Donapati on 8/30/23.
//

import SwiftUI

struct ListView: View {
    var garments: FetchedResults<Garment>
    @State var editViewButton = false
    var body: some View {
        // Tried using List but it's too slow for more than 10000 records
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(garments) { garment in
                        if let garmentName = garment.name {
                            Text(garmentName)
                                .padding(0.1)
                            Divider()
                        }
                    }
                }
                .padding()
                .border(.secondary)
            }

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        editViewButton = true
                    } label: {
                        Image(systemName: editViewButton ? "plus.circle.fill" : "plus.circle")
                    }
                }
            }
            .navigationBarTitle("ScrollView + LazYViewStack", displayMode : .inline)
            .fullScreenCover(isPresented: $editViewButton) {
                AddView()
            }
    }
}
