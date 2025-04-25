//
//  MFBinaryIndexedTreeTests.swift
//  MFStructs
//
//  Created by Михаил Фокин on 26.04.2025.
//

import XCTest
@testable import MFStructs

final class MFBinaryIndexedTreeTests: XCTestCase {
	
	func testPrefixSumm() {
		// Arrange
		let three = MFBinaryIndexedTree<Int>(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutralElement: 0,
			converter: +
		)
		
		// Act
		
		// Assert
		XCTAssertEqual(three.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(three.query(to: 1), 2)     // [2]
		XCTAssertEqual(three.query(to: 2), 7)     // [2, 5]
		XCTAssertEqual(three.query(to: 3), 10)    // [2, 5, 3]
		XCTAssertEqual(three.query(to: 4), 11)    // [2, 5, 3, 1]
		XCTAssertEqual(three.query(to: 5), 18)    // [2, 5, 3, 1, 7]
		XCTAssertEqual(three.query(to: 6), 20)    // [2, 5, 3, 1, 7, 2]
		XCTAssertEqual(three.query(to: 7), 24)    // [2, 5, 3, 1, 7, 2, 4]
		XCTAssertEqual(three.query(to: 8), nil)   // nil
	}


    func testPrefixSummOnInterval() throws {
		// Arrange
		let three = MFBinaryIndexedTree<Int>(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutralElement: 0,
			converter: +
		)
		func request(left: Int, right: Int) -> Int {
			return (three.query(to: right) ?? 0) - (three.query(to: left - 1) ?? 0)
		}
		
		// Act
		
		// Assert
		XCTAssertEqual(request(left: 1, right: 1), 2)
		XCTAssertEqual(request(left: 1, right: 2), 7)
		XCTAssertEqual(request(left: 1, right: 3), 10)
		XCTAssertEqual(request(left: 1, right: 4), 11)
		XCTAssertEqual(request(left: 1, right: 5), 18)
		XCTAssertEqual(request(left: 1, right: 6), 20)
		XCTAssertEqual(request(left: 1, right: 7), 24)

		XCTAssertEqual(request(left: 2, right: 2), 5)
		XCTAssertEqual(request(left: 2, right: 3), 8)
		XCTAssertEqual(request(left: 2, right: 4), 9)
		XCTAssertEqual(request(left: 2, right: 5), 16)
		XCTAssertEqual(request(left: 2, right: 6), 18)
		XCTAssertEqual(request(left: 2, right: 7), 22)

		XCTAssertEqual(request(left: 3, right: 3), 3)
		XCTAssertEqual(request(left: 3, right: 4), 4)
		XCTAssertEqual(request(left: 3, right: 5), 11)
		XCTAssertEqual(request(left: 3, right: 6), 13)
		XCTAssertEqual(request(left: 3, right: 7), 17)

		XCTAssertEqual(request(left: 4, right: 4), 1)
		XCTAssertEqual(request(left: 4, right: 5), 8)
		XCTAssertEqual(request(left: 4, right: 6), 10)
		XCTAssertEqual(request(left: 4, right: 7), 14)

		XCTAssertEqual(request(left: 5, right: 5), 7)
		XCTAssertEqual(request(left: 5, right: 6), 9)
		XCTAssertEqual(request(left: 5, right: 7), 13)

		XCTAssertEqual(request(left: 6, right: 6), 2)
		XCTAssertEqual(request(left: 6, right: 7), 6)

		XCTAssertEqual(request(left: 7, right: 7), 4)
    }

}
