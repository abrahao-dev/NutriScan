//
//  ProfileViewController.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 22/10/25.
//
import UIKit
import SwiftUI
import FirebaseAuth

class HomeViewController: UIViewController {

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let informativeBanner: InformativeBanner = {
        let banner = InformativeBanner()
        banner.translatesAutoresizingMaskIntoConstraints = false
        return banner
    }()

    private let saveRecentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Salvos Recentemente"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var recentItemsCollectionView: UICollectionView!

    private var recentProducts: [Product] = MockData.recentProducts

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

        setup()
        setupLayout()
        configureUserGreeting()
    }

    private func configureUserGreeting() {
        guard let currentUser = Auth.auth().currentUser else {
            headerLabel.text = "Bem vindo(a),\nUsuário!"
            return
        }

        // Usa displayName se disponível, caso contrário usa email
        if let displayName = currentUser.displayName, !displayName.isEmpty {
            // Pega apenas o primeiro nome
            let firstName = displayName.components(separatedBy: " ").first ?? displayName
            headerLabel.text = "Bem vindo(a),\n\(firstName)!"
        } else if let email = currentUser.email {
            // Pega a parte antes do @ do email
            let username = email.components(separatedBy: "@").first ?? "Usuário"
            headerLabel.text = "Bem vindo(a),\n\(username)!"
        } else {
            headerLabel.text = "Bem vindo(a),\nUsuário!"
        }
    }

    private func setup() {
        view.backgroundColor = .systemBackground
        view.addSubview(headerLabel)
        view.addSubview(informativeBanner)
        view.addSubview(saveRecentLabel)

        view.addSubview(recentItemsCollectionView)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 260)
        layout.minimumLineSpacing = 16

        recentItemsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        recentItemsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        recentItemsCollectionView.backgroundColor = .clear
        recentItemsCollectionView.showsHorizontalScrollIndicator = false

        recentItemsCollectionView.dataSource = self

        recentItemsCollectionView.register(RecentItemCell.self, forCellWithReuseIdentifier: RecentItemCell.reuseIdentifier)
    }

    func setupLayout() {

        NSLayoutConstraint.activate([

            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            informativeBanner.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            informativeBanner.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            informativeBanner.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            informativeBanner.heightAnchor.constraint(equalToConstant: 180),

            saveRecentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            saveRecentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            saveRecentLabel.topAnchor.constraint(equalTo: informativeBanner.bottomAnchor, constant: 20),

            recentItemsCollectionView.topAnchor.constraint(equalTo: saveRecentLabel.bottomAnchor, constant: 20),
            recentItemsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16), // Padding
            recentItemsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            recentItemsCollectionView.heightAnchor.constraint(equalToConstant: 260) // Altura da célula
        ])
    }
}


extension HomeViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecentItemCell.reuseIdentifier,
            for: indexPath
        ) as? RecentItemCell else {
            fatalError("Não foi possível criar a RecentItemCell")
        }

        let product = recentProducts[indexPath.item]

        cell.configure(with: product)

        return cell
    }
}

struct HomeViewControllerWrapper: UIViewControllerRepresentable {

    typealias UIViewControllerType = HomeViewController

    func makeUIViewController(context: Context) -> HomeViewController {
        return HomeViewController()
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {

    }

}
