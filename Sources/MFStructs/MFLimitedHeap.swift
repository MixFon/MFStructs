//
//  MFLimitedHeap.swift
//  MFStructs
//
//  Created by Михаил Фокин on 29.01.2025.
//

/// Куча с ограничением. Удалит элемент с минимальным значением
public class MFLimitedHeap<T>: MFHeap<T> {
	/// Ограничитель. Задает максимально допустимое количество элементов в куче
	private var limiter: Int?
	
	public init(limiter: Int? = nil, priorityFunction: @escaping (T, T) -> Bool) {
		self.limiter = limiter
		super.init(priorityFunction: priorityFunction)
	}
	
	/// Вставка элемента
	public func insert(_ item: T, complitionRemove: @escaping (T?) -> (Void)) {
		self.insert(item)
		if let limiter, self.count > limiter, self.count > 0 {
			complitionRemove(removePriorityMinElement())
		}
	}
	
	/// Удаляет элемент с самым низким приоритетом, проводит балансировку
	private func removePriorityMinElement() -> T? {
		var iterator = self.count / 2
		var priorityMinIndex: Int = iterator
		var minElement: T = self.items[iterator]
		while iterator < self.count {
			let element = self.items[iterator]
			if !self.priorityFunction(element, minElement) {
				minElement = element
				priorityMinIndex = iterator
			}
			iterator += 1
		}
		self.items.swapAt(priorityMinIndex, self.count - 1)
		siftUp(from: priorityMinIndex)
		return self.items.removeLast()
	}
}
