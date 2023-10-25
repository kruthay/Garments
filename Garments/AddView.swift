//
//  EditView.swift
//  Garments
//
//  Created by Kruthay Donapati on 8/30/23.
//

import SwiftUI

// I tried to abstract as much as possible. Any business logic can be added to Controller. 
struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var alertUser = false
    @State private var garmentName: String = ""
    @State private var alertFailure = false
    @EnvironmentObject var controller : GarmentsDataController
    var body: some View {        
        NavigationStack {
            VStack(alignment: .leading){
                Text("Garment Name")
                TextField("", text: $garmentName)
                    .border(.secondary)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        alertUser = controller.validate(garment: garmentName)
                    }
            }
            .padding()
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if controller.validate(garment: garmentName) {
                            if controller.saveNewGarment(withName: garmentName) == true {
                                dismiss()
                            }
                            else {
                                alertFailure = true
                            }

                        } else {
                            alertUser = true
                        }
                    } label: {
                        Text("Save")
                    }
                }
            }
            .navigationBarTitle("Add", displayMode : .inline)
            Spacer()
        }
        .alert(Text("Invalid Garment name"),
               isPresented: $alertUser,
               actions: {},
               message: {Text("Garment name cannot be empty")})
        .alert(Text("Unable to Save"),
               isPresented: $alertFailure,
               actions: { Button("Dismiss", action: {dismiss()}) },
               message: {Text("Garment name cannot be empty")})
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
