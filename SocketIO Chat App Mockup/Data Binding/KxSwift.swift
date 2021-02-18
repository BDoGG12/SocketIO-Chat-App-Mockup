//
//  KxSwift.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/9/21.
//

import Foundation

class KxSwift<T> {
    
    typealias Observer = (T) -> ()
    var observer: Observer?
    
    var value: T {
        didSet {
            observer?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(_ listener: Observer?) {
        self.observer = listener
    }
    
    func subscribe(_ observer: Observer?) {
        self.observer = observer
        observer?(value)
    }
    
}
