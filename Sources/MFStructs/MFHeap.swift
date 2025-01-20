//
//  MFHeap.swift
//
//
//  Created by Михаил Фокин on 02.12.2023.
//

import Foundation

public class MFHeap<T> {
	
	internal var items: [T] = []

	private let priorityFunction: (T, T) -> Bool

	public init(priorityFunction: @escaping (T, T) -> Bool) {
		self.priorityFunction = priorityFunction
	}

	/// Количество элементов кучи
	public var count: Int {
		self.items.count
	}

	/// Значение на вершине кучи
	public var peek: T? {
		self.items.first
	}

	/// Вставка элемента
	public func insert(_ item: T) {
		self.items.append(item)
		siftUp(from: items.count - 1)
	}

	/// Возвращает верхний элемент кучи
	public func extract() -> T? {
		guard !self.items.isEmpty else { return nil }

		if self.items.count == 1 {
			return self.items.removeLast()
		} else {
			let root = self.items[0]
			self.items[0] = self.items.removeLast()
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

		while child > 0 && priorityFunction(self.items[child], self.items[parent]) {
			self.items.swapAt(child, parent)
			child = parent
			parent = parentIndex(ofIndex: child)
		}
	}

	private func siftDown(from index: Int) {
		let left = leftChildIndex(ofIndex: index)
		let right = rightChildIndex(ofIndex: index)
		var first = index
		if left < self.items.count && priorityFunction(self.items[left], self.items[first]) {
			first = left
		}
		if right < self.items.count && priorityFunction(self.items[right], self.items[first]) {
			first = right
		}
		if first == index { return }
		self.items.swapAt(index, first)
		siftDown(from: first)
	}
}

/// Куча с ограничением. Удалит
public class MFLimitedHeap<T>: MFHeap<T> {
	/// Ограничитель. Задает максимально допустимое количество элементов в куче
	private var limiter: Int?
	
	public init(limiter: Int? = nil, priorityFunction: @escaping (T, T) -> Bool) {
		self.limiter = limiter
		super.init(priorityFunction: priorityFunction)
	}
	
	/// Вставка элемента
	public func insert(_ item: T, complitionRemove: @escaping (T) -> (Void)) {
		self.insert(item)
		if let limiter, self.count > limiter, self.count > 0 {
			complitionRemove(self.items.removeLast())
		}
	}
}
