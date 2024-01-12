//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//

import Foundation


public struct Log<T>: ChainComponent {
    public var description: String { "Log<\(T.self)>" }
    
    let loggingFn: (T) -> Void
    
    public init(of type: T.Type = T.self, _ loggingFn: @escaping (T) -> Void = { print($0) }) {
        self.loggingFn = loggingFn
    }
    
    public func invoke(_ input: T) async throws -> T {
        loggingFn(input)
        return input
    }
}

public extension ChainComponent {
    @ChainBuilder
    func log(_ loggingFn: ((Output) -> Void)? = nil) -> Chain<Input,Output> {
        self | Log<Output>(loggingFn ?? { print("Output from \(Self.self): \($0)") })
    }
}
