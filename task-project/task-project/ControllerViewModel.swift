//
//  ControllerViewModel.swift
//  task-project
//
//  Created by Anish on 10/15/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import Foundation

class ControllerViewModel: NSObject {
    var maximumCharactersLimit: Int = 0
    var numbers: [Int] = []
    
    init(numbers: [Int], maximumLimit: Int) {
        self.numbers = numbers
        self.maximumCharactersLimit = maximumLimit
    }
    
    // MARK:- Helper Methods
    
    func isCharacterInsertLocation(_ rangeLocation: Int) -> Bool {
        var isCharacterLocation = true
        
        for number in numbers {
            if number == rangeLocation + 2 {
                isCharacterLocation = false
            }
        }
        
        if rangeLocation == maximumCharactersLimit - 1 {
            return false
        }
        
        return isCharacterLocation
    }
    
    func removeAndInsertCharacter(at index: String.Index, withElement char: Character, for string: String) -> String {
        var updatedText = string
        updatedText.remove(at: index)
        updatedText.insert(char, at: index)
        return updatedText
    }
}
