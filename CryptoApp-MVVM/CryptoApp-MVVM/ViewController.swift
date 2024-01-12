//
//  ViewController.swift
//  CryptoApp-MVVM
//
//  Created by Ahmet Tunahan Bekdaş on 10.01.2024.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var cryptoList = [Crypto]()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
            guard let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json") else{
            print("Fetch Error")
            return
        }
        Webservice().downloadCurrencies(url: url) { result in
            switch result {
            case .success(let cryptos):
                print(cryptos)
                self.cryptoList = cryptos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
    
    
    
    
}

