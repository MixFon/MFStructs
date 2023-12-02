//
//  MFHeap.swift
//
//
//  Created by Михаил Фокин on 02.12.2023.
//

import Foundation

public final class MFHeap<T> {
	
	private var items: [T] = []
	
	private let priorityFunction: (T, T) -> Bool

	public init(priorityFunction: @escaping (T, T) -> Bool) {
		self.priorityFunction = priorityFunction
	}

	public var count: Int {
		return items.count
	}

	public func peek() -> T? {
		return items.first
	}

	public func insert(_ item: T) {
		items.append(item)
		siftUp(from: items.count - 1)
	}

	public func extract() -> T? {
		guard !items.isEmpty else { return nil }

		if items.count == 1 {
			return items.removeLast()
		} else {
			let root = items[0]
			items[0] = items.removeLast()
			siftDown(from: 0)
			return root
		}
	}

	private func parentIndex(ofIndex i: Int) -> Int {
		return (i - 1) / 2
	}

	private func leftChildIndex(ofIndex i: Int) -> Int {
		return 2 * i + 1
	}

	private func rightChildIndex(ofIndex i: Int) -> Int {
		return 2 * i + 2
	}

	private func siftUp(from index: Int) {
		var child = index
		var parent = parentIndex(ofIndex: child)

		while child > 0 && priorityFunction(items[child], items[parent]) {
			items.swapAt(child, parent)
			child = parent
			parent = parentIndex(ofIndex: child)
		}
	}

	private func siftDown(from index: Int) {
		let left = leftChildIndex(ofIndex: index)
		let right = rightChildIndex(ofIndex: index)
		var first = index
		if left < items.count && priorityFunction(items[left], items[first]) {
			first = left
		}
		if right < items.count && priorityFunction(items[right], items[first]) {
			first = right
		}
		if first == index { return }
		items.swapAt(index, first)
		siftDown(from: first)
	}
}
