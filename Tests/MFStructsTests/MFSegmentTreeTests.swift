//
//  MFSegmentTreeTests.swift
//  MFStructs
//
//  Created by Михаил Фокин on 17.04.2025.
//

import XCTest
@testable import MFStructs

final class MFSegmentTreeTests: XCTestCase {

	func testFindMin() {
		// Arrange
		let three = MFSegmentTree(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutralElement: Int.max,
			converter: min
		)

		// Act
		
		// Assert
		XCTAssertEqual(three.request(left: 0, right: 0), 2)
		XCTAssertEqual(three.request(left: 0, right: 1), 2)
		XCTAssertEqual(three.request(left: 0, right: 2), 2)
		XCTAssertEqual(three.request(left: 0, right: 3), 1)
		XCTAssertEqual(three.request(left: 0, right: 4), 1)
		XCTAssertEqual(three.request(left: 0, right: 5), 1)
		XCTAssertEqual(three.request(left: 0, right: 6), 1)
		XCTAssertEqual(three.request(left: 0, right: 7), 1)
		
		XCTAssertEqual(three.request(left: 1, right: 1), 5)
		XCTAssertEqual(three.request(left: 1, right: 2), 3)
		XCTAssertEqual(three.request(left: 1, right: 3), 1)
		XCTAssertEqual(three.request(left: 1, right: 4), 1)
		XCTAssertEqual(three.request(left: 1, right: 5), 1)
		XCTAssertEqual(three.request(left: 1, right: 6), 1)
		XCTAssertEqual(three.request(left: 1, right: 7), 1)
		
		XCTAssertEqual(three.request(left: 2, right: 2), 3)
		XCTAssertEqual(three.request(left: 2, right: 3), 1)
		XCTAssertEqual(three.request(left: 2, right: 4), 1)
		XCTAssertEqual(three.request(left: 2, right: 5), 1)
		XCTAssertEqual(three.request(left: 2, right: 6), 1)
		XCTAssertEqual(three.request(left: 2, right: 7), 1)
		
		XCTAssertEqual(three.request(left: 3, right: 3), 1)
		XCTAssertEqual(three.request(left: 3, right: 4), 1)
		XCTAssertEqual(three.request(left: 3, right: 5), 1)
		XCTAssertEqual(three.request(left: 3, right: 6), 1)
		XCTAssertEqual(three.request(left: 3, right: 7), 1)
		
		XCTAssertEqual(three.request(left: 4, right: 4), 7)
		XCTAssertEqual(three.request(left: 4, right: 5), 2)
		XCTAssertEqual(three.request(left: 4, right: 6), 2)
		XCTAssertEqual(three.request(left: 4, right: 7), 2)
		
		XCTAssertEqual(three.request(left: 5, right: 5), 2)
		XCTAssertEqual(three.request(left: 5, right: 6), 2)
		XCTAssertEqual(three.request(left: 5, right: 7), 2)
		
		XCTAssertEqual(three.request(left: 6, right: 6), 4)
		
		XCTAssertEqual(three.request(left: 7, right: 7), Int.max)
	}
	
