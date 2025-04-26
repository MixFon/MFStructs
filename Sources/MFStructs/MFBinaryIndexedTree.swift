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
	private var array: [T]
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
	public init(array: [T], neutral: T, converter: @escaping (T, T) -> T, stabilizer: @escaping (T, T) -> T) {
		self.tree = Array(repeating: neutral, count: array.count + 1)
		self.array = [neutral] + array
		self.neutral = neutral
		self.converter = converter
		self.stabilizer = stabilizer
		for (index, value) in array.enumerated() {
			self.siftUp(value, at: index + 1)
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
		self.tree = Array(repeating: neutral, count: count + 1)
		self.array = Array(repeating: neutral, count: count + 1)
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
	public func update(_ value: T, at index: Int) {
		guard index > 0, index < self.array.count else { return }
		let delta = self.stabilizer(value, self.array[index])
		self.array[index] = value
		self.siftUp(delta, at: index)
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
	public func query(to index: Int) -> T? {
		guard index >= 0, index < self.tree.count else { return nil }
		var query = self.neutral
		var iterator = index
		while iterator > 0 {
			query = self.converter(self.tree[iterator], query)
			iterator -= iterator & (-iterator)
		}
		return query
	}
	
	/// Метод просеивания дерева вверх, обновляем в дереве все элементы, которые выше. Индексация с начинается с 1
	private func siftUp(_ value: T, at index: Int) {
		guard index > 0 else { return }
		var iterator = index
		while iterator < self.tree.count {
			self.tree[iterator] = self.converter(self.tree[iterator], value)
			iterator += iterator & (-iterator)
		}
	}
	
}
