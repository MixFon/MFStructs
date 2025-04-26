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
		let tree = MFBinaryIndexedTree<Int>(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutral: 0,
			converter: +,
			stabilizer: -
		)
		
		// Act
		
		// Assert
		XCTAssertEqual(tree.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(tree.query(to: 1), 2)     // [2]
		XCTAssertEqual(tree.query(to: 2), 7)     // [2, 5]
		XCTAssertEqual(tree.query(to: 3), 10)    // [2, 5, 3]
		XCTAssertEqual(tree.query(to: 4), 11)    // [2, 5, 3, 1]
		XCTAssertEqual(tree.query(to: 5), 18)    // [2, 5, 3, 1, 7]
		XCTAssertEqual(tree.query(to: 6), 20)    // [2, 5, 3, 1, 7, 2]
		XCTAssertEqual(tree.query(to: 7), 24)    // [2, 5, 3, 1, 7, 2, 4]
		XCTAssertEqual(tree.query(to: 8), nil)   // nil
	}


    func testPrefixSummOnInterval() throws {
		// Arrange
		let tree = MFBinaryIndexedTree<Int>(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutral: 0,
			converter: +,
			stabilizer: -
		)
		func request(left: Int, right: Int) -> Int {
			return (tree.query(to: right) ?? 0) - (tree.query(to: left - 1) ?? 0)
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
	
	func testUpdate() {
		// Arrange
		let tree = MFBinaryIndexedTree<Int>(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutral: 0,
			converter: +,
			stabilizer: -
		)
		
		// Act
		
		
		// Assert
												  // [2, 5, 3, 1, 7, 2, 4]
		XCTAssertEqual(tree.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(tree.query(to: 1), 2)     // [2]
		XCTAssertEqual(tree.query(to: 2), 7)     // [2, 5]
		XCTAssertEqual(tree.query(to: 3), 10)    // [2, 5, 3]
		XCTAssertEqual(tree.query(to: 4), 11)    // [2, 5, 3, 1]
		XCTAssertEqual(tree.query(to: 5), 18)    // [2, 5, 3, 1, 7]
		XCTAssertEqual(tree.query(to: 6), 20)    // [2, 5, 3, 1, 7, 2]
		XCTAssertEqual(tree.query(to: 7), 24)    // [2, 5, 3, 1, 7, 2, 4]
		XCTAssertEqual(tree.query(to: 8), nil)   // nil
		
		tree.update(6, at: 5) 					 // [2, 5, 3, 1, 6, 2, 4]
		XCTAssertEqual(tree.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(tree.query(to: 1), 2)     // [2]
		XCTAssertEqual(tree.query(to: 2), 7)     // [2, 5]
		XCTAssertEqual(tree.query(to: 3), 10)    // [2, 5, 3]
		XCTAssertEqual(tree.query(to: 4), 11)    // [2, 5, 3, 1]
		XCTAssertEqual(tree.query(to: 5), 17)    // [2, 5, 3, 1, 6]
		XCTAssertEqual(tree.query(to: 6), 19)    // [2, 5, 3, 1, 6, 2]
		XCTAssertEqual(tree.query(to: 7), 23)    // [2, 5, 3, 1, 6, 2, 4]
		XCTAssertEqual(tree.query(to: 8), nil)   // nil
		
		tree.update(6, at: 5) 					 // [2, 5, 3, 1, 6, 2, 4] (copy)
		XCTAssertEqual(tree.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(tree.query(to: 1), 2)     // [2]
		XCTAssertEqual(tree.query(to: 2), 7)     // [2, 5]
		XCTAssertEqual(tree.query(to: 3), 10)    // [2, 5, 3]
		XCTAssertEqual(tree.query(to: 4), 11)    // [2, 5, 3, 1]
		XCTAssertEqual(tree.query(to: 5), 17)    // [2, 5, 3, 1, 6]
		XCTAssertEqual(tree.query(to: 6), 19)    // [2, 5, 3, 1, 6, 2]
		XCTAssertEqual(tree.query(to: 7), 23)    // [2, 5, 3, 1, 6, 2, 4]
		XCTAssertEqual(tree.query(to: 8), nil)   // nil
		
		tree.update(10, at: 5) 					 // [2, 5, 3, 1, 10, 2, 4]
		XCTAssertEqual(tree.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(tree.query(to: 1), 2)     // [2]
		XCTAssertEqual(tree.query(to: 2), 7)     // [2, 5]
		XCTAssertEqual(tree.query(to: 3), 10)    // [2, 5, 3]
		XCTAssertEqual(tree.query(to: 4), 11)    // [2, 5, 3, 1]
		XCTAssertEqual(tree.query(to: 5), 21)    // [2, 5, 3, 1, 10]
		XCTAssertEqual(tree.query(to: 6), 23)    // [2, 5, 3, 1, 10, 2]
		XCTAssertEqual(tree.query(to: 7), 27)    // [2, 5, 3, 1, 10, 2, 4]
		XCTAssertEqual(tree.query(to: 8), nil)   // nil
		
		tree.update(6, at: 3) 					 // [2, 5, 6, 1, 10, 2, 4]
		XCTAssertEqual(tree.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(tree.query(to: 1), 2)     // [2]
		XCTAssertEqual(tree.query(to: 2), 7)     // [2, 5]
		XCTAssertEqual(tree.query(to: 3), 13)    // [2, 5, 6]
		XCTAssertEqual(tree.query(to: 4), 14)    // [2, 5, 6, 1]
		XCTAssertEqual(tree.query(to: 5), 24)    // [2, 5, 6, 1, 10]
		XCTAssertEqual(tree.query(to: 6), 26)    // [2, 5, 6, 1, 10, 2]
		XCTAssertEqual(tree.query(to: 7), 30)    // [2, 5, 6, 1, 10, 2, 4]
		XCTAssertEqual(tree.query(to: 8), nil)   // nil
		
		tree.update(-2, at: 1) 					 // [-2, 5, 6, 1, 10, 2, 4]
		XCTAssertEqual(tree.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(tree.query(to: 1), -2)    // [-2]
		XCTAssertEqual(tree.query(to: 2),  3)    // [-2, 5]
		XCTAssertEqual(tree.query(to: 3),  9)    // [-2, 5, 6]
		XCTAssertEqual(tree.query(to: 4), 10)    // [-2, 5, 6, 1]
		XCTAssertEqual(tree.query(to: 5), 20)    // [-2, 5, 6, 1, 10]
		XCTAssertEqual(tree.query(to: 6), 22)    // [-2, 5, 6, 1, 10, 2]
		XCTAssertEqual(tree.query(to: 7), 26)    // [-2, 5, 6, 1, 10, 2, 4]
		XCTAssertEqual(tree.query(to: 8), nil)   // nil
		
		tree.update(6, at: 7) 					 // [-2, 5, 6, 1, 10, 2, 6]
		XCTAssertEqual(tree.query(to: 0), 0)     // Нейтральный элемент
		XCTAssertEqual(tree.query(to: 1), -2)    // [-2]
		XCTAssertEqual(tree.query(to: 2),  3)    // [-2, 5]
		XCTAssertEqual(tree.query(to: 3),  9)    // [-2, 5, 6]
		XCTAssertEqual(tree.query(to: 4), 10)    // [-2, 5, 6, 1]
		XCTAssertEqual(tree.query(to: 5), 20)    // [-2, 5, 6, 1, 10]
		XCTAssertEqual(tree.query(to: 6), 22)    // [-2, 5, 6, 1, 10, 2]
		XCTAssertEqual(tree.query(to: 7), 28)    // [-2, 5, 6, 1, 10, 2, 6]
		XCTAssertEqual(tree.query(to: 8), nil)   // nil
	}

}
