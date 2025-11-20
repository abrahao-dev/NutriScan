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
    
    init(foodInfo: FoodInformation, infoItem: [InfoItem]) {
        self.foodInfo = foodInfo
        self.infoItems = infoItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    }
    
    private func presentCompareScreen() {
        guard let navigationController = self.navigationController else {
            print("Erro: DetailsViewController não está em um Navigation Controller.")
            return
        }
        
        let compareView = CompareFoodContainerView(productOne: self.foodInfo)
        
        let hostingController = UIHostingController(
            rootView: NavigationView { compareView }
        )
        
        navigationController.setNavigationBarHidden(true, animated: true)
        navigationController.pushViewController(hostingController, animated: true)
    }
}

struct DetailsViewControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = DetailsViewController
    
    let foodInfo: FoodInformation
    
    func makeUIViewController(context: Context) -> DetailsViewController {
        
        return DetailsViewController(
            foodInfo: foodInfo,
            infoItem: [
                .init(icon: .system(name: .heart), foregroundColor: .icon2,  title: "Bom para o coração", subtitle: "Baixo em gordura: 2,80g", backgroundColor: .iconBackground),
                .init(icon: .asset(name: .muscleArm), foregroundColor: nil, title: "Construção de Ossos e Músculos", subtitle: "Alto em proteínas: 14g", backgroundColor: .secondary3),
                .init(icon: .asset(name: .intestine), foregroundColor: nil, title: "Auxilia no funcionamento do intestino", subtitle: "Rico em fibras: 10g", backgroundColor: .secondary1),
                .init(icon: .system(name: .checkmark), foregroundColor: .icon1, title: "Lactose", subtitle: "Zero em lactose", backgroundColor: .primary1)
            ]
        )
    }
    
    func updateUIViewController(_ uiViewController: DetailsViewController, context: Context) {
        
    }
}
