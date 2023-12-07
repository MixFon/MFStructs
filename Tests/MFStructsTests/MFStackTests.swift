//
//  MFStackTests.swift
//  
//
//  Created by Михаил Фокин on 07.12.2023.
//

import XCTest
@testable import MFStructs

final class MFStackTests: XCTestCase {
	
	private var stack: MFStack<Int>?

    override func setUpWithError() throws {
		self.stack = MFStack()
    }

    override func tearDownWithError() throws {
		self.stack = nil
    }

	func testTop() {
		let numbers = [1, 2, 3, 4, 5, 6, 7]
		XCTAssertNil(self.stack?.top)
		for number in numbers {
			self.stack?.push(number)
			XCTAssertEqual(self.stack?.top, number)
		}
		for number in numbers.reversed() {
			XCTAssertNotNil(self.stack?.top)
			XCTAssertEqual(self.stack?.pop(), number)
		}
		XCTAssertNil(self.stack?.top)
	}
	
	func testTopSimple() {
		XCTAssertNil(self.stack?.top)
		self.stack?.push(3)
		self.stack?.push(4)
		XCTAssertEqual(self.stack?.top, 4)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.top, 3)
		self.stack?.push(5)
		self.stack?.push(6)
		self.stack?.push(7)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.top, 6)
		self.stack?.push(8)
		XCTAssertEqual(self.stack?.top, 8)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.top, 6)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.top, 5)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.top, 3)
		self.stack?.pop()
		XCTAssertNil(self.stack?.top)
		self.stack?.pop()
		XCTAssertNil(self.stack?.top)
	}
	
	func testEmpty() {
		XCTAssertEqual(self.stack?.isEmpty, true)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.isEmpty, true)
		self.stack?.push(1)
		XCTAssertEqual(self.stack?.isEmpty, false)
		self.stack?.push(2)
		XCTAssertEqual(self.stack?.isEmpty, false)
		self.stack?.pop()
		self.stack?.pop()
		XCTAssertEqual(self.stack?.isEmpty, true)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.isEmpty, true)
		
		self.stack?.push(2)
		self.stack?.push(3)
		self.stack?.push(4)
		XCTAssertEqual(self.stack?.isEmpty, false)
		self.stack?.remoreAll()
		XCTAssertEqual(self.stack?.isEmpty, true)
	}
	
	func testCount() {
		XCTAssertEqual(self.stack?.count, 0)
		self.stack?.push(1)
		XCTAssertEqual(self.stack?.count, 1)
		self.stack?.push(2)
		XCTAssertEqual(self.stack?.count, 2)
		self.stack?.push(3)
		self.stack?.push(4)
		XCTAssertEqual(self.stack?.count, 4)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.count, 3)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.count, 2)
		self.stack?.push(5)
		XCTAssertEqual(self.stack?.count, 3)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.count, 2)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.count, 1)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.count, 0)
	}
	
	func testPush() {
		XCTAssertEqual(self.stack?.isEmpty, true)
		XCTAssertEqual(self.stack?.count, 0)
		self.stack?.push(1)
		XCTAssertEqual(self.stack?.isEmpty, false)
		XCTAssertEqual(self.stack?.count, 1)
		self.stack?.pop()
		XCTAssertEqual(self.stack?.isEmpty, true)
		XCTAssertEqual(self.stack?.count, 0)
	}
	
	func testPushSequence() {
		XCTAssertEqual(self.stack?.isEmpty, true)
		XCTAssertEqual(self.stack?.count, 0)
		self.stack?.push([])
		XCTAssertEqual(self.stack?.isEmpty, true)
		XCTAssertEqual(self.stack?.count, 0)
		self.stack?.push([1, 2, 3])
		XCTAssertEqual(self.stack?.isEmpty, false)
		XCTAssertEqual(self.stack?.count, 3)
		self.stack?.push([4, 5, 6, 7])
		XCTAssertEqual(self.stack?.isEmpty, false)
		XCTAssertEqual(self.stack?.count, 7)
		self.stack?.remoreAll()
		XCTAssertEqual(self.stack?.isEmpty, true)
		XCTAssertEqual(self.stack?.count, 0)
	}
	
}
