//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//


@resultBuilder
public enum ChainBuilder {
    public static func buildFinalResult<Input,Output>(_ component: some ChainComponent<Input,Output>) -> Chain<Input,Output> {
        Chain(component)
    }
    
    public static func buildPartialBlock<C: ChainComponent>(first: C) -> C {
        first
    }
    
    public static func buildPartialBlock<C0,C1>(accumulated: C0, next: C1) -> TupleChain<C0,C1>
    where C0: ChainComponent,
          C1: ChainComponent
    {
        TupleChain(first: accumulated, next: next)
    }
}
