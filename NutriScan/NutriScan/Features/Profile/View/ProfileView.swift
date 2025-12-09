//
//  ProfileView.swift
//  NutriScan
//
//  Created by Elena Diniz on 10/16/25.
//

import UIKit
import SwiftUI
import FirebaseAuth

class ProfileView: UIView {

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Katherine")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 80
        imageView.clipsToBounds = true
        return imageView
    }()

    private let changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Alterar foto", for: .normal)
        button.titleLabel?.font = UIFont(name: "Signika", size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        button.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 80)
        button.clipsToBounds = true
        return button
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Signika", size: 24)
        label.textColor = UIColor(.neutralColor1)
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        configureUserData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUserData() {
        guard let currentUser = Auth.auth().currentUser else {
            nameLabel.text = "Usuário"
            return
        }

        // Usa displayName se disponível, caso contrário usa email ou fallback
        if let displayName = currentUser.displayName, !displayName.isEmpty {
            nameLabel.text = displayName
        } else if let email = currentUser.email {
            nameLabel.text = email
        } else {
            nameLabel.text = "Usuário"
        }
    }

    private func setupLayout() {
        [profileImageView, changePhotoButton, nameLabel].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 160),
            profileImageView.heightAnchor.constraint(equalToConstant: 160),

            changePhotoButton.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor, constant: 50),
            changePhotoButton.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 50),
            changePhotoButton.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            changePhotoButton.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor),
            changePhotoButton.widthAnchor.constraint(equalTo: profileImageView.widthAnchor),
            changePhotoButton.heightAnchor.constraint(equalToConstant: 60),

            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }

}
