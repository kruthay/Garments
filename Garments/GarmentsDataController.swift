//
//  GarmentsDataController.swift
//  Garments
//
//  Created by Kruthay Donapati on 8/30/23.
//

import Foundation
import CoreData
class GarmentsDataController: ObservableObject {
    var currentValue: Int = 0
    
    let container = NSPersistentContainer(name: "Garments")

    
    // inMemory is for independent unit tests
    init(inMemory: Bool = false) {
        if inMemory {
            let description = NSPersistentStoreDescription(url: URL(fileURLWithPath: "/dev/null"))
            print(description)
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Couldn't load Data Store \(desc) due to error: \(error.localizedDescription)")
            }
        }
    }
    
    // The new garment is saved using this method,
    // As there is no editing required, it can be used on viewContext.
    // However if Editing is required, then childContext can be used and seperately persisted as required.
    // return true if saving is successful else it returns false.
    @discardableResult
    func saveNewGarment(withName garmentName: String) -> Bool {
        let garment = Garment(context: container.viewContext)
        garment.id = UUID()
        garment.name = garmentName
        garment.creationDate = Date.now
        do {
            try container.viewContext.save()
            return true
        } catch {
            print("Unable to save \(error.localizedDescription)")
        }
        return false
    }
    
    func deleteAll() {
        let context = self.container.newBackgroundContext()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Garment")
                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

                do {
                    try context.execute(deleteRequest)
                    try context.save()
                } catch {
                    print("Failed to delete data: \(error)")
                }
    }
    
    
    func saveItems(numberOfItems: Int) {
        
        //update at the end:
        
        DispatchQueue.global(qos: .background).async {
            let context = self.container.newBackgroundContext()
            for i in self.currentValue..<self.currentValue + numberOfItems  {
                let garment = Garment(context: context)
                garment.id = UUID()
                garment.name = String(i)
                garment.creationDate = Date.now
                if i % 500 == 0 {
                    do {
                        try context.save()
                    } catch {
                        print("Unable to save \(error.localizedDescription)")
                    }
                }
            }
            DispatchQueue.main.async {
                print("Finished")
            }
        }
    }
    
    // Any required validations can be used here for the name or other attributes as well.
    func validate(garment: String) -> Bool {
        return !garment.isEmpty
    }
}
