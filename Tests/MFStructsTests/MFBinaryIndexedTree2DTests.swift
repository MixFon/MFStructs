//
//  MFBinaryIndexedTree2DTests.swift
//  MFStructs
//
//  Created by Михаил Фокин on 26.04.2025.
//

import XCTest
@testable import MFStructs

final class MFBinaryIndexedTree2DTests: XCTestCase {

	func testPrefixSumm() {
		// Arrange
		let matrix = [
			[2, 5, 3, 1],
			[3, 5, 8, 6],
			[1, 4, 7, 2],
			[9, 6, 5, 8]
		]
		let tree = MFBinaryIndexedTree2D<Int>(
			matrix: matrix,
			neutral: 0,
			converter: +,
			stabilizer: -
		)
		
		// Act
		
		// Assert
		XCTAssertEqual(tree.query(x: 0, y: 0), 0)	// Нейтральный элемент
		XCTAssertEqual(tree.query(x: 1, y: 1), 2)	// [[2]]
		XCTAssertEqual(tree.query(x: 1, y: 2), 7)	// [[2, 5]]
		XCTAssertEqual(tree.query(x: 1, y: 3), 10)	// [[2, 5, 3]]
		XCTAssertEqual(tree.query(x: 1, y: 4), 11)	// [[2, 5, 3, 1]]
		
		XCTAssertEqual(tree.query(x: 2, y: 1), 5)	// [[2], [3]]
		XCTAssertEqual(tree.query(x: 2, y: 2), 15)	// [[2, 5], [3, 5]]
		XCTAssertEqual(tree.query(x: 2, y: 3), 26)	// [[2, 5, 3], [3, 5, 8]]
		XCTAssertEqual(tree.query(x: 2, y: 4), 33)	// [[2, 5, 3, 1], [3, 5, 8, 6]]
		
		XCTAssertEqual(tree.query(x: 3, y: 1), 6)	// [[2], [3], [1]]
		XCTAssertEqual(tree.query(x: 3, y: 2), 20)	// [[2, 5], [3, 5], [1, 4]]
		XCTAssertEqual(tree.query(x: 3, y: 3), 38)	// [[2, 5, 3], [3, 5, 8], [1, 4, 7]]
		XCTAssertEqual(tree.query(x: 3, y: 4), 47)	// [[2, 5, 3, 1], [3, 5, 8, 6], [1, 4, 7, 2]]
		
		XCTAssertEqual(tree.query(x: 4, y: 1), 15)	// [[2], [3], [1], [9]]
		XCTAssertEqual(tree.query(x: 4, y: 2), 35)	// [[2, 5], [3, 5], [1, 4], [9, 6]]
		XCTAssertEqual(tree.query(x: 4, y: 3), 58)	// [[2, 5, 3], [3, 5, 8], [1, 4, 7], [9, 6, 5]]
		XCTAssertEqual(tree.query(x: 4, y: 4), 75)	// [[2, 5, 3, 1], [3, 5, 8, 6], [1, 4, 7, 2], [9, 6, 5, 8]]

		XCTAssertEqual(tree.query(x: 5, y: 5), nil)   // nil
	}
	
	func testUpdate() {
		// Arrange
		let matrix = [
			[2, 5, 3, 1],
			[3, 5, 8, 6],
			[1, 4, 7, 2],
			[9, 6, 5, 8]
		]
		let tree = MFBinaryIndexedTree2D<Int>(
			matrix: matrix,
			neutral: 0,
			converter: +,
			stabilizer: -
		)
		
		// Act
		
		// Assert
		tree.update(4, x: 1, y: 4)
		XCTAssertEqual(tree.query(x: 0, y: 0), 0)	// Нейтральный элемент
		XCTAssertEqual(tree.query(x: 1, y: 1), 2)	// [[2]]
		XCTAssertEqual(tree.query(x: 1, y: 2), 7)	// [[2, 5]]
		XCTAssertEqual(tree.query(x: 1, y: 3), 10)	// [[2, 5, 3]]
		XCTAssertEqual(tree.query(x: 1, y: 4), 14)	// [[2, 5, 3, 4]]
		
		XCTAssertEqual(tree.query(x: 2, y: 1), 5)	// [[2], [3]]
		XCTAssertEqual(tree.query(x: 2, y: 2), 15)	// [[2, 5], [3, 5]]
		XCTAssertEqual(tree.query(x: 2, y: 3), 26)	// [[2, 5, 3], [3, 5, 8]]
		XCTAssertEqual(tree.query(x: 2, y: 4), 36)	// [[2, 5, 3, 4], [3, 5, 8, 6]]
		
		XCTAssertEqual(tree.query(x: 3, y: 1), 6)	// [[2], [3], [1]]
		XCTAssertEqual(tree.query(x: 3, y: 2), 20)	// [[2, 5], [3, 5], [1, 4]]
		XCTAssertEqual(tree.query(x: 3, y: 3), 38)	// [[2, 5, 3], [3, 5, 8], [1, 4, 7]]
		XCTAssertEqual(tree.query(x: 3, y: 4), 50)	// [[2, 5, 3, 4], [3, 5, 8, 6], [1, 4, 7, 2]]
		
		XCTAssertEqual(tree.query(x: 4, y: 1), 15)	// [[2], [3], [1], [9]]
		XCTAssertEqual(tree.query(x: 4, y: 2), 35)	// [[2, 5], [3, 5], [1, 4], [9, 6]]
		XCTAssertEqual(tree.query(x: 4, y: 3), 58)	// [[2, 5, 3], [3, 5, 8], [1, 4, 7], [9, 6, 5]]
		XCTAssertEqual(tree.query(x: 4, y: 4), 78)	// [[2, 5, 3, 4], [3, 5, 8, 6], [1, 4, 7, 2], [9, 6, 5, 8]]

		XCTAssertEqual(tree.query(x: 5, y: 5), nil)   // nil
	}

}
