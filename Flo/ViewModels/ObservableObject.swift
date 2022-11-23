//
//  ObservableObject.swift
//  Flo
//
//  Created by 이상준 on 2022/11/22.
//

import Foundation

final class ObservableObject<T> {
    var value: T {
        // 값이 변경 될때마다 동작
        didSet {
            litener?(value)
        }
    }
    
    private var litener: ((T) -> Void)?
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping(T?) -> Void) {
        self.litener = listener
        listener(value)
    }
}
