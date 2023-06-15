//
//  SomeOtherCode.swift
//  
//
//  Created by Andrew on 14/06/2023.
//

import Foundation

/// Code that may be written by someone else..
/// Contains classes written by someone who does not have or need access to edit the
/// package code to instantiate instances of these classes.
/// They will be instantiated by the test code and their secrets leaned.
///
class Baah : Food {
   required init() { }
   let secret = "applesauce"
}

final class HumBug: Food {
   init() {}
   let secret = "ketchup"
}
