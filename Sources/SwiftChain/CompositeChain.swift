//
//  File 2.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//

import Foundation

public protocol CompositeChain<Input,Output>: ChainComponent {
    associatedtype Input
    associatedtype Output
    typealias Body = Chain<Input,Output>
    
    @ChainBuilder
    var body: Body { get }
}

public extension CompositeChain {
    func invoke(_ input: Input) async throws -> Output {
        try await body.invoke(input)
    }
}


