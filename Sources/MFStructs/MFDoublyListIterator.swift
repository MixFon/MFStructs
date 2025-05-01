//
//  File.swift
//  MFStructs
//
//  Created by Михаил Фокин on 01.05.2025.
//

import Foundation

/// Итератор для структур на основе однонаправленного связного списка
public struct MFDoublyListIterator<I>: IteratorProtocol {
	public typealias Element = I
	
	public var head: MFDoublyNode<I>?
	
	public mutating func next() -> I? {
		let node = self.head
		self.head = self.head?.next
		return node?.value
	}
}
