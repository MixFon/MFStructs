//
//  MFStack.swift
//
//
//  Created by Михаил Фокин on 02.12.2023.
//

import Foundation

public final class MFStack<T> {
	
	private var head: MFNode<T>?
	private var countNodes: Int = 0
	
	/// Возвращает элемент на вершине стека
	public var top: T? {
		self.head?.value
	}
	
	/// Проверка на пустоту
	public var isEmpty: Bool {
		self.head == nil
	}
	
	/// Количество элементов в стеке
	public var count: Int {
		self.countNodes
	}
	
	/// Добавление нового элемента
	public func push(_ element: T) {
		let node = MFNode(value: element)
		node.next = self.head
		self.head = node
		self.countNodes += 1
	}
	
	/// Добавление последовательности новых элементов.
	public func push<Source>(_ sequence: Source) where T == Source.Element, Source : Sequence {
		for element in sequence {
			self.push(element)
		}
	}
	
	/// Удаление элемента с вершины стэка
	@discardableResult
	public func pop() -> T? {
		let node = self.head
		self.head = self.head?.next
		self.countNodes -= 1
		if countNodes < 0 { countNodes = 0 }
		return node?.value
	}
	
	/// Очистка стека
	public func remoreAll() {
		self.countNodes = 0
		self.head = nil
	}
}

extension MFStack: Sequence {
	
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
