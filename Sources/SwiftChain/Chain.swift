//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//

public struct Chain<Input,Output>: ChainComponent {
    private let content: any ChainComponent<Input,Output>
    
    public init(_ content: some ChainComponent<Input, Output>) {
        self.content = content
    }
    
    public init(@ChainBuilder content: () -> some ChainComponent<Input, Output>) {
        self.content = content()
    }
    
    public func invoke(_ input: Input) async throws -> Output {
        try await content.invoke(input)
    }
}


