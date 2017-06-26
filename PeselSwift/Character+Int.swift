//
//  Character+Int.swift
//  PeselSwift
//
//  Created by Lukasz Szarkowicz on 23.06.2017.
//  Copyright © 2017 Łukasz Szarkowicz. All rights reserved.
//

import Foundation

extension Character {
    
    /**
     Convert Char into Int
     
     - returns: *Int* value of Character or *nil* if it is not convertible.
     */
    
    var int: Int? {
        return Int(String(self)) ?? nil
    }
}
