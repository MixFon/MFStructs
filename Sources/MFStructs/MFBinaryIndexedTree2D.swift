//
//  MFBinaryIndexedTree2D.swift
//  MFStructs
//
//  Created by Михаил Фокин on 26.04.2025.
//

import Foundation
/// Двумерное дерево Фенвика (или Fenwick Tree, оно же Binary Indexed Tree — BIT) — это структура данных,
/// предназначенная для эффективного хранения и обработки префиксных сумм на плоскости.
/// Индексания элементов идет с (1, 1) чтобы удобно было вычисля значение на полуинтервале
final public class MFBinaryIndexedTree2D<T> {
	
	private var tree: [[T]]
	private var matrix: [[T]]
	private let neutral: T
	private var converter: (T, T) -> T
	private var stabilizer: (T, T) -> T
	
	/// Инициализирует структуру с заданным массивом, нейтральным элементом и функциями преобразования и стабилизации.
	///
	/// - Parameters:
	///   - array: Исходный массив элементов типа `T`, который будет использован для построения структуры.
	///   - neutral: Нейтральный элемент типа `T`, который используется для начальной инициализации внутренних данных.
	///   - converter: Функция, принимающая два элемента типа `T` и возвращающая их преобразованное значение.
	///   - stabilizer: Функция, принимающая два элемента типа `T` и возвращающая стабилизированное значение.
	///
	/// Метод создаёт внутреннее хранилище на основе массива, заполняя его нейтральными элементами.
	/// Затем происходит "просеивание вверх" (`siftUp`) каждого элемента массива для корректной настройки структуры.
	///
	/// - Note: Индексация внутреннего массива начинается с 1 (нулевой элемент — нейтральный).
	public init(matrix: [[T]], neutral: T, converter: @escaping (T, T) -> T, stabilizer: @escaping (T, T) -> T) {
		self.tree = Array(repeating: Array(repeating: neutral, count: matrix.count + 1), count: matrix.count + 1)
		self.matrix = [Array(repeating: neutral, count: matrix.count)] + matrix
		var i = 0
		while i <= matrix.count {
			self.matrix[i] = [neutral] + self.matrix[i]
			i += 1
		}
		self.neutral = neutral
		self.converter = converter
		self.stabilizer = stabilizer
		for (i, row) in matrix.enumerated() {
			for (j, value) in row.enumerated() {
				self.siftUp(value, x: i + 1, y: j + 1)
			}
		}
	}
	
	/// Инициализирует структуру с заданным массивом, нейтральным элементом и функциями преобразования и стабилизации.
	///
	/// - Parameters:
	///   - count: Количество элементов в дереве. Массив будет заполнен neutral.
	///   - neutral: Нейтральный элемент типа `T`, который используется для начальной инициализации внутренних данных.
	///   - converter: Функция, принимающая два элемента типа `T` и возвращающая их преобразованное значение.
	///   - stabilizer: Функция, принимающая два элемента типа `T` и возвращающая стабилизированное значение.
	///
	/// Метод создаёт внутреннее хранилище на основе массива, заполняя его нейтральными элементами.
	/// Затем происходит "просеивание вверх" (`siftUp`) каждого элемента массива для корректной настройки структуры.
	///
	/// - Note: Индексация внутреннего массива начинается с 1 (нулевой элемент — нейтральный).
	public init(count: Int, neutral: T, converter: @escaping (T, T) -> T, stabilizer: @escaping (T, T) -> T) {
		self.tree = Array(repeating: Array(repeating: neutral, count: count + 1), count: count + 1)
		self.matrix = Array(repeating: Array(repeating: neutral, count: count + 1), count: count + 1)
		self.neutral = neutral
		self.converter = converter
		self.stabilizer = stabilizer
	}
	
	/// Обновляет значение элемента в массиве по заданному индексу и корректирует структуру.
	///
	/// - Parameters:
	///   - value: Новое значение элемента типа `T`.
	///   - index: Индекс элемента в массиве для обновления (индексация начинается с 1).
	///
	/// Метод сначала вычисляет "разницу" (`delta`) между старым и новым значением с помощью функции `stabilizer`.
	/// Затем обновляет элемент в массиве и выполняет операцию `siftUp`, чтобы корректно перестроить внутреннюю структуру.
	///
	/// - Note: Если индекс выходит за допустимые границы, метод ничего не делает.
	public func update(_ value: T, x: Int, y: Int) {
		guard x > 0, x < self.matrix.count, y > 0, y < self.tree.count else { return }
		let delta = self.stabilizer(value, self.matrix[x][y])
		self.matrix[x][y] = value
		self.siftUp(delta, x: x, y: y)
	}
	
	/// Выполняет запрос результата на префиксе заданной длины.
	///
	/// - Parameters:
	///   - index: Индекс конца префикса (включительно), начиная с 0.
	///   - Returns: Результат агрегации всех элементов от начала до указанного индекса включительно, либо `nil`, если индекс вне допустимых границ.
	///
	/// Метод использует внутреннюю структуру дерева для эффективного вычисления агрегированного результата на отрезке [1, index].
	/// Агрегация производится с помощью функции `converter`.
	///
	/// - Note: Если индекс равен 0, возвращается `neutral`. Индексация для дерева начинается с 1.
	public func query(x: Int, y: Int) -> T? {
		guard x >= 0, x < self.tree.count, y >= 0, y < self.tree.count else { return nil }
		var query = self.neutral
		var i = x
		while i > 0 {
			var j = y
			while j > 0 {
				query = self.converter(self.tree[i][j], query)
				j -= j & (-j)
			}
			i -= i & (-i)
		}
		return query
	}
	
	/// Метод просеивания 2D дерева вверх, обновляем в дереве все элементы, которые выше. Индексация с начинается с 1
	private func siftUp(_ value: T, x: Int, y: Int) {
		guard x > 0, y > 0 else { return }
		var i = x
		while i < self.tree.count {
			var j = y
			while j < self.tree.count {
				self.tree[i][j] = self.converter(self.tree[i][j], value)
				j += j & (-j)
			}
			i += i & (-i)
		}
	}
	
}
