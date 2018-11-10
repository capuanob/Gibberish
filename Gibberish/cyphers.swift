//
//  cyphers.swift
//  Gibberish
//
//  Created by Bailey Capuano on 11/10/18.
//  Copyright © 2018 CapuanoCodes. All rights reserved.
//

import Foundation

class CypherBundle {
    //Uppercase: 65- 90, Lowercase: 97-122 in UTF-16
    
    private let upperRange = 65...90
    private let lowerRange = 97...122
    
    public let availableCyphers: [String] = ["", "Reverse", "Inverter", "Caesar cipher", "Rail fence cipher", "Create your own"]
    
    public func getType(ofType type: String, string str: String) -> String  {
        switch type {
        case "Reverse":
            return reverse(encode: str)
        case "Inverter":
            return inverter(encode: str)
        case "Caesar cipher":
            return caesarCipher(encode: str, shift: 2)
        case "Create your own":
            return "segue"
        default:
            return "No cipher chosen. Please select one using the menu."
        }
    }
    
    public func reverse(encode str: String) -> String {
        return String(str.reversed())
    }
    
    public func inverter(encode str: String) -> String {
        var result = [Character]()
        let alphabetForwards = [Character]("abcdefghijklmnopqrstuvwxyz")
        let alphabetBackwards = [Character](alphabetForwards.reversed())
        
        for c in str {
            if upperRange.contains(Int(c.unicodeScalars.map { $0.value }.reduce(0, +))) {
                result.append(Character(String(alphabetBackwards[alphabetForwards.firstIndex(of: Character(String(c).lowercased()))!]).uppercased()))
            } else if lowerRange.contains(Int(c.unicodeScalars.map { $0.value }.reduce(0, +))) {
                 result.append(alphabetBackwards[alphabetForwards.firstIndex(of: c)!])
            } else {
                result.append(c)
            }
        }
        return String(result)
    }
    
    public func caesarCipher(encode str: String, shift s: Int ) -> String {
        var result = [Character]()
       
        
        for u in str.utf16 {
            
            if upperRange.contains(Int(u)) {
                result.append(Character(UnicodeScalar(((Int(u) + s - 65) % 26 + 65))!))
            } else if lowerRange.contains(Int(u)) {
                result.append(Character(UnicodeScalar(((Int(u) + s - 97) % 26 + 97))!))
            } else {
                result.append(Character(UnicodeScalar(u)!))
            }
        }
        return String(result)
    }
    
    //TODO: Fix and implement
    public func reflectionCipher(encode str: String, encode: Bool) -> String {
        var result = [Character]()
        
        let incrementer = encode ? 13 : -13
        
        for u in str.utf16 {
            if upperRange.contains(Int(u)) {
                result.append(Character(UnicodeScalar(((Int(u) + incrementer - 65) % 26 + 65))!))
            } else if lowerRange.contains(Int(u)) {
                result.append(Character(UnicodeScalar(((Int(u) + incrementer - 97) % 26 + 97))!))
            } else {
                result.append(Character(UnicodeScalar(u)!))
            }
        }
        
        return String(result)
    }
}
