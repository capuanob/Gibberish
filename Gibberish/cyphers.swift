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
    
    public func getType(ofType type: String, string str: String) -> String  {
        switch type {
        case "Reverse":
            print ("Doing this")
            return reverse(encode: str)
        case "Inverter":
            return inverter(encode: str)
        case "Binary":
            return binary(encode: str, dir: permanentData.isEncoding)
        case "Caesar cipher":
            return caesarCipher(encode: str, shift: permanentData.isEncoding * 4)
        case "Reverse Switch":
            return reverseSwitch(encode: str)
        case "Transposition":
            return transposition(encode: str)
        case "Randomize":
            return randomize(encode: str, by: permanentData.isEncoding  * 4)
        default:
            return str
        }
    }
    
    public func randomize(encode str: String, by s: Int) -> String {
        var result = ""
        
        for u in str.utf16 {
            var asciiVal = Int(u)
            asciiVal = (asciiVal - 32 + s) % 95 + 32
            
            if let scalar = UnicodeScalar(asciiVal) {
                result.append(Character(scalar))
            }
        }
        
        return result
    }
    
    
    public func binary(encode str: String, dir: Int) -> String {
        return (dir > 0) ? binaryCipher(encode: str) : textCipher(encode: str)
    }
    
    private func binaryCipher(encode q: String) -> String {
        var result = ""
        
        for c in q.utf16 {
            let asBinary = String(c, radix: 2)
            result.append("\(asBinary) ")
        }
        
        return result
    }
    
    public func reverseSwitch(encode str: String) -> String {
        var cipher = ""
        var c = [Character](str)
        var d = [Character](str)
        var i = 0
        
        while (i < (str.count / 2)) {
            let temp = d[i]
            d[i] = c[c.count - 1-i]
            d[c.count-1-i] = temp
            i += 2
        }
        
        for v in d {
           cipher.append(v)
        }
        
        return cipher
    }
    public func transposition(encode str: String) -> String {
        
        guard str.count > 1 else { return "" }
        var input = [Character](str)
        var cipher = "";
        var runLength = 0
        
        runLength = str.count / 2;
        
        for i in 0..<runLength {
            cipher.append(input[(2*i) + 1])
            cipher.append(input[2 * i])
        }
        
        if (str.count % 2 == 1) {
            cipher.append(input[2 * runLength])
        }
        
        return String(cipher)
    }
    
    private func textCipher(encode q: String) -> String {
        let binaryArray = q.split(separator: " ")
        
        var result = [Character]()
        for b in binaryArray {
            
            if let integer = Int(b, radix: 2) {
                result.append(Character(UnicodeScalar(integer)!))
            }
        }
        
        if result.count > 0 { return String(result) }
        return q
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
        
        var realShift = s
        
        if s < 0 {
            realShift = 26 + s;
        }
        var result = [Character]()
       
        for u in str.utf16 {
            
            if upperRange.contains(Int(u)) {
                result.append(Character(UnicodeScalar(((Int(u) + realShift - 65) % 26 + 65))!))
            } else if lowerRange.contains(Int(u)) {
                result.append(Character(UnicodeScalar(((Int(u) + realShift - 97) % 26 + 97))!))
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
