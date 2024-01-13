//
//  ViewController.swift
//  CryptoApp-MVVM
//
//  Created by Ahmet Tunahan Bekdaş on 10.01.2024.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - @IBOutlet and Variables
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    var cryptoList = [Crypto]()
    let cryptoViewModel = CryptoViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        setupBinding()
        cryptoViewModel.requestData()
    }
    
    // MARK: - setupBinding()
    private func setupBinding() {
        cryptoViewModel
            .loading
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { animator in
                if animator == true {
                    self.indicatorView.startAnimating()
                }else {
                    self.indicatorView.stopAnimating()
                }
            }.disposed(by: disposeBag)
        
        cryptoViewModel
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { errorString in
                print(errorString)
            }.disposed(by: disposeBag)
        
        cryptoViewModel
            .crypto
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }.disposed(by: disposeBag)
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

