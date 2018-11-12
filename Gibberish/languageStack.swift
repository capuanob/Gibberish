//
//  languageStack.swift
//  Gibberish
//
//  Created by Bailey Capuano on 11/12/18.
//  Copyright © 2018 CapuanoCodes. All rights reserved.
//

import Foundation

struct languageStack {
    
    fileprivate var arr = [String]()
    
    public func isEmpty() -> Bool {
        return arr.isEmpty
    }
    
    public func size() -> Int {
        return arr.count
    }
    
    public func peek() -> String {
        return arr[0]
    }
    
    public mutating func push(data str: String) {
        arr.insert(str, at: 0)
    }
    
    public mutating func pop() {
        arr.remove(at: 0)
    }
    
    public func printStack() {
        for i in arr {
            print(i, terminator: "")
        }
        print()
    }
}
