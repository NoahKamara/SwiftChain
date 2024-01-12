//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//

public protocol ChainComponent<Input,Output> {
    associatedtype Input
    associatedtype Output
    
    func invoke(_ input: Input) async throws -> Output
}

public protocol ChainModifier<Input,Output> {
    associatedtype Input
    associatedtype Output
    associatedtype Content: ChainComponent
    
    typealias Body = Chain<Input,Output>
    
    @ChainBuilder
    func body(_ content: Content) -> Body
}

import SwiftUI

public struct ModifiedChain<Content: ChainComponent, Modifier: ChainModifier>: ChainComponent where Content == Modifier.Content {
    let content: Content
    let modifier: Modifier
    
    init(content: Content, modifier: Modifier) {
        self.content = content
        self.modifier = modifier
    }
    
    public func invoke(_ input: Modifier.Input) async throws -> Modifier.Output {
        try await modifier.body(content).invoke(input)
    }
}

extension ModifiedChain {
    
}

public extension ChainComponent {
    func modifer<Modifier>(_ modifier: Modifier) -> ModifiedChain<Self,Modifier> where Modifier: ChainModifier {
        ModifiedChain(content: self, modifier: modifier)
    }
}