	func testFindMax() {
		// Arrange
		let three = MFSegmentTree(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutralElement: Int.min,
			converter: max
		)

		// Act
		
		// Assert
		XCTAssertEqual(three.request(left: 0, right: 0), 2)
		XCTAssertEqual(three.request(left: 0, right: 1), 5)
		XCTAssertEqual(three.request(left: 0, right: 2), 5)
		XCTAssertEqual(three.request(left: 0, right: 3), 5)
		XCTAssertEqual(three.request(left: 0, right: 4), 7)
		XCTAssertEqual(three.request(left: 0, right: 5), 7)
		XCTAssertEqual(three.request(left: 0, right: 6), 7)
		XCTAssertEqual(three.request(left: 0, right: 7), 7)

		XCTAssertEqual(three.request(left: 1, right: 1), 5)
		XCTAssertEqual(three.request(left: 1, right: 2), 5)
		XCTAssertEqual(three.request(left: 1, right: 3), 5)
		XCTAssertEqual(three.request(left: 1, right: 4), 7)
		XCTAssertEqual(three.request(left: 1, right: 5), 7)
		XCTAssertEqual(three.request(left: 1, right: 6), 7)
		XCTAssertEqual(three.request(left: 1, right: 7), 7)

		XCTAssertEqual(three.request(left: 2, right: 2), 3)
		XCTAssertEqual(three.request(left: 2, right: 3), 3)
		XCTAssertEqual(three.request(left: 2, right: 4), 7)
		XCTAssertEqual(three.request(left: 2, right: 5), 7)
		XCTAssertEqual(three.request(left: 2, right: 6), 7)
		XCTAssertEqual(three.request(left: 2, right: 7), 7)

		XCTAssertEqual(three.request(left: 3, right: 3), 1)
		XCTAssertEqual(three.request(left: 3, right: 4), 7)
		XCTAssertEqual(three.request(left: 3, right: 5), 7)
		XCTAssertEqual(three.request(left: 3, right: 6), 7)
		XCTAssertEqual(three.request(left: 3, right: 7), 7)

		XCTAssertEqual(three.request(left: 4, right: 4), 7)
		XCTAssertEqual(three.request(left: 4, right: 5), 7)
		XCTAssertEqual(three.request(left: 4, right: 6), 7)
		XCTAssertEqual(three.request(left: 4, right: 7), 7)

		XCTAssertEqual(three.request(left: 5, right: 5), 2)
		XCTAssertEqual(three.request(left: 5, right: 6), 4)
		XCTAssertEqual(three.request(left: 5, right: 7), 4)

		XCTAssertEqual(three.request(left: 6, right: 6), 4)

		XCTAssertEqual(three.request(left: 7, right: 7), Int.min)
	}
	private struct Node: Equatable {
		var value: Int
		var count: Int = 1
	}


	
	func testFindCountMax() {
		
		func compare(one: Node, two: Node) -> Node {
			if one.value == two.value {
				return Node(value: one.value, count: one.count + two.count)
			} else if one.value > two.value {
				return one
			} else {
				return two
			}
		}
		
		// Arrange
		let three = MFSegmentTree<Node>(
			// [5, 5, 3, 1, 5, 2, 4]
			array: [Node(value: 5), Node(value: 5), Node(value: 3), Node(value: 1), Node(value: 5), Node(value: 2), Node(value: 4)],
			neutralElement: Node(value:Int.min),
			converter: compare
		)

		// Act
		
		// Assert
		XCTAssertEqual(three.request(left: 0, right: 0), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 0, right: 1), Node(value: 5, count: 2))
		XCTAssertEqual(three.request(left: 0, right: 2), Node(value: 5, count: 2))
		XCTAssertEqual(three.request(left: 0, right: 3), Node(value: 5, count: 2))
		XCTAssertEqual(three.request(left: 0, right: 4), Node(value: 5, count: 3))
		XCTAssertEqual(three.request(left: 0, right: 5), Node(value: 5, count: 3))
		XCTAssertEqual(three.request(left: 0, right: 6), Node(value: 5, count: 3))
		XCTAssertEqual(three.request(left: 0, right: 7), Node(value: 5, count: 3))

