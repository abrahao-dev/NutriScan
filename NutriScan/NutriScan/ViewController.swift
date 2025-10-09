//
//  ViewController.swift
//  NutriScan
//
//  Created by Elena Diniz on 9/24/25.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let swiftUIView: some View = RootView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Home"
        setupSwiftUITabBarController()
        
    }

    func setupSwiftUITabBarController() {
        let vc = UIHostingController(rootView: swiftUIView)
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        
        let swiftUiView = vc.view!
        swiftUiView.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = swiftUiView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = swiftUiView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = swiftUiView.widthAnchor.constraint(equalTo: view.widthAnchor)
        let heightConstraint = swiftUiView.heightAnchor.constraint(equalTo: view.heightAnchor)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }

}
