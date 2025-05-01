//
//  MFNode.swift
//  
//
//  Created by Михаил Фокин on 02.12.2023.
//

import Foundation

public class MFNode<N> {
	let value: N
	var next: MFNode<N>?
	
	init(value: N) {
		self.value = value
	}
}
