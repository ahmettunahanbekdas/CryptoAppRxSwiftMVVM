//
//  Webservice.swift
//  CryptoApp-MVVM
//
//  Created by Ahmet Tunahan Bekdaş on 11.01.2024.
//

import Foundation

class Webservice {
    
    // MARK: - downloadCurrencies()
    func downloadCurrencies(url: URL, completionHandler: @escaping (Result<[Crypto],CryptoError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data1, response, error in
            if error != nil {
                completionHandler(.failure(.serverError))
            }
            else if let data = data1 {
                do{
                    let cryptoList = try JSONDecoder().decode([Crypto].self, from: data)
                    completionHandler(.success(cryptoList))
                }catch {
                    completionHandler(.failure(.parsingError))
                }
            }
        }.resume()
    }
}
