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
    
    var router: TabRouter?

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
            let editProfileView: some View = EditProfileView()
            let controller = UIHostingController(rootView: editProfileView)
            self.present(controller, animated: true)
        case 1:
            router?.selectedTab = .favorites
            navigationController?.popToRootViewController(animated: false)
        case 2:
            guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = scene.windows.first else { return }
            let loginView: some View = LoginView()
            let controller = UIHostingController(rootView: loginView)
            window.rootViewController = UINavigationController(rootViewController: controller)
            window.makeKeyAndVisible()
        default:
            break
        }
    }
}

struct ProfileViewControllerWrapper: UIViewControllerRepresentable {
    
    @EnvironmentObject var router: TabRouter
    
    typealias UIViewControllerType = ProfileViewController
    
    func makeUIViewController(context: Context) -> ProfileViewController {
        let controller = ProfileViewController()
        controller.router = router
        return controller
    }
    
    func updateUIViewController(_ uiViewController: ProfileViewController, context: Context) {
        uiViewController.router = router
    }
    
}
