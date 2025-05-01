//
//  MFQueue.swift
//
//
//  Created by Михаил Фокин on 03.12.2023.
//

import Foundation

public final class MFQueue<T> {
	
	private var head: MFNode<T>?
	private var tail: MFNode<T>?
	private var countNodes: Int = 0

	/// Возвращает элемент стоящий первым в очереди. (Следующий на удаление)
	public var front: T? {
		self.head?.value
	}
	
	/// Возвращает элемент стоящий последним в очереди. (Только что добавленный)
	public var back: T? {
		self.tail?.value
	}
	
	/// Проверка на пустоту
	public var isEmpty: Bool {
		self.head == nil
	}
	
	/// Количество элементов в очереди
	public var count: Int {
		self.countNodes
	}
	
	/// Добавление нового элемента в конец очереди
	public func push(_ element: T) {
		let node = MFNode(value: element)
		if self.head == nil {
			self.head = node
			self.tail = node
		} else {
			self.tail?.next = node
			self.tail = node
		}
		self.countNodes += 1
	}
	
	/// Добавление последовательности новых элементов.
	public func push<Source>(_ sequence: Source) where T == Source.Element, Source : Sequence {
		for element in sequence {
			self.push(element)
		}
	}
	
	/// Удаление элемента стоящим первым на удаление, первым в очереди
	@discardableResult
	public func pop() -> T? {
		let node = self.head
		self.head = self.head?.next
		self.countNodes -= 1
		if countNodes < 0 { countNodes = 0 }
		return node?.value
	}
	
	/// Очистка очереди
	public func remoreAll() {
		self.countNodes = 0
		self.tail = nil
		self.head = nil
	}
}


extension MFQueue: Sequence {
	
	public func makeIterator() -> MFListIterator<T> {
		var iter = self.head
		var head: MFNode<T>? = nil
		var lastNode: MFNode<T>? = nil
		while iter != nil  {
			if let value = iter?.value {
				let node = MFNode(value: value)
				if head == nil {
					head = node
					lastNode = head
				} else {
					lastNode?.next = node
					lastNode = node
				}
			}
			iter = iter?.next
		}
		return MFListIterator(head: head)
	}
}
