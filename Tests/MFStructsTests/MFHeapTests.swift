//
//  MFHeapTests.swift
//  
//
//  Created by Михаил Фокин on 02.12.2023.
//

import XCTest
@testable import MFStructs

final class MFHeapTests: XCTestCase {
	
	private var heap: MFHeap<Int>?

    override func setUpWithError() throws {
		self.heap = MFHeap<Int>(priorityFunction: {$0 > $1})
    }

    override func tearDownWithError() throws {
		self.heap = nil
    }
	
	func testInsert() throws {
		// Arrange
		var numbers = [4, -1, 1, 100, 3, 5, 1, 3, 3, -11]
		
		// Act
		for number in numbers {
			self.heap?.insert(number)
		}
		
		// Assert
		numbers.sort(by: >)
		for number in numbers {
			XCTAssertEqual(self.heap?.extract(), number)
		}
		XCTAssertNil(self.heap?.extract())
	}
	
	func testInsertRantomNumbers() {
		// Arrange
		var numbers = generateRandomIntArray(count: 10000, minValue: -10000, maxValue: 10000)
		
		// Act
		for number in numbers {
			self.heap?.insert(number)
		}
		numbers.sort(by: >)
		
		// Assert
		for number in numbers {
			XCTAssertEqual(self.heap?.extract(), number)
		}
		XCTAssertNil(self.heap?.extract())
	}
	
	private func generateRandomIntArray(count: Int, minValue: Int, maxValue: Int) -> [Int] {
		return (0..<count).compactMap({_ in Int.random(in: minValue...maxValue)})
	}
}
