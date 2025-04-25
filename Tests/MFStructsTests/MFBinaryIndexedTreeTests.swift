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
		XCTAssertEqual(three.query(to: 1), 2)
	}


    func testPrefixSummOnInterval() throws {
		// Arrange
		let three = MFBinaryIndexedTree<Int>(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutralElement: 0,
			converter: +
		)
		func request(left: Int, right: Int) -> Int {
			return (three.query(to: right + 1) ?? 0) - (three.query(to: left) ?? 0)
		}
		
		// Act
		
		// Assert
		XCTAssertEqual(request(left: 0, right: 0), 2)
		XCTAssertEqual(request(left: 0, right: 1), 7)
		XCTAssertEqual(request(left: 0, right: 2), 10)
		XCTAssertEqual(request(left: 0, right: 3), 11)
		XCTAssertEqual(request(left: 0, right: 4), 18)
		XCTAssertEqual(request(left: 0, right: 5), 20)
		XCTAssertEqual(request(left: 0, right: 6), 24)

		XCTAssertEqual(request(left: 1, right: 1), 5)
		XCTAssertEqual(request(left: 1, right: 2), 8)
		XCTAssertEqual(request(left: 1, right: 3), 9)
		XCTAssertEqual(request(left: 1, right: 4), 16)
		XCTAssertEqual(request(left: 1, right: 5), 18)
		XCTAssertEqual(request(left: 1, right: 6), 22)

		XCTAssertEqual(request(left: 2, right: 2), 3)
		XCTAssertEqual(request(left: 2, right: 3), 4)
		XCTAssertEqual(request(left: 2, right: 4), 11)
		XCTAssertEqual(request(left: 2, right: 5), 13)
		XCTAssertEqual(request(left: 2, right: 6), 17)

		XCTAssertEqual(request(left: 3, right: 3), 1)
		XCTAssertEqual(request(left: 3, right: 4), 8)
		XCTAssertEqual(request(left: 3, right: 5), 10)
		XCTAssertEqual(request(left: 3, right: 6), 14)

		XCTAssertEqual(request(left: 4, right: 4), 7)
		XCTAssertEqual(request(left: 4, right: 5), 9)
		XCTAssertEqual(request(left: 4, right: 6), 13)

		XCTAssertEqual(request(left: 5, right: 5), 2)
		XCTAssertEqual(request(left: 5, right: 6), 6)

		XCTAssertEqual(request(left: 6, right: 6), 4)
    }

}
