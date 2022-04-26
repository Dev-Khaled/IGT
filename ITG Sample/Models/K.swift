//
//  K.swift
//  Snackat
//
//  Created by Khaled Khaldi on 12/02/2022.
//

import Foundation

struct K {
    static var server: ServerConfig.Type = DevelopmentServer.self
}



// MARK: - Servers

extension K {
    private struct ProductionServer: ServerConfig {
        static let url = ""
    }
    private struct StagingServer: ServerConfig {
        static let url = ""
    }
    private struct DevelopmentServer: ServerConfig {
        static let url = "https://api.github.com"
    }
}

protocol ServerConfig {
    static var url: String { get }
}
