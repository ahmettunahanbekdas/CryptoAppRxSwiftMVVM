//
//  Webservice.swift
//  CryptoApp-MVVM
//
//  Created by Ahmet Tunahan Bekdaş on 11.01.2024.
//

import Foundation


enum CryptoError: Error {
    case serverError
    case parsingError
}

class Webservice {
    func downloadCurrencies(url: URL, completionHandler: @escaping (Result<[Crypto],CryptoError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                completionHandler(.failure(.serverError))
            }
            else if let data = data {
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





















/*
 1- "Webservice" classı içersinde "downloadCurrencies" adında bir adet method yazıyoruz bu methodu istediğimiz yerde kullanabiliriz.
 2- "downloadCurrencies" methodu bize bir adet "@escaping" complation handler döndürücek ki bunun içersinde ya succes olur ise "Crypto" dizi olucak yada Failer olursa "CryptoError" hatası dönücek
 3- @escaping ile kullandık çünkü downloadCurrencies fonksiyonu internetten veri çekerken bir gecikme oluyor, senkron bir şekilde veriyi alamıyoruz cevabı beklememiz gerekiyor. ondan dolayı downloadCurrencies url e gidip veriyi çekip getirmesini beklemek için @escaping etiketini kullanıyoruz. Kısaca anlatıcak olursam @escaping kullanıyoruz ve foksiyon çalıştıktan sonra döndürülücek verileri alıyoruz burada
 4- "URLSession.shared.dataTask(with: url) { data, response, error in" işlemi ile api çağrısında bulunuyoruz
*/






