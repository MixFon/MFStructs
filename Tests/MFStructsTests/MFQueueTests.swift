//
//  MFQueueTests.swift
//  
//
//  Created by Михаил Фокин on 03.12.2023.
//

import XCTest
@testable import MFStructs

final class MFQueueTests: XCTestCase {
	
	private var queue: MFQueue<Int>?

    override func setUpWithError() throws {
		self.queue = MFQueue<Int>()
    }

    override func tearDownWithError() throws {
		self.queue = nil
    }
	
	func testPush() {
		// Arrange
		let numbers = [1, 2, 3, 4, 5, 6]
		
		// Act
		
		// Assert
		XCTAssertNil(self.queue?.front)
		XCTAssertNil(self.queue?.back)
		XCTAssertEqual(self.queue?.count, 0)
		for (i, number) in numbers.enumerated() {
			self.queue?.push(number)
			XCTAssertEqual(self.queue?.front, numbers.first!)
			XCTAssertEqual(self.queue?.back, number)
			XCTAssertEqual(self.queue?.count, i + 1)
		}
		XCTAssertEqual(self.queue?.count, numbers.count)
	}
	
	func testPushRandomElements() {
		// Arrange
		let numbers = generateRandomIntArray(count: 10000, minValue: -10000, maxValue: 10000)
		
		// Act
		
		// Assert
		XCTAssertNil(self.queue?.front)
		XCTAssertNil(self.queue?.back)
		XCTAssertEqual(self.queue?.count, 0)
		for (i, number) in numbers.enumerated() {
			self.queue?.push(number)
			XCTAssertEqual(self.queue?.front, numbers.first!)
			XCTAssertEqual(self.queue?.back, number)
			XCTAssertEqual(self.queue?.count, i + 1)
		}
		XCTAssertEqual(self.queue?.count, numbers.count)
	}
	
	func testPushSequence() {
		XCTAssertEqual(self.queue?.count, 0)
		XCTAssertEqual(self.queue?.isEmpty, true)
		self.queue?.push([1, 3, 5, 6, 7])
		XCTAssertEqual(self.queue?.count, 5)
		XCTAssertEqual(self.queue?.isEmpty, false)
		self.queue?.push([8, 9, 10])
		XCTAssertEqual(self.queue?.count, 8)
		XCTAssertEqual(self.queue?.isEmpty, false)
		self.queue?.remoreAll()
		XCTAssertEqual(self.queue?.count, 0)
		XCTAssertEqual(self.queue?.isEmpty, true)
	}
	
	func testRemoveAll() {
		// Arrange
		let numbers = generateRandomIntArray(count: 10000, minValue: -10000, maxValue: 10000)
		
		// Act
		for number in numbers {
			self.queue?.push(number)
		}
		self.queue?.remoreAll()
		
		// Assert
		XCTAssertEqual(self.queue?.count, 0)
		XCTAssertNil(self.queue?.front)
		XCTAssertNil(self.queue?.back)
		XCTAssertTrue(self.queue?.isEmpty == true)
	}
	
	func testPop() {
		self.queue?.push(1)
		self.queue?.push(2)
		self.queue?.push(3)
		XCTAssertEqual(self.queue?.count, 3)
		XCTAssertEqual(self.queue?.pop(), 1)
		XCTAssertEqual(self.queue?.pop(), 2)
		XCTAssertEqual(self.queue?.count, 1)
		self.queue?.push(4)
		self.queue?.push(5)
		self.queue?.push(6)
		XCTAssertEqual(self.queue?.count, 4)
		XCTAssertEqual(self.queue?.pop(), 3)
		XCTAssertEqual(self.queue?.pop(), 4)
		XCTAssertEqual(self.queue?.count, 2)
		self.queue?.push(7)
		XCTAssertEqual(self.queue?.count, 3)
		XCTAssertEqual(self.queue?.pop(), 5)
		XCTAssertEqual(self.queue?.count, 2)
		XCTAssertEqual(self.queue?.pop(), 6)
		XCTAssertEqual(self.queue?.pop(), 7)
		XCTAssertEqual(self.queue?.count, 0)
		XCTAssertNil(self.queue?.pop())
		XCTAssertEqual(self.queue?.count, 0)
		XCTAssertNil(self.queue?.pop())
		XCTAssertEqual(self.queue?.count, 0)
		XCTAssertNil(self.queue?.pop())
		XCTAssertEqual(self.queue?.count, 0)
		XCTAssertNil(self.queue?.pop())
		XCTAssertEqual(self.queue?.count, 0)
		self.queue?.push(8)
		XCTAssertEqual(self.queue?.count, 1)
		XCTAssertEqual(self.queue?.pop(), 8)
		XCTAssertEqual(self.queue?.count, 0)
	}

	private func generateRandomIntArray(count: Int, minValue: Int, maxValue: Int) -> [Int] {
		return (0..<count).compactMap({_ in Int.random(in: minValue...maxValue)})
	}

}
