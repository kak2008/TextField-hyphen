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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.autocapitalizationType = .allCharacters
        textField.keyboardType = .alphabet
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, range.location < maximumCharactersLimit, string.isAlphaNumbericalString else { return false }

        if let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            addHyphenTo(text: updatedText)
        }
        
        return isCharacterLocation(numbers: numbers, rangeLocation: range.location)
    }
    
    func isCharacterLocation(numbers: [Int], rangeLocation: Int) -> Bool {
        var isCharacterLocation = true
        
        numbers.forEach { (number) in
            isCharacterLocation = (number != rangeLocation + 2)
        }
        
        if rangeLocation == maximumCharactersLimit - 1 {
            return false
        }
        
        return isCharacterLocation
    }
    
    func addHyphenTo(text: String) {
        var modifiedText = text
        numbers.forEach { (number) in
            if number == text.count + 1 {
                if number == 7 {
                    modifiedText.remove(at: text.index(text.startIndex, offsetBy: 1))
                    modifiedText.insert("L", at: text.index(text.startIndex, offsetBy: 1))
                }
                
                if number == maximumCharactersLimit - 1 {
                    [8, 9, 10, 11, 12, 13].forEach { (num) in
                        modifiedText.remove(at: text.index(text.startIndex, offsetBy: num - 1))
                        modifiedText.insert("1", at: text.index(text.startIndex, offsetBy: num - 1))
                    }
                }
                
                modifiedText.insert("-", at: text.index(text.startIndex, offsetBy: text.count))
                textField.text = modifiedText
                return
            }
        }
        
        if text.count == maximumCharactersLimit {
            modifiedText.remove(at: text.index(text.startIndex, offsetBy: maximumCharactersLimit - 1))
            modifiedText.insert("1", at: text.index(text.startIndex, offsetBy: maximumCharactersLimit - 1))
            textField.text = modifiedText
            return
        }
    }
}

extension String {
    var isAlphaNumbericalString: Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
}
