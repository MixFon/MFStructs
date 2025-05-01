//
//  MFDoublyNode.swift
//  MFStructs
//
//  Created by Михаил Фокин on 01.05.2025.
//

import Foundation

/// Узел двусвящного списка.
public class MFDoublyNode<N> {
	let value: N
	var next: MFDoublyNode<N>?
	var prev: MFDoublyNode<N>?
	
	init(value: N) {
		self.value = value
	}
}
