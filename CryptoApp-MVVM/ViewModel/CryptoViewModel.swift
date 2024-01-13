//
//  CryptoViewModel.swift
//  CryptoApp-MVVM
//
//  Created by Ahmet Tunahan Bekdaş on 12.01.2024.
//

import Foundation
import RxSwift
import RxCocoa

class CryptoViewModel {
    
    let crypto: PublishSubject<[Crypto]> = PublishSubject()
    let error: PublishSubject<String> = PublishSubject()
    let loading: PublishSubject<Bool> = PublishSubject()
    
    
    // MARK: requestData()
    func requestData() {
        guard let url = URL(string:"https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else{
            print("Fetch Error")
            return
        }
        Webservice().downloadCurrencies(url: url) { result in
            switch result {
            case .success(let cryptos):
                self.crypto.onNext(cryptos)
            case .failure(let error):
                switch error {
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
}
