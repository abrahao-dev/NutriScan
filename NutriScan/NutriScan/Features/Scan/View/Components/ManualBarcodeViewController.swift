//
//  BarCodeViewController.swift
//  NutriScan
//
//  Created by Eder Junior Alves Silva on 23/10/25.
//

import Foundation
import UIKit
import SwiftUI

class ManualBarcodeViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Código de barras"
        label.font = .preferredFont(forTextStyle: .headline)
        label.textAlignment = .center
        return label
    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite seu código de barras abaixo:"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .gray
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = .preferredFont(forTextStyle: .title2)
        field.keyboardType = .numberPad // teclado numérico
 
        field.backgroundColor = UIColor(named: "secondaryColor3")
        
        field.layer.cornerRadius = 10
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.gray.withAlphaComponent(0.2).cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 50))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        return field
    }()
    
    private let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Confirmar", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.setTitleColor(.white, for: .normal)
      
        button.backgroundColor = UIColor(named: "primaryColor3")
        
        button.layer.cornerRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(instructionLabel)
        view.addSubview(textField)
        view.addSubview(confirmButton)
        
        confirmButton.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        setupConstraints()
    }
    
    
    @objc func confirmAction() {
        dismissKeyboard() // Dispensa o teclado
        print("Código confirmado: \(textField.text ?? "vazio")")    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupConstraints() {

        let stackView = UIStackView(arrangedSubviews: [instructionLabel, textField])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // Título
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Rótulo + TextField
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            // Botão Confirmar
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

struct ManualBarcodeEntryView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = ManualBarcodeViewController
    
    func makeUIViewController(context: Context) -> ManualBarcodeViewController {
        return ManualBarcodeViewController()
    }
    
    func updateUIViewController(_ uiViewController: ManualBarcodeViewController, context: Context) {
    }
}

struct ManualBarcodeEntryView_Previews: PreviewProvider {
    static var previews: some View {
        ManualBarcodeEntryView()
    }
}


