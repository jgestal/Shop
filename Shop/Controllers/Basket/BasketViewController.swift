//
//  BasketViewController.swift
//  Shop
//
//  Created by Juan Gestal Romani on 02/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BasketViewController: UIViewController {

    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var billView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var payLabel: UILabel!
    
    @IBOutlet weak var emptyView: UIView!
    
    private let bag = DisposeBag()
    
    var viewModel: BasketViewModel? {
        didSet {
            bindUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BasketViewModel()
        setupUI()
    }
    
    func setupUI() {
        setupTableView()
    }
    
    func setupTableView() {
        tableView.allowsSelection = false
        tableView.register(BasketProductCell.nib, forCellReuseIdentifier: BasketProductCell.identifier)
    }

    @IBAction func proceedButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Order completed", message: "Thank for your order", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.viewModel?.confirmAndPay()
        }))
        self.present(alert, animated: true, completion:nil)
    }
}


//MARK: RX Bindings

extension BasketViewController {
    
    private  func bindUI() {
        bindTableView()
        bindComponents()
    }
    
    fileprivate func bindComponents() {
        viewModel?.basketLines
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] basketLines in
                self?.totalLabel.text = basketLines.price.eur
                self?.discountLabel.text = basketLines.discount.eur
                self?.payLabel.text = basketLines.promotionalPrice.eur
                
                // Hide if no products in basket
                let isEmpty = basketLines.count == 0

                self?.proceedButton.isHidden = isEmpty
                self?.billView.isHidden = isEmpty
                self?.tableView.isHidden = isEmpty
                
                // Show empty basket if there are no products in the basket
                self?.emptyView.isHidden = !isEmpty
                
        }).disposed(by: bag)
    }
    
    fileprivate func bindTableView() {
        viewModel?.basketLines
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView
            .rx
            .items(cellIdentifier: BasketProductCell.identifier, cellType: BasketProductCell.self)) { row, basketLine, cell in
                cell.viewModel = BasketProductCellViewModel(basketLine: basketLine)
            }.disposed(by: bag)
    }
}
