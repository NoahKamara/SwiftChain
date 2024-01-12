//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//


public struct AttemptError: Error {
    public var attempts: Int { underlying.count }
    public let underlying: [any Error]
}


public struct Attempt<Input,Output>: ChainComponent {
    public let tries: Int
    public let content: Chain<Input,Output>
    
    public init(tries: Int, @ChainBuilder content: () -> Chain<Input,Output>) {
        self.init(tries: tries, content: content())
    }
    
    public init(tries: Int, content: Chain<Input,Output>) {
        self.tries = tries
        self.content = content
    }
    
    public func invoke(_ input: Input) async throws -> Output {
        var errors = [Error]()
        
        for _ in 0..<tries {
            do {
                return try await content.invoke(input)
            } catch {
                errors.append(error)
                continue
            }
        }
        
        throw AttemptError(underlying: errors)
    }
}
