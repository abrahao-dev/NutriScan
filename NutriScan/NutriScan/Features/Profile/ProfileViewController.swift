//
//  ProfileViewController.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/16/25.
//

import UIKit
import SwiftUI

class ProfileViewController: UIViewController {
    
    private var informationData: [SettingsMenuItem] = [
        SettingsMenuItem(icon: "person.fill", title: "Editar Perfil"),
        SettingsMenuItem(icon: "heart.fill", title: "Favoritos"),
        SettingsMenuItem(icon: "arrow.right.square.fill", title: "Sair")
    ]
    
    private let contentView = ProfileView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(
            ProfileTableViewCell.self,
            forCellReuseIdentifier: ProfileTableViewCell.reuseIdentifier
        )
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout() {
        [contentView, tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.reuseIdentifier, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        let item = informationData[indexPath.row]
        
        if #available(iOS 16.0, *) {
            cell.contentConfiguration = UIHostingConfiguration {
                SettingsMenuItem(icon: item.icon, title: item.title)
            }
        }
        return cell
    }
}

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            print("Clicou em Editar Perfil")
        case 1:
            let favoriteView: some View = RootView(selectedTab: .favorites)
            let controller = UIHostingController(rootView: favoriteView)
            self.navigationController?.pushViewController(controller, animated: true)
            
        case 2:
            print("Clicou em Sair")
        default:
            break
        }
    }
}

struct ProfileViewControllerWrapper: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ProfileViewController
    
    func makeUIViewController(context: Context) -> ProfileViewController {
        return ProfileViewController()
    }
    
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        
    }
    
}
