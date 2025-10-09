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
        .init(name: "Banana Maça", brand: "Não descrito", imageUrl: URL(string: "https://placehold.co/60")!, score: .scoreA)
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            FavoriteTableViewCell.self,
            forCellReuseIdentifier: FavoriteTableViewCell.reuseIdentifier
        )
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favoritos"
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
        print("Célula selecionada na linha \(indexPath.row)")
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
