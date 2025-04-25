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

final public class MFSegmentTree<T> {
	
	private var sequence: [T] = []
	private let converter: (T, T) -> T
	private var neutralElement: T
	/// Длина массива расширенного до 2^k
	private let lenght: Int
	
	public init(array: [T], neutralElement: T, converter: @escaping (T, T) -> T) {
		self.converter = converter
		self.neutralElement = neutralElement
		// Возвращает количество элементов, необходимое для построения структуры
		// Количество элементов в массиве 2N - 1, где N = 2^k первое число стемени двойки большее длины.
		var i = 1
		while i < array.count { i <<= 1 }
		self.lenght = i
		let lenghtSequence = 2 * self.lenght - 1
		self.sequence = Array(repeating: neutralElement, count: lenghtSequence)
		let startIndex = lenghtSequence / 2
		self.sequence.replaceSubrange(startIndex..<startIndex+array.count, with: array)
		fillTree(index: startIndex - 1)
	}
	
	public func update(element: T, index: Int) {
		let indexUpdate = lenght - 1 + index
		guard indexUpdate >= 0, indexUpdate < self.sequence.count else { return }
		// Меняем элемент на по индекму N-1 + index но новый
		self.sequence[indexUpdate] = element
		var indexParent = (indexUpdate - 1) / 2
		while indexParent >= 0 {
			let indexLeftChild = 2 * indexParent + 1
			let indexRightChild = indexLeftChild + 1
			let leftChild = self.sequence[indexLeftChild]
			let rightChild = self.sequence[indexRightChild]
			self.sequence[indexParent] = self.converter(leftChild, rightChild)
			let indexNextParent = (indexParent - 1) / 2
			if indexParent == 0 && indexNextParent == 0 { break }
			indexParent = indexNextParent
		}
	}
	
	public func request(left: Int, right: Int) -> T {
		let l = 0
		let r = self.lenght - 1
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
		if right < l || left > r {
			// Нет пересечения
			return neutralElement
			
		} else if left <= l && r <= right {
			// Полностью накрыли
			return self.sequence[i]
		} else {
			// Рассматриваем потомков
			let nexIndex = i * 2 + 1
			let mid = (l + r) / 2
			let resultRight = workingRequest(i: nexIndex + 1, l: mid + 1, r: r, 	left: left, right: right)
			let resultLeft = workingRequest( i: nexIndex, 	  l: l, 	  r: mid, 	left: left, right: right)
			return self.converter(resultLeft, resultRight)
		}
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
