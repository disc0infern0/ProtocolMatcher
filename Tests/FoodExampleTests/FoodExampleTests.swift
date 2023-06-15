//
//  File.swift
//  
//
//  Created by Andrew on 13/06/2023.
//

import Foundation
import XCTest

@testable import ProtocolMatcher

@objc protocol Food {
   init()
   var secret: String {get}
}

/// Detect classes matching Food protocol, instantiate them and learn their secrets!
final class FoodMatchTests: XCTestCase {

   /// The secrets we find in the discovered classes will be held in a dictionary from the classname to its secret.
   var secrets: [String:String] = [:]
   /// since this is a test, we know what we should find. (from classes in the file SomeOtherCode.swift )
   var expectedResults: [String:String] = [ "Baah": "applesauce", "HumBug": "ketchup"]

   func testFoodSecrets() throws {

      let classesConforming = ProtocolMatcher().getClassesFor(Food.self) as! [any Food.Type]

      for classType in classesConforming {
         let className = "\(classType)"
         let classObject = classType.init()
         let secret = classObject.secret
         secrets[className] = secret
      }
      XCTAssertEqual(secrets, expectedResults)
   }
}
