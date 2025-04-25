//
//  MFBinaryIndexedTree.swift
//  MFStructs
//
//  Created by Михаил Фокин on 25.04.2025.
//

import Foundation
/// Дерево Фенвика (или Fenwick Tree, оно же Binary Indexed Tree — BIT) — это структура данных,
/// предназначенная для эффективного хранения и обработки префиксных сумм.
/// Индексания элементов идет с 1 чтобы удобно было вычисля значение на полуинтервале
final public class MFBinaryIndexedTree<T> {
	
	private var tree: [T]
	private var converter: (T, T) -> T
	private let neutralElement: T
	
	public init(array: [T], neutralElement: T, converter: @escaping (T, T) -> T) {
		self.tree = Array(repeating: neutralElement, count: array.count + 1)
		self.converter = converter
		self.neutralElement = neutralElement
		for (index, value) in array.enumerated() {
			self.update(value, at: index + 1)
		}
	}
	
	/// Метод обновления суммы элементов по индексу. Индексация с начинается с 1
	public func update(_ value: T, at index: Int) {
		guard index > 0 else { return }
		var iterator = index
		while iterator < self.tree.count {
			self.tree[iterator] = self.converter(self.tree[iterator], value)
			iterator += iterator & (-iterator)
		}
	}
	
	/// Получение результата на префиксе длиной.
	public func query(to index: Int) -> T? {
		guard index >= 0, index < self.tree.count else { return nil }
		var query = self.neutralElement
		var iterator = index
		while iterator > 0 {
			query = self.converter(self.tree[iterator], query)
			iterator -= iterator & (-iterator)
		}
		return query
	}
	
	
}
