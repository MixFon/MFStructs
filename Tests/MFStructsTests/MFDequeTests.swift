//
//  MFDequeTests.swift
//  MFStructs
//
//  Created by Михаил Фокин on 01.05.2025.
//

import XCTest
@testable import MFStructs

final class MFDequeTests: XCTestCase {
	
	private var deque: MFDeque<Int>?

	override func setUpWithError() throws {
		self.deque = MFDeque<Int>()
	}

	override func tearDownWithError() throws {
		self.deque = nil
	}
	
	func testPushFont() {
		// Arrange
		let numbers = [1, 2, 3, 4, 5, 6]
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		for (i, number) in numbers.enumerated() {
			self.deque?.pushFront(number)
			XCTAssertEqual(self.deque?.front, number)
			XCTAssertEqual(self.deque?.back, numbers.first!)
			XCTAssertEqual(self.deque?.count, i + 1)
		}
		XCTAssertEqual(self.deque?.count, numbers.count)
	}
	
	func testPushFontRandom() {
		// Arrange
		let numbers = generateRandomIntArray(count: 100, minValue: -1000, maxValue: 1000)
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		for (i, number) in numbers.enumerated() {
			self.deque?.pushFront(number)
			XCTAssertEqual(self.deque?.front, number)
			XCTAssertEqual(self.deque?.back, numbers.first!)
			XCTAssertEqual(self.deque?.count, i + 1)
		}
		XCTAssertEqual(self.deque?.count, numbers.count)
	}
	
	func testPushFontSequence() {
		// Arrange
		let numbers = [1, 2, 3, 4, 5, 6]
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		self.deque?.pushFront(numbers)
		var i = numbers.count - 1
		while let element = self.deque?.popFront() {
			XCTAssertEqual(element, numbers[i])
			i -= 1
		}
		XCTAssertEqual(self.deque?.count, 0)
	}
	
	func testPushFontRandomSequence() {
		// Arrange
		let numbers = generateRandomIntArray(count: 100, minValue: -1000, maxValue: 1000)
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		self.deque?.pushFront(numbers)
		var i = numbers.count - 1
		while let element = self.deque?.popFront() {
			XCTAssertEqual(element, numbers[i])
			i -= 1
		}
		XCTAssertEqual(self.deque?.count, 0)
	}
	
	func testPushBack() {
		// Arrange
		let numbers = [1, 2, 3, 4, 5, 6]
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		for (i, number) in numbers.enumerated() {
			self.deque?.pushBack(number)
			XCTAssertEqual(self.deque?.front, numbers.first!)
			XCTAssertEqual(self.deque?.back, number)
			XCTAssertEqual(self.deque?.count, i + 1)
		}
		XCTAssertEqual(self.deque?.count, numbers.count)
	}
	
	func testPushBackRandom() {
		// Arrange
		let numbers = generateRandomIntArray(count: 100, minValue: -1000, maxValue: 1000)
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		for (i, number) in numbers.enumerated() {
			self.deque?.pushBack(number)
			XCTAssertEqual(self.deque?.front, numbers.first!)
			XCTAssertEqual(self.deque?.back, number)
			XCTAssertEqual(self.deque?.count, i + 1)
		}
		XCTAssertEqual(self.deque?.count, numbers.count)
	}
	
	func testPushFrontPushBack() {
		// Arrange
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		// [1]
		self.deque?.pushFront(1)
		XCTAssertEqual(self.deque?.front, 1)
		XCTAssertEqual(self.deque?.back, 1)
		XCTAssertEqual(self.deque?.count, 1)
		// [1, 2]
		self.deque?.pushBack(2)
		XCTAssertEqual(self.deque?.front, 1)
		XCTAssertEqual(self.deque?.back, 2)
		XCTAssertEqual(self.deque?.count, 2)
		// [3, 1, 2]
		self.deque?.pushFront(3)
		XCTAssertEqual(self.deque?.front, 3)
		XCTAssertEqual(self.deque?.back, 2)
		XCTAssertEqual(self.deque?.count, 3)
		// [4, 3, 1, 2]
		self.deque?.pushFront(4)
		XCTAssertEqual(self.deque?.front, 4)
		XCTAssertEqual(self.deque?.back, 2)
		XCTAssertEqual(self.deque?.count, 4)

		// [4, 3, 1, 2, 5]
		self.deque?.pushBack(5)
		XCTAssertEqual(self.deque?.front, 4)
		XCTAssertEqual(self.deque?.back, 5)
		XCTAssertEqual(self.deque?.count, 5)
		
		// [4, 3, 1, 2, 5, 6]
		self.deque?.pushBack(6)
		XCTAssertEqual(self.deque?.front, 4)
		XCTAssertEqual(self.deque?.back, 6)
		XCTAssertEqual(self.deque?.count, 6)
	}
	
	func testPopFront() {
		// Arrange
		let numbers = [1, 2, 3, 4, 5, 6]
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		self.deque?.pushBack(numbers)
		XCTAssertEqual(self.deque?.count, numbers.count)
		for (i, number) in numbers.enumerated() {
			XCTAssertEqual(self.deque?.back, numbers.last)
			let element = self.deque?.popFront()
			XCTAssertEqual(element, number)
			XCTAssertEqual(self.deque?.count, 6 - i - 1)
		}
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
	}
	
	func testPopFrontRandom() {
		// Arrange
		let numbers = generateRandomIntArray(count: 100, minValue: -1000, maxValue: 1000)
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		self.deque?.pushBack(numbers)
		XCTAssertEqual(self.deque?.count, numbers.count)
		for (i, number) in numbers.enumerated() {
			XCTAssertEqual(self.deque?.back, numbers.last)
			let element = self.deque?.popFront()
			XCTAssertEqual(element, number)
			XCTAssertEqual(self.deque?.count, numbers.count - i - 1)
		}
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
	}
	
