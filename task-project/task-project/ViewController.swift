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
    
    var viewModel: ControllerViewModel?
    
    // MARK:- View life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ControllerViewModel(numbers: [3, 7, 14], maximumLimit: 15)
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
        guard let viewModel = viewModel, let text = textField.text, range.location < viewModel.maximumCharactersLimit, string.isAlphaNumbericalString else { return false }

        if let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            configureTextfieldText(updatedText)
        }
        
        return viewModel.isCharacterInsertLocation(range.location)
    }
    
    func configureTextfieldText(_ text: String) {
        guard let viewModel = viewModel else { return }
        let numbers = viewModel.numbers
        let maximumCharactersLimit = viewModel.maximumCharactersLimit
        var modifiedText = text
        
        numbers.forEach { (number) in
            if number == text.count + 1 {
                if number == 7 {
                    modifiedText = viewModel.removeAndInsertCharacter(at: text.index(text.startIndex,
                                                                                     offsetBy: 1),
                                                                      withElement: "L",
                                                                      for: modifiedText)
                }
                
                if number == maximumCharactersLimit - 1 {
                    [8, 9, 10, 11, 12, 13].forEach { (num) in
                        modifiedText = viewModel.removeAndInsertCharacter(at: text.index(text.startIndex,
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
            textField.text = viewModel.removeAndInsertCharacter(at: text.index(text.startIndex,
                                                                               offsetBy: maximumCharactersLimit - 1),
                                                                withElement: "1",
                                                                for: modifiedText)
            return
        }
    }
}

extension String {
    var isAlphaNumbericalString: Bool {
        return self.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) == nil && self != ""
    }
}

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


