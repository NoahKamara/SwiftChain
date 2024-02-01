//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//

/// A Component in a ``SwiftChain/Chain``
/// It this provides a method ``SwiftChain/ChainComponent/invoke(_:)`` that takes an input and provides an output
public protocol ChainComponent<Input,Output> {
    associatedtype Input
    associatedtype Output
    
    /// Invoke this component
    /// - Parameter input: ``Input`` this component takes
    /// - Returns: ``Output`` for this component
    func invoke(_ input: Input) async throws -> Output
}


/// Modifies a Chain wrapping it's in- and output
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



