//
//  FavoriteViewController.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/7/25.
//

import UIKit
import SwiftUI

class FavoriteViewController: UIViewController {
    
    private var informationData: [FoodInformation] = [
        .init(name: "Banana Nanica", brand: "Não descrito", imageUrl: URL(string: "https://placehold.co/60")!, score: .scoreB),
        .init(name: "Banana Maça", brand: "Não descrito", imageUrl: URL(string: "https://placehold.co/60")!, score: .scoreA),
        .init(name: "Leite Integral", brand: "Parmalat", imageUrl: URL(string: "https://placehold.co/60")!, score: .scoreC),
        .init(name: "Leite Condensado Integral", brand: "Italac", imageUrl: URL(string: "https://placehold.co/60")!, score: .scoreD),
        .init(name: "Biscoite Recheado", brand: "Trakinas", imageUrl: URL(string: "https://placehold.co/60")!, score: .scoreE),
        .init(name: "Bolo reacheado - Ana Maria", brand: "Panco", imageUrl: URL(string: "https://placehold.co/60")!, score: .scoreD)
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(
            FavoriteTableViewCell.self,
            forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier
        )
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.reuseIdentifier, for: indexPath) as? FavoriteTableViewCell else {
            return UITableViewCell()
        }
        
                let item = informationData[indexPath.row]
        
        if #available(iOS 16.0, *) {
            cell.contentConfiguration = UIHostingConfiguration {
                FoodInformationItemView(foodInformation: item)
            }
        }
        return cell
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailsViewController(title: informationData[indexPath.row].name, brand: informationData[indexPath.row].brand, imageURL: informationData[indexPath.row].imageUrl, score: informationData[indexPath.row].score, infoItem: [
            .init(icon: .system(name: "heart.fill"), foregroundColor: .icon2,  title: "Bom para o coração", subtitle: "Baixo em gordura: 2,80g", backgroundColor: .iconBackground),
            .init(icon: .asset(name: "Muscle Arm Icon"), foregroundColor: nil, title: "Construção de Ossos e Músculos", subtitle: "Alto em proteínas: 14g", backgroundColor: .secondary3),
            .init(icon: .asset(name: "Intestine Icon"), foregroundColor: nil, title: "Auxilia no funcionamento do intestino", subtitle: "Rico em fibras: 10g", backgroundColor: .secondary1),
            .init(icon: .system(name: "checkmark"), foregroundColor: .icon1, title: "Lactose", subtitle: "Zero em lactose", backgroundColor: .primary1)
        ])
        present(detailVC, animated: true)
    }
}

struct FavoriteViewControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = FavoriteViewController

    func makeUIViewController(context: Context) -> FavoriteViewController {
        return FavoriteViewController()
    }

    func updateUIViewController(_ uiViewController: FavoriteViewController, context: Context) {
        
    }
}
