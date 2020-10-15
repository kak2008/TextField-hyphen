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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textField.autocapitalizationType = .allCharacters
        textField.keyboardType = .alphabet
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text, range.location < 15, string.isAlphaNumbericalString else { return false }

        if let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            addHyphenTo(text: updatedText)
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
        return isCharacterLocation
    }
    
    func addHyphenTo(text: String) {
        var modifiedText = text
        numbers.forEach { (number) in
            if number == text.count + 1 {
                modifiedText.insert("-", at: text.index(text.startIndex, offsetBy: text.count))
                textField.text = modifiedText
                return
            }
        }
    }
}

extension String {
    var isAlphaNumbericalString: Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
}
