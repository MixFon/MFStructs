//
//  MFHeapTests.swift
//  
//
//  Created by Михаил Фокин on 02.12.2023.
//

import XCTest
@testable import MFStructs

final class MFHeapTests: XCTestCase {

	func testInsert() throws {
		// Arrange
		var numbers = [4, -1, 1, 100, 3, 5, 1, 3, 3, -11]
		let heap = MFHeap<Int>(priorityFunction: >)
		
		// Act
		for number in numbers {
			heap.insert(number)
		}
		
		// Assert
		numbers.sort(by: >)
		for number in numbers {
			XCTAssertEqual(heap.extract(), number)
		}
		XCTAssertNil(heap.extract())
	}
	
	func testMaxHeap() {
		// Arrange
		var numbers = generateRandomIntArray(count: 10000, minValue: -10000, maxValue: 10000)
		let heap = MFHeap<Int>(priorityFunction: >)
		
		// Act
		XCTAssertNil(heap.extract())
		XCTAssertNil(heap.peek)
		XCTAssertEqual(heap.count, 0)
		for number in numbers {
			heap.insert(number)
		}
		numbers.sort(by: >)
		
		// Assert
		for (i, number) in numbers.enumerated() {
			XCTAssertEqual(heap.count, numbers.count - i)
			XCTAssertNotNil(heap.peek)
			XCTAssertEqual(heap.extract(), number)
		}
		XCTAssertNil(heap.extract())
		XCTAssertNil(heap.peek)
		XCTAssertEqual(heap.count, 0)
	}
	
	func testMinHeap() {
		// Arrange
		var numbers = generateRandomIntArray(count: 10, minValue: -10000, maxValue: 10000)
		let heap = MFHeap<Int>(priorityFunction: <)
		
		// Act
		XCTAssertNil(heap.extract())
		XCTAssertNil(heap.peek)
		XCTAssertEqual(heap.count, 0)
		for number in numbers {
			heap.insert(number)
		}
		numbers.sort(by: <)
		
		// Assert
		for (i, number) in numbers.enumerated() {
			XCTAssertEqual(heap.count, numbers.count - i)
			XCTAssertNotNil(heap.peek)
			XCTAssertEqual(heap.extract(), number)
		}
		XCTAssertNil(heap.extract())
		XCTAssertNil(heap.peek)
		XCTAssertEqual(heap.count, 0)
	}
	
	private func generateRandomIntArray(count: Int, minValue: Int, maxValue: Int) -> [Int] {
		return (0..<count).compactMap({_ in Int.random(in: minValue...maxValue)})
	}
}
