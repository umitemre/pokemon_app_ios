//
//  MockDataManager.swift
//  Pokemon AppTests
//
//  Created by Emre Aydin on 6.10.2023.
//

import Foundation

public class MockDataManager {
    static func getData<T>(
        from resource: String,
        type: T.Type
    ) -> T? where T: Decodable & Encodable {
        var model: T?
        
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return nil }
        
        do {
            model = try JSONDecoder().decode(type, from: data)
        } catch {
            assertionFailure()
        }
        
        return model
    }
}