		XCTAssertEqual(three.request(left: 1, right: 1), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 1, right: 2), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 1, right: 3), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 1, right: 4), Node(value: 5, count: 2))
		XCTAssertEqual(three.request(left: 1, right: 5), Node(value: 5, count: 2))
		XCTAssertEqual(three.request(left: 1, right: 6), Node(value: 5, count: 2))
		XCTAssertEqual(three.request(left: 1, right: 7), Node(value: 5, count: 2))

		XCTAssertEqual(three.request(left: 2, right: 2), Node(value: 3, count: 1))
		XCTAssertEqual(three.request(left: 2, right: 3), Node(value: 3, count: 1))
		XCTAssertEqual(three.request(left: 2, right: 4), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 2, right: 5), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 2, right: 6), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 2, right: 7), Node(value: 5, count: 1))

		XCTAssertEqual(three.request(left: 3, right: 3), Node(value: 1, count: 1))
		XCTAssertEqual(three.request(left: 3, right: 4), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 3, right: 5), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 3, right: 6), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 3, right: 7), Node(value: 5, count: 1))

		XCTAssertEqual(three.request(left: 4, right: 4), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 4, right: 5), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 4, right: 6), Node(value: 5, count: 1))
		XCTAssertEqual(three.request(left: 4, right: 7), Node(value: 5, count: 1))

		XCTAssertEqual(three.request(left: 5, right: 5), Node(value: 2, count: 1))
		XCTAssertEqual(three.request(left: 5, right: 6), Node(value: 4, count: 1))

		XCTAssertEqual(three.request(left: 6, right: 6), Node(value: 4, count: 1))

	}
	
	func testFindCountMaxNode() {
		func compare(one: Node, two: Node) -> Node {
			if one.value == two.value {
				return Node(value: one.value, count: one.count + two.count)
			} else if one.value >= two.value {
				return one
			} else {
				return two
			}
		}
		// Arrange
		let three = MFSegmentTree<Node>(
			array: [
				Node(value: 18),
				Node(value: 16),
				Node(value: 20),
				Node(value: 2),
				Node(value: 53),
				Node(value: 57),
				Node(value: 39),
				Node(value: 97),
				Node(value: 21),
				Node(value: 59)
			],
			neutralElement: Node(value:Int.min),
			converter: compare
		)
		// 18 16 20  2 53 57 39 97 21 59
		//  0  1  2  3  4  5  6  7  8  9
		
		// 3 10 -> 97 1
		// 1 10 -> 97 1
		// 3 4  -> 20 1
		// 9 10 -> 59 1
		// 8 10 -> 97 1
		// 5 8  -> 97 1
		// 6 7  -> 57 1
		// 5 8  -> 97 1
		// 1 10 -> 97 1
		// 7 9  -> 97 1
		// Act
		
		// Assert
		XCTAssertEqual(three.request(left: 3 - 1, right: 10 - 1), Node(value: 97, count: 1))
		XCTAssertEqual(three.request(left: 1 - 1, right: 10 - 1), Node(value: 97, count: 1))
		XCTAssertEqual(three.request(left: 3 - 1, right:  4 - 1), Node(value: 20, count: 1))
		XCTAssertEqual(three.request(left: 9 - 1, right: 10 - 1), Node(value: 59, count: 1))
		XCTAssertEqual(three.request(left: 8 - 1, right: 10 - 1), Node(value: 97, count: 1))
		XCTAssertEqual(three.request(left: 5 - 1, right:  8 - 1), Node(value: 97, count: 1))
		XCTAssertEqual(three.request(left: 6 - 1, right:  7 - 1), Node(value: 57, count: 1))
		XCTAssertEqual(three.request(left: 5 - 1, right:  8 - 1), Node(value: 97, count: 1))
		XCTAssertEqual(three.request(left: 1 - 1, right: 10 - 1), Node(value: 97, count: 1))
		XCTAssertEqual(three.request(left: 7 - 1, right:  9 - 1), Node(value: 97, count: 1))
	}

	func testUpdate() {
		// Arrange
		let three = MFSegmentTree(
			array: [2, 5, 3, 1, 7, 2, 4],
			neutralElement: Int.min,
			converter: max
		)
		
		three.update(element: 22, index: 6)
		
		XCTAssertEqual(three.request(left: 0, right: 3), 5)
		XCTAssertEqual(three.request(left: 0, right: 6), 22)
		XCTAssertEqual(three.request(left: 5, right: 6), 22)
		XCTAssertEqual(three.request(left: 6, right: 6), 22)
		
		three.update(element: 30, index: 2)
		
		XCTAssertEqual(three.request(left: 0, right: 3), 30)
		XCTAssertEqual(three.request(left: 0, right: 6), 30)
		XCTAssertEqual(three.request(left: 1, right: 3), 30)
		XCTAssertEqual(three.request(left: 1, right: 4), 30)
		XCTAssertEqual(three.request(left: 2, right: 6), 30)
		XCTAssertEqual(three.request(left: 5, right: 6), 22)
		XCTAssertEqual(three.request(left: 6, right: 6), 22)

	}

}
