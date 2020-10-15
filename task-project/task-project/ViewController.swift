//
//  ViewController.swift
//  task-project
//
//  Created by Anish on 10/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!

    let numbers = [3, 7, 14]
    let maximumCharactersLimit = 15
    
    // MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
    }
    
    // MARK:- Helper methods
    
    func configureTextField() {
        textField.delegate = self
        textField.autocapitalizationType = .allCharacters
        textField.keyboardType = .alphabet
    }
    
    
    // MARK:- Textfield Delegate Methods

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, range.location < maximumCharactersLimit, string.isAlphaNumbericalString else { return false }

        if let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            configureTextfieldText(updatedText)
        }
        
        return isCharacterLocation(numbers: numbers, rangeLocation: range.location)
    }
    
    func isCharacterLocation(numbers: [Int], rangeLocation: Int) -> Bool {
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
    
    func configureTextfieldText(_ text: String) {
        var modifiedText = text
        numbers.forEach { (number) in
            if number == text.count + 1 {
                if number == 7 {
                    modifiedText = removeAndInsertCharacter(at: text.index(text.startIndex,
                                                                           offsetBy: 1),
                                                            withElement: "L",
                                                            for: modifiedText)
                }
                
                if number == maximumCharactersLimit - 1 {
                    [8, 9, 10, 11, 12, 13].forEach { (num) in
                        modifiedText = removeAndInsertCharacter(at: text.index(text.startIndex,
                                                                               offsetBy: num - 1),
                                                                withElement: "1",
                                                                for: modifiedText)
                    }
                }
                
                modifiedText.insert("-", at: text.index(text.startIndex, offsetBy: text.count))
                textField.text = modifiedText
                return
            }
        }
        
        if text.count == maximumCharactersLimit {
            textField.text = removeAndInsertCharacter(at: text.index(text.startIndex,
                                                                     offsetBy: maximumCharactersLimit - 1),
                                                      withElement: "1",
                                                      for: modifiedText)
            return
        }
    }
    
    func removeAndInsertCharacter(at index: String.Index, withElement char: Character, for string: String) -> String {
        var updatedText = string
        updatedText.remove(at: index)
        updatedText.insert(char, at: index)
        return updatedText
    }
}

extension String {
    var isAlphaNumbericalString: Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
}
