//
//  ControllerViewModelTests.swift
//  task-projectTests
//
//  Created by Anish on 10/14/20.
//  Copyright © 2020 Anish Kodeboyina. All rights reserved.
//

import XCTest
@testable import task_project

class ControllerViewModelTests: XCTestCase {
    var viewModel: ControllerViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = ControllerViewModel(numbers: [3, 7, 14], maximumLimit: 15)
    }
    
    func test_isCharacterLocation() {
        viewModel = ControllerViewModel(numbers: [3, 7, 14], maximumLimit: 15)
        
        [2, 8, 9].forEach { (rangeLocationNum) in
            XCTAssertTrue(viewModel.isCharacterInsertLocation(rangeLocationNum))
        }
        
        [3, 7, 14].forEach { (rangeLocationNum) in
            XCTAssertFalse(viewModel.isCharacterInsertLocation(rangeLocationNum - 2))
        }
        
        [14].forEach { (rangeLocationNum) in
            XCTAssertFalse(viewModel.isCharacterInsertLocation(rangeLocationNum))
        }
        
        [15].forEach { (rangeLocationNum) in
            XCTAssertTrue(viewModel.isCharacterInsertLocation(rangeLocationNum))
        }
    }
    
    func test_removeAndInsertCharacter() {
        let text = "Hello"
        let testText = viewModel.removeAndInsertCharacter(at: text.index(text.startIndex, offsetBy: 1),
                                                          withElement: "-",
                                                          for: text)
        XCTAssertEqual("H-llo", testText)
        
        let testText2 = viewModel.removeAndInsertCharacter(at: text.index(text.startIndex, offsetBy: 1),
                                                          withElement: "E",
                                                          for: text)
        XCTAssertEqual("HEllo", testText2)
        
        var text2 = "1ayub-i1892"
        [3, 5, 8].forEach { (num) in
            let testText3 = viewModel.removeAndInsertCharacter(at: text2.index(text.startIndex, offsetBy: num),
                                                               withElement: "-",
                                                               for: text2)
            text2 = testText3
        }
        XCTAssertEqual("1ay-b-i1-92", text2)
    }
}