	func testRemoveAllRandom() {
		// Arrange
		let numbers = generateRandomIntArray(count: 100, minValue: -1000, maxValue: 1000)
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		self.deque?.pushBack(numbers)
		XCTAssertNotNil(self.deque?.front)
		XCTAssertNotNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, numbers.count)
		XCTAssertEqual(self.deque?.front, numbers.first)
		XCTAssertEqual(self.deque?.back, numbers.last)
		self.deque?.remoreAll()
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		XCTAssertTrue(self.deque?.isEmpty == true)
	}
	
	func testPopBack() {
		// Arrange
		let numbers = [1, 2, 3, 4, 5, 6]
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		self.deque?.pushBack(numbers)
		XCTAssertEqual(self.deque?.count, numbers.count)
		for (i, number) in numbers.reversed().enumerated() {
			XCTAssertEqual(self.deque?.front, numbers.first)
			let element = self.deque?.popBack()
			XCTAssertEqual(element, number)
			XCTAssertEqual(self.deque?.count, 6 - i - 1)
		}
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
	}
	
	func testPopBackRandom() {
		// Arrange
		let numbers = generateRandomIntArray(count: 100, minValue: -1000, maxValue: 1000)
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		self.deque?.pushBack(numbers)
		XCTAssertEqual(self.deque?.count, numbers.count)
		for (i, number) in numbers.reversed().enumerated() {
			XCTAssertEqual(self.deque?.front, numbers.first)
			let element = self.deque?.popBack()
			XCTAssertEqual(element, number)
			XCTAssertEqual(self.deque?.count, numbers.count - i - 1)
		}
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
	}
	
	func testPushFrontPushBackPopFrontPopBack() {
		// Arrange
		var element: Int?
		
		// Act
		
		// Assert
		XCTAssertNil(self.deque?.front)
		XCTAssertNil(self.deque?.back)
		XCTAssertEqual(self.deque?.count, 0)
		// [1]
		self.deque?.pushFront(1)
		XCTAssertEqual(self.deque?.front, 1)
		XCTAssertEqual(self.deque?.back, 1)
		XCTAssertEqual(self.deque?.count, 1)
		// [1, 2]
		self.deque?.pushBack(2)
		XCTAssertEqual(self.deque?.front, 1)
		XCTAssertEqual(self.deque?.back, 2)
		XCTAssertEqual(self.deque?.count, 2)
		// [1]
		element = self.deque?.popBack()
		XCTAssertEqual(self.deque?.front, 1)
		XCTAssertEqual(self.deque?.back, 1)
		XCTAssertEqual(self.deque?.count, 1)
		XCTAssertEqual(element, 2)
		// [3, 1]
		self.deque?.pushFront(3)
		XCTAssertEqual(self.deque?.front, 3)
		XCTAssertEqual(self.deque?.back, 1)
		XCTAssertEqual(self.deque?.count, 2)
		// [3, 1, 4]
		self.deque?.pushBack(4)
		XCTAssertEqual(self.deque?.front, 3)
		XCTAssertEqual(self.deque?.back, 4)
		XCTAssertEqual(self.deque?.count, 3)
		// [1, 4]
		element = self.deque?.popFront()
		XCTAssertEqual(self.deque?.front, 1)
		XCTAssertEqual(self.deque?.back, 4)
		XCTAssertEqual(self.deque?.count, 2)
		XCTAssertEqual(element, 3)
		// [1]
		element = self.deque?.popBack()
		XCTAssertEqual(self.deque?.front, 1)
		XCTAssertEqual(self.deque?.back, 1)
		XCTAssertEqual(self.deque?.count, 1)
		XCTAssertEqual(element, 4)
		// []
		element = self.deque?.popFront()
		XCTAssertEqual(self.deque?.front, nil)
		XCTAssertEqual(self.deque?.back, nil)
		XCTAssertEqual(self.deque?.count, 0)
		XCTAssertEqual(element, 1)
		// []
		element = self.deque?.popFront()
		XCTAssertEqual(self.deque?.front, nil)
		XCTAssertEqual(self.deque?.back, nil)
		XCTAssertEqual(self.deque?.count, 0)
		XCTAssertEqual(element, nil)
		// []
		element = self.deque?.popBack()
		XCTAssertEqual(self.deque?.front, nil)
		XCTAssertEqual(self.deque?.back, nil)
		XCTAssertEqual(self.deque?.count, 0)
		XCTAssertEqual(element, nil)
		// []
		element = self.deque?.popBack()
		XCTAssertEqual(self.deque?.front, nil)
		XCTAssertEqual(self.deque?.back, nil)
		XCTAssertEqual(self.deque?.count, 0)
		XCTAssertEqual(element, nil)
		// [5]
		self.deque?.pushFront(5)
		XCTAssertEqual(self.deque?.front, 5)
		XCTAssertEqual(self.deque?.back, 5)
		XCTAssertEqual(self.deque?.count, 1)
		// [5, 6]
		self.deque?.pushBack(6)
		XCTAssertEqual(self.deque?.front, 5)
		XCTAssertEqual(self.deque?.back, 6)
		XCTAssertEqual(self.deque?.count, 2)
	}
	
	
	private func generateRandomIntArray(count: Int, minValue: Int, maxValue: Int) -> [Int] {
		return (0..<count).compactMap({_ in Int.random(in: minValue...maxValue)})
	}

}
