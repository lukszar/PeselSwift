//
//  PeselSwift.swift
//  PeselSwift
//
//  Created by Lukasz Szarkowicz on 23.06.2017.
//  Copyright © 2017 Łukasz Szarkowicz. All rights reserved.
//

import Foundation

public struct Pesel {
    
    public enum ValidateResult: Equatable {
        case success
        case error(error: ValidateError)
        
        public static func ==(lhs: ValidateResult, rhs: ValidateResult) -> Bool {
            switch (lhs, rhs) {
            case (.success, .success):
                return true
            case (let .error(error1), let .error(error2)):
                return error1 == error2
            default:
                return false
            }
        }
    }
    
    public enum ValidateError {
        case otherThanDigits
        case wrongLength
        case wrongChecksum
    }
    
    public let pesel: String
    
    public init(pesel: String) {
        self.pesel = pesel
    }
    
    /**
     Pesel validation.
     
     - returns: *ValidateResult.success* if last digit of PESEL is equal to control sum or *ValidateResult.error* if it is not.
     */
    
    public func validate() -> ValidateResult {
        return Pesel.validate(pesel: pesel)
    }
    
    public static func validate(pesel: String) -> ValidateResult {
        
        let ints = pesel.characters.map { $0.int }
        
        // contains characters other than digits
        if ints.contains(where: {$0 == nil}) == true {
            return ValidateResult.error(error: .otherThanDigits)
        }
        
        if ints.count != 11 || pesel.characters.count != 11 {
            return ValidateResult.error(error: .wrongLength)
        }
        
        if ints.last!! != Pesel.computeChecksum(for: pesel) {
            return ValidateResult.error(error: .wrongChecksum)
        }
        
        return ValidateResult.success
    }
    
    
    /**
     Computing Pesel checksum
     
     - parameter pesel: This is a pesel string; required 11 digit string
     
     - returns: An *Int* that is the last digit of control sum; for error returns -1
     */
    
    fileprivate static func computeChecksum(for pesel: String) -> Int {
        
        let ints = pesel.characters.flatMap { $0.int }
        
        guard ints.count == 11 else {
            return -1
        }
        
        let weights = [1,3,7,9,1,3,7,9,1,3]
        var sum = 0
        
        for i in 0...9 {
            sum += weights[i] * ints[i]
        }
        
        let checksum = 10 - (sum % 10)
        if checksum == 10 {
            return 0
        }
        
        return checksum
    }
    
    public func birthdate() -> Date? {
        return Pesel.birthdate(for: pesel)
    }
    
    
    /**
     Compute date of birth based on PESEL.
     
     - returns: *Date* when Pesel validated, or nil when not
     */
    
    fileprivate static func birthdate(for pesel: String) -> Date? {
        
        guard Pesel.validate(pesel: pesel) == ValidateResult.success else {
            return nil
        }
        
        let ints = pesel.characters.flatMap { $0.int }
        
        let diff = Pesel.dateDiffComponents(for: ints[2])
        
        let year: Int = 10*ints[0] + ints[1] + diff.year
        let month: Int = 10*ints[2] + ints[3] + diff.month
        let day: Int = ints[4]*10 + ints[5]

        // create calendar
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        // create components
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        let date = calendar.date(from: components)
        
        return date
    }
    
    
    /**
     Compute date diff components for 3rd digit in a Pesel.
     
     - returns: *month* - the difference to add to the month; *year* - the difference to add to the year
     */
    fileprivate static func dateDiffComponents(for controlNumber: Int) -> (month: Int, year: Int) {
        
        switch controlNumber/2 {
        case 0:
            return (month: 0, year: 1900)
            
        case 1:
            return (month: -20, year: 2000)
            
        case 2:
            return (month: -40, year: 2100)
            
        case 3:
            return (month: -60, year: 2200)
            
        case 4:
            return (month: -80, year: 1800)
        default:
            return (month: 0, year: 0)
        }
    }
}
