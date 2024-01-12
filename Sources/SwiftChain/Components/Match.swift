//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//

import Foundation

public struct Match<RegexOutput>: ChainComponent {
    public var description: String { "Match<\(Output.self)>(\(regex))" }
    
    public typealias Input = String
    public typealias Output = Regex<RegexOutput>.Match?
    
    let regex: Regex<RegexOutput>
    
    public init(matching regex: Regex<RegexOutput>) {
        self.regex = regex
    }
    
    public init<R>(matching component: R) where R: RegexComponent, R.RegexOutput == RegexOutput {
        self.init(matching: component.regex)
    }
    
    public func invoke(_ input: Input) async throws -> Output {
        let match = try regex.firstMatch(in: input)
        return match
    }
}
