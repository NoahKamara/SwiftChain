//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//

public struct TupleChain<C0,C1>: ChainComponent
where C0: ChainComponent, C1: ChainComponent, C0.Output == C1.Input
{
    public typealias Input = C0.Input
    public typealias Output = C1.Output
    
    let first: C0
    let next: C1
    
    init(first: C0, next: C1) {
        self.first = first
        self.next = next
    }
    
    public func invoke(_ input: Input) async throws -> Output {
        let transfered = try await first.invoke(input)
        let output = try await next.invoke(transfered)
        return output
    }
}

public func |<L: ChainComponent,R: ChainComponent>(lhs: L, rhs: R) -> Chain<L.Input,R.Output> where L.Output == R.Input {
    Chain {
        TupleChain<L,R>(first: lhs, next: rhs)
    }
}

extension ChainComponent {
    public func then<T>(
        @ChainBuilder _ next: () -> Chain<Output,T>
    ) -> Chain<Input,T> {
        self.then(next())
    }

    
    public func then<T>(
        _ next: Chain<Output,T>
    ) -> Chain<Input,T> {
        self | next
    }
}
