//
//  MFListIterator.swift
//
//
//  Created by Михаил Фокин on 03.12.2023.
//

import Foundation

/// Итератор для структур на основе однонаправленного связного списка
public struct MFListIterator<I>: IteratorProtocol {
	public typealias Element = I
	
	public var head: MFNode<I>?
	
	public mutating func next() -> I? {
		let node = self.head
		self.head = self.head?.next
		return node?.value
	}
}
