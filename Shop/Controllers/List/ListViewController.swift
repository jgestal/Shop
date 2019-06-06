//
//  ViewController.swift
//  Shop
//
//  Created by Juan Gestal Romani on 01/06/2019.
//  Copyright © 2019 Juan Gestal Romani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BBBadgeBarButtonItem
import SVProgressHUD

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var basketBadgeButton : BBBadgeBarButtonItem?
    
    let bag = DisposeBag()
    
    var viewModel: ListViewModel? {
        didSet {
            bindUI()
        }
    }
    
    func bindUI() {
       bindBasketBadgeButton()
       bindTableView()
       bindTableViewTapHandling()
       bindComponents()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ListViewModel()
        setupUI()
    }
    
    func setupUI() {
        setupBadgeButton()
        setupTableView()
    }
    
    func setupBadgeButton() {
        let basketButtonImg = UIImage.init(named: "BasketBarButtonItemIcon")
        let basketButton = UIButton()
        basketButton.setImage(basketButtonImg, for: .normal)
        basketButton.addTarget(self, action: #selector(basketButtonTapped), for: .touchUpInside)
        basketBadgeButton = BBBadgeBarButtonItem.init(customUIButton: basketButton)
        basketBadgeButton?.badgeBGColor = Theme.red
        basketBadgeButton?.accessibilityIdentifier = AccesibilityIdentifier.listViewController_BasketButton
        self.navigationItem.setRightBarButton(basketBadgeButton, animated: true)
    }
    
    func setupTableView() {
        tableView.register(ProductCell.nib, forCellReuseIdentifier: ProductCell.identifier)
    }
    
    @objc func basketButtonTapped() {
        viewModel?.basketButtonTapped()
    }
}

//MARK: RX Bindings

extension ListViewController {

    // Product Bindings
    fileprivate func bindComponents() {
        Product.products
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { [weak self] products in
            self?.tableView.isHidden = products.count == 0
            self?.basketBadgeButton?.isEnabled = products.count > 0
        }).disposed(by: bag)
        
        viewModel?.networkStatus.observeOn(MainScheduler.instance) .subscribe(onNext: { [weak self] status in
            switch status {
            case .completed:
                SVProgressHUD.dismiss()
            case .error:
                SVProgressHUD.showError(withStatus: "Error fetching the products")
            case .fetching:
                SVProgressHUD.show(withStatus: "Fetching products from API")
            }
        }).disposed(by: bag)
    }
    
    // Basket Bindings
    fileprivate func bindBasketBadgeButton() {
        self.viewModel?.numberOfProductsInBasket
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] numberOfProducts in
                self?.basketBadgeButton?.badgeValue = String(numberOfProducts)
            }).disposed(by: bag)
    }
    
    // RxCocoa Bindings
    fileprivate func bindTableView() {
        Product.products.bind(to: tableView
            .rx
            .items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)) { row, product, cell in
                cell.viewModel = ProductCellViewModel(product: product)
            }.disposed(by: bag)
    }
    
    fileprivate func bindTableViewTapHandling() {
        tableView.rx
            .modelSelected(Product.self)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] product in
                if let indexPath = self?.tableView.indexPathForSelectedRow {
                    self?.viewModel?.cellTapped(at: indexPath)
                    self?.tableView.deselectRow(at: indexPath, animated: true)
                }
            }).disposed(by: bag)
    }
}

