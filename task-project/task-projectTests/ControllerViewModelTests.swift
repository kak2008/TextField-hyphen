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
}
