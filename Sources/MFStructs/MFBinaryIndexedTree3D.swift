//
//  MFBinaryIndexedTree3D.swift
//  MFStructs
//
//  Created by Михаил Фокин on 27.04.2025.
//

import Foundation

/// Трехмерное дерево Фенвика (или Fenwick Tree, оно же Binary Indexed Tree — BIT) — это структура данных,
/// предназначенная для эффективного хранения и обработки префиксных сумм в трехмерном пространстве.
/// Индексация элементов идет с (1, 1, 1) для удобства вычисления значений на полуинтервале.
final public class MFBinaryIndexedTree3D<T> {
	
	private var tree: [[[T]]]
	private var matrix: [[[T]]]
	private let neutral: T
	private var converter: (T, T) -> T
	private var stabilizer: (T, T) -> T
	
	/// Инициализирует структуру с заданным массивом, нейтральным элементом и функциями преобразования и стабилизации.
	///
	/// - Parameters:
	///   - array: Исходный 3D массив элементов типа `T`, который будет использован для построения структуры.
	///   - neutral: Нейтральный элемент типа `T`.
	///   - converter: Функция для объединения двух элементов.
	///   - stabilizer: Функция для вычисления "разницы" между элементами.
	public init(matrix: [[[T]]], neutral: T, converter: @escaping (T, T) -> T, stabilizer: @escaping (T, T) -> T) {
		let size = matrix.count
		self.tree = Array(
			repeating: Array(
				repeating: Array(repeating: neutral, count: size + 1),
				count: size + 1
			),
			count: size + 1
		)
		self.matrix = Array(
			repeating: Array(
				repeating: Array(repeating: neutral, count: size + 1),
				count: size + 1
			),
			count: size + 1
		)
		self.neutral = neutral
		self.converter = converter
		self.stabilizer = stabilizer
		
		for i in 0..<size {
			for j in 0..<size {
				for k in 0..<size {
					self.update(matrix[i][j][k], x: i + 1, y: j + 1, z: k + 1)
				}
			}
		}
	}
	
	/// Инициализирует пустую структуру заданного размера.
	///
	/// - Parameters:
	///   - count: Размер стороны куба.
	///   - neutral: Нейтральный элемент типа `T`.
	///   - converter: Функция объединения элементов.
	///   - stabilizer: Функция стабилизации значений.
	public init(count: Int, neutral: T, converter: @escaping (T, T) -> T, stabilizer: @escaping (T, T) -> T) {
		self.tree = Array(
			repeating: Array(
				repeating: Array(repeating: neutral, count: count + 1),
				count: count + 1
			),
			count: count + 1
		)
		self.matrix = Array(
			repeating: Array(
				repeating: Array(repeating: neutral, count: count + 1),
				count: count + 1
			),
			count: count + 1
		)
		self.neutral = neutral
		self.converter = converter
		self.stabilizer = stabilizer
	}
	
	/// Обновляет значение элемента в массиве по заданным индексам и корректирует структуру.
	///
	/// - Parameters:
	///   - value: Новое значение элемента типа `T`.
	///   - x: Координата x.
	///   - y: Координата y.
	///   - z: Координата z.
	public func update(_ value: T, x: Int, y: Int, z: Int) {
		guard x > 0, x < matrix.count, y > 0, y < matrix.count, z > 0, z < matrix.count else { return }
		let delta = self.stabilizer(value, self.matrix[x][y][z])
		self.matrix[x][y][z] = value
		self.siftUp(delta, x: x, y: y, z: z)
	}
	
	/// Выполняет запрос результата на префиксе [1, 1, 1] до (x, y, z) включительно.
	///
	/// - Parameters:
	///   - x: Координата x.
	///   - y: Координата y.
	///   - z: Координата z.
	/// - Returns: Результат агрегации или `nil`, если индексы вне допустимых границ.
	public func query(x: Int, y: Int, z: Int) -> T? {
		guard x >= 0, x < tree.count, y >= 0, y < tree.count, z >= 0, z < tree.count else { return nil }
		var result = neutral
		var i = x
		while i > 0 {
			var j = y
			while j > 0 {
				var k = z
				while k > 0 {
					result = converter(result, tree[i][j][k])
					k -= k & (-k)
				}
				j -= j & (-j)
			}
			i -= i & (-i)
		}
		return result
	}
	
	/// Метод просеивания 3D дерева вверх.
	private func siftUp(_ value: T, x: Int, y: Int, z: Int) {
		var i = x
		while i < tree.count {
			var j = y
			while j < tree.count {
				var k = z
				while k < tree.count {
					tree[i][j][k] = converter(tree[i][j][k], value)
					k += k & (-k)
				}
				j += j & (-j)
			}
			i += i & (-i)
		}
	}
}
