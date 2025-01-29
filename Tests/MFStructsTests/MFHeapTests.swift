//
//  MFHeapTests.swift
//  
//
//  Created by Михаил Фокин on 02.12.2023.
//

import XCTest
@testable import MFStructs

final class MFHeapTests: XCTestCase {
	
	func testInit() {
		// Arrange
		let heap = MFHeap<Int>(priorityFunction: >)
		
		// Act
		
		// Assert
		XCTAssertNil(heap.extract())
		XCTAssertNil(heap.peek)
		XCTAssertEqual(heap.count, 0)
	}

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
		XCTAssertNil(heap.peek)
		XCTAssertEqual(heap.count, 0)
	}
	
	func testMaxHeap() {
		// Arrange
		var numbers = generateRandomIntArray(count: 10000, minValue: -10000, maxValue: 10000)
		let heap = MFHeap<Int>(priorityFunction: >)
		
		// Act
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
	
	func testLimiter() {
		// Arrange
		let limiter = 3
		let numbers = generateRandomIntArray(count: 10, minValue: -10000, maxValue: 10000)
		let heap = MFLimitedHeap<Int>(limiter: limiter, priorityFunction: <)
		
		// Act
		
		// Assert
		for (i, number) in numbers.enumerated() {
			heap.insert(number, complitionRemove: { _ in })
			if i < limiter {
				XCTAssertEqual(heap.count, i + 1)
			} else {
				XCTAssertEqual(heap.count, limiter)
			}
		}
	}
	
	func testLimiterZero() {
		// Arrange
		let limiter = 0
		let numbers = generateRandomIntArray(count: 10, minValue: -10000, maxValue: 10000)
		let heap = MFLimitedHeap<Int>(limiter: limiter, priorityFunction: <)
		
		// Act
		
		// Assert
		for (i, number) in numbers.enumerated() {
			heap.insert(number, complitionRemove: { _ in })
			if i < limiter {
				XCTAssertEqual(heap.count, i + 1)
			} else {
				XCTAssertEqual(heap.count, limiter)
			}
		}
	}
	
	func testLimiterRandom() {
		// Arrange
		let count = Int.random(in: 0...100)
		let limiter = Int.random(in: 0...count)
		let numbers = generateRandomIntArray(count: count, minValue: -10000, maxValue: 10000)
		let heap = MFLimitedHeap<Int>(limiter: limiter, priorityFunction: <)
		
		// Act
		
		// Assert
		for (i, number) in numbers.enumerated() {
			heap.insert(number, complitionRemove: { _ in })
			if i < limiter {
				XCTAssertEqual(heap.count, i + 1)
			} else {
				XCTAssertEqual(heap.count, limiter)
			}
		}
	}
	
	func testComplitionRemove() {
		// Arrange
		let limiter = 3
		let heap = MFLimitedHeap<Int>(limiter: limiter, priorityFunction: <)
		
		// Act
		
		// Assert
		// []
		heap.insert(3) { int in
			XCTFail("Этот участок кода не должен быть выполнен")
		}
		// [3]
		heap.insert(8) { int in
			XCTFail("Этот участок кода не должен быть выполнен")
		}
		// [3, 8]
		heap.insert(5) { int in
			XCTFail("Этот участок кода не должен быть выполнен")
		}
		// [3, 8, 5]
		heap.insert(4) { int in
			XCTAssertEqual(int, 8)
		}
		// [3, 4, 5]
		heap.insert(10) { int in
			XCTAssertEqual(int, 10)
		}
		// [3, 4, 5]
		heap.insert(4) { int in
			XCTAssertEqual(int, 5)
		}
		// [3, 4, 4]
		heap.insert(2) { int in
			XCTAssertEqual(int, 4)
		}
		// [3, 2, 4]
		heap.insert(2) { int in
			XCTAssertEqual(int, 4)
		}
		// [3, 2, 2]
		heap.insert(4) { int in
			XCTAssertEqual(int, 4)
		}
		// [3, 2, 2]
		XCTAssertEqual(heap.extract(), 2)
		// [3, 2]
		XCTAssertEqual(heap.extract(), 2)
		// [3]
		heap.insert(21) { int in
			XCTFail("Этот участок кода не должен быть выполнен")
		}
		// [3, 21]
		heap.insert(10) { int in
			XCTFail("Этот участок кода не должен быть выполнен")
		}
		// [3, 21, 10]
		heap.insert(19) { int in
			XCTAssertEqual(int, 21)
		}
	}
	
	func testComplitionRemoveLimitZero() {
		// Arrange
		let limiter = 0
		let heap = MFLimitedHeap<Int>(limiter: limiter, priorityFunction: <)
		
		// Act
		
		// Assert
		// []
		heap.insert(3) { int in
			XCTAssertEqual(int, 3)
		}
		XCTAssertEqual(heap.count, 0)
		// []
		heap.insert(4) { int in
			XCTAssertEqual(int, 4)
		}
		XCTAssertEqual(heap.count, 0)
	}
	
	func testComplitionRemoveLimitOne() {
		// Arrange
		let limiter = 1
		let heap = MFLimitedHeap<Int>(limiter: limiter, priorityFunction: <)
		
		// Act
		
		// Assert
		// []
		heap.insert(3) { int in
			XCTFail("Этот участок кода не должен быть выполнен")
		}
		XCTAssertEqual(heap.count, 1)
		// [3]
		heap.insert(4) { int in
			XCTAssertEqual(int, 4)
		}
		XCTAssertEqual(heap.count, 1)
		// [3]
		heap.insert(2) { int in
			XCTAssertEqual(int, 3)
		}
		XCTAssertEqual(heap.count, 1)
		// [2]
		heap.insert(5) { int in
			XCTAssertEqual(int, 5)
		}
		XCTAssertEqual(heap.count, 1)
		// [2]
		heap.insert(1) { int in
			XCTAssertEqual(int, 2)
		}
		XCTAssertEqual(heap.count, 1)
		// [2]
	}
	
	private func generateRandomIntArray(count: Int, minValue: Int, maxValue: Int) -> [Int] {
		return (0..<count).compactMap({_ in Int.random(in: minValue...maxValue)})
	}
}
