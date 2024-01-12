//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//


public struct Map<Input,Output>: ChainComponent {
    let transform: (Input) async throws -> Output
    
    public init(_ transform: @escaping (Input) async throws -> Output) {
        self.transform = transform
    }
    
    public init(_ keyPath: KeyPath<Input,Output>) {
        self.transform = { $0[keyPath: keyPath] }
    }
    
    public func invoke(_ input: Input) async throws  -> Output {
        try await transform(input)
    }
}

extension ChainComponent {
    public func map<T>(_ transform: @escaping (Output) async throws -> T) -> Chain<Input,T> {
        self | Map(transform)
    }
    
    public func map<T>(_ keyPath: KeyPath<Output,T>) -> Chain<Input,T> {
        self | Map(keyPath)
    }
}
