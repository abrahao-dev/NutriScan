//
//  DetailsViewController.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/9/25.
//

import UIKit
import SwiftUI

class DetailsViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = DetailsScreen()
    
    
    private var foodInfo: FoodInformation
    private var infoItems: [InfoItem]
    private let store = ProductStore.shared

    init(foodInfo: FoodInformation, infoItem: [InfoItem]? = nil) {
        self.foodInfo = foodInfo
        // Sem itens explícitos, gera a partir dos nutrientes reais da API
        self.infoItems = infoItem ?? foodInfo.makeInfoItems()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configure()
        store.addRecent(foodInfo)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DetailsViewController {
    
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
    }
    
    private func configure() {
        contentView.configure(
            imageURL: foodInfo.imageUrl,
            productTitle: foodInfo.name,
            brand: foodInfo.brand,
            score: foodInfo.score,
            infoItems: infoItems
        )
        
        contentView.onCompareButtonTapped = { [weak self] in
            self?.presentCompareScreen()
        }

        contentView.setFavorite(store.isFavorite(foodInfo))
        contentView.onFavoriteButtonTapped = { [weak self] in
            guard let self else { return }
            let isFavorite = self.store.toggleFavorite(self.foodInfo)
            self.contentView.setFavorite(isFavorite)
        }
    }
    
    private func presentCompareScreen() {
        guard let navigationController = self.navigationController else {
            print("Erro: DetailsViewController não está em um Navigation Controller.")
            return
        }
        
        let compareView = CompareFoodContainerView(productOne: self.foodInfo)
        
        let hostingController = UIHostingController(
            rootView:  compareView
        )
        
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(hostingController, animated: true)
    }
}

struct DetailsViewControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = DetailsViewController
    
    let foodInfo: FoodInformation
    
    func makeUIViewController(context: Context) -> DetailsViewController {
        // InfoItems gerados dinamicamente a partir dos nutrientes do produto
        return DetailsViewController(foodInfo: foodInfo)
    }
    
    func updateUIViewController(_ uiViewController: DetailsViewController, context: Context) {
        
    }
}
