//
//  GarmentsTests.swift
//  GarmentsTests
//
//  Created by Kruthay Donapati on 8/30/23.
//

import XCTest
@testable import Garments
import CoreData

final class GarmentsTests: XCTestCase {
    let controller = GarmentsDataController(inMemory: true)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        guard let storeURL = controller.container.persistentStoreCoordinator.persistentStores.first?.url else {
                return
            }
            do {
                try self.controller.container.persistentStoreCoordinator.destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
            } catch {
                print(error)
            }
    }

    func testSaveNewGarmentMethod() throws {
        let name = "SilkGarment"
        controller.saveNewGarment(withName: name)
        let request = NSFetchRequest<Garment>(entityName: "Garment")
        let sampleValue = try controller.container.viewContext.fetch(request).first!
        XCTAssertEqual(sampleValue.name, name)
            
    }

}
