//
//  File.swift
//  
//
//  Created by Noah Kamara on 31.12.23.
//

import Foundation


public struct Decode<D, T: Decodable> {
    public var decoder: JSONDecoder
    
    private init(
        decoder: JSONDecoder? = nil
    ) {
        self.decoder = decoder ?? JSONDecoder()
    }
    
    public func invoke(_ data: Data) async throws -> T {
        let object = try decoder.decode(T.self, from: data)
        return object
    }
}

extension Decode: ChainComponent where D == Data {
    public init(
        as type: T.Type = T.self,
        decoder: JSONDecoder? = nil
    ) {
        self.init(decoder: decoder)
    }
    
    public func invoke(_ data: Data) async throws -> T {
        let object = try decoder.decode(T.self, from: data)
        return object
    }
}

public struct Encode<T: Encodable>: ChainComponent {
    public var encoder: JSONEncoder
    
    public init(
        as type: T.Type = T.self,
        encoder: JSONEncoder? = nil
    ) {
        self.encoder = encoder ?? JSONEncoder()
    }
    
    public var description: String { "Decode<\(T.self)>"}
    
    public func invoke(_ object: T) async throws -> Data {
        let data = try encoder.encode(object)
        return data
    }
}
