//
//  MFSegmentTree.swift
//  MFStructs
//
//  Created by Михаил Фокин on 17.04.2025.
//
//                                     16
//               8                     16
//       4       8         12          16
//   2   4   6   8   10    12    14    16
// 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
// 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16

// 16 8 16 4 8 13 16 2 4 6  8 10 12 14 16  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
//  0 1  2 3 4  5  6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
// 15 на дерево
// 16 на основные эдементы
// 31 элемен

// N-1 на дерево
// N - основные элементы
// N / 2 - индекс начала оригинального массива

// Если наш элемент накрылся полностью, возвращаем элемент left l r right
// Если нет пересечения, возвращаем нейтральный элемент l r left right | left right l r
// Если есть пересечение запускаем рекурсивную функцию для детей

final class MFSegmentTree<T> {
	
	private var sequence: [T] = []
	private let converter: (T, T) -> T
	private var neutralElement: T
	/// Количество элементов исходного массива
	private let countStartArray: Int
	
	init(array: [T], neutralElement: T, converter: @escaping (T, T) -> T) {
		self.converter = converter
		self.neutralElement = neutralElement
		self.countStartArray = array.count
		let lenght = getLenght(lenght: array.count)
		self.sequence = Array(repeating: neutralElement, count: lenght)
		let i = lenght / 2
		self.sequence.replaceSubrange(i..<i+array.count, with: array)
		fillTree(index: i - 1)
	}
	
	func request(left: Int, right: Int) -> T {
		let l = 0
		let r = self.countStartArray - 1
		return workingRequest(i: 0, l: l, r: r, left: left, right: right)
	}
	
	/// Рекурсивный поиск ответа
	///
	/// - i текущий элемент
	/// - l левая граница рассматриваего узда. У самого верхнего она 0
	/// - r правая граница рассматриваего узда. У самого верхнего она N-1
	/// - left левая граница поискового диапазона
	/// - right правая граница поискового диапазона
	private func workingRequest(i: Int, l: Int, r: Int, left: Int, right: Int) -> T {
		guard i < self.sequence.count, i >= 0 else { return neutralElement }
		if left <= l && r <= right {
			// Полностью накрыли
			return self.sequence[i]
		} else if r < left || right < l {
			// Нет пересечения
			return neutralElement
		} else {
			let nexIndex = i * 2 + 1
			let mid = (l + r) / 2
			let resultLeft = workingRequest( i: nexIndex, 	  l: l, 	  r: mid, 	left: left, right: right)
			let resultRight = workingRequest(i: nexIndex + 1, l: mid + 1, r: r, 	left: left, right: right)
			return self.converter(resultLeft, resultRight)
		}
	}
	
	/// Возвращает количество элементов, необходимое для построения структуры
	/// Количество элементов в массиве 2N - 1, где N = 2^k первое число стемени двойки большее длины.
	private func getLenght(lenght: Int) -> Int {
		if lenght <= 0 { return 0 }
		var i = 1
		while i < lenght {
			i <<= 1
		}
		return 2 * i - 1
	}
	
	/// Заполняем дерево
	private func fillTree(index: Int) {
		var i = index
		while i >= 0 {
			let nextIndex = i * 2 + 1
			self.sequence[i] = converter(self.sequence[nextIndex], self.sequence[nextIndex + 1])
			i -= 1
		}
	}
}
