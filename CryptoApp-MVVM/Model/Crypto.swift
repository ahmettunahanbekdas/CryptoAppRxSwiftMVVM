//
//  Crypto.swift
//  CryptoApp-MVVM
//
//  Created by Ahmet Tunahan Bekdaş on 11.01.2024.
//

import Foundation

struct Crypto: Codable {
    let currency: String
    let price: String
}

enum CryptoError: Error {
    case serverError
    case parsingError
}
