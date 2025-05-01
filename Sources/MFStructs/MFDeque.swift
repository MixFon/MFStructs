//
//  MFDeque.swift
//  MFStructs
//
//  Created by Михаил Фокин on 01.05.2025.
//

import Foundation

public final class MFDeque<T> {
	
	private var head: MFDoublyNode<T>?
	private var tail: MFDoublyNode<T>?
	private var countNodes: Int = 0

	/// Возвращает элемент стоящий первым в деке.
	public var front: T? {
		self.head?.value
	}
	
	/// Возвращает элемент стоящий последним в деке.
	public var back: T? {
		self.tail?.value
	}
	
	/// Проверка на пустоту
	public var isEmpty: Bool {
		self.head == nil
	}
	
	/// Количество элементов в деке
	public var count: Int {
		self.countNodes
	}
	
	/// Добавление нового элемента вперед. (Самый левый)
	public func pushFront(_ element: T) {
		let node = MFDoublyNode(value: element)
		node.next = self.head
		self.head?.prev = node
		self.head = node
		if self.tail == nil {
			self.tail = node
		}
		self.countNodes += 1
	}
	
	/// Добавление последовательности новых элементов.
	public func pushFront<Source>(_ sequence: Source) where T == Source.Element, Source : Sequence {
		for element in sequence {
			self.pushFront(element)
		}
	}
	
	/// Добавление нового элемента назад. (Самый правый)
	public func pushBack(_ element: T) {
		let node = MFDoublyNode(value: element)
		self.tail?.next = node
		node.prev = self.tail
		self.tail = node
		if self.head == nil {
			self.head = node
		}
		self.countNodes += 1
	}
	
	/// Добавление последовательности новых элементов.
	public func pushBack<Source>(_ sequence: Source) where T == Source.Element, Source : Sequence {
		for element in sequence {
			self.pushBack(element)
		}
	}
	
	/// Удаление элемента стоящим первым. (Самый левый)
	@discardableResult
	public func popFront() -> T? {
		let node = self.head
		self.head = self.head?.next
		self.head?.prev = nil
		node?.next = nil
		node?.prev = nil
		self.countNodes -= 1
		if self.head == nil {
			self.tail = nil
		}
		if self.countNodes < 0 { self.countNodes = 0 }
		return node?.value
	}
	
	/// Удаление элемента стоящим первым. (Самый левый)
	@discardableResult
	public func popBack() -> T? {
		let node = self.tail
		self.tail = self.tail?.prev
		self.tail?.next = nil
		node?.next = nil
		node?.prev = nil
		self.countNodes -= 1
		if self.tail == nil {
			self.head = nil
		}
		if self.countNodes < 0 { self.countNodes = 0 }
		return node?.value
	}
	
	/// Очистка дека
	public func remoreAll() {
		self.countNodes = 0
		self.tail = nil
		self.head = nil
	}
}


extension MFDeque: Sequence {
	
	public func makeIterator() -> MFDoublyListIterator<T> {
		return MFDoublyListIterator(head: self.head)
	}
}
