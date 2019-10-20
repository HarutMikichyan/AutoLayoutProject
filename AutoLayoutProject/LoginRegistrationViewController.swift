//
//  LoginRegistrationViewController.swift
//  AutoLayoutProject
//
//  Created by Harut Mikichyan on 10/17/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class LoginRegistrationViewController: UIViewController {
    
    private var iPhadConstraints = [NSLayoutConstraint]()
    private var iPhoneConstraints = [NSLayoutConstraint]()
    
    private let loginButton: UIButton = {
        let loginButton = UIButton(type: .custom)
        loginButton.isUserInteractionEnabled = true
        loginButton.backgroundColor = .blue
        loginButton.setTitle("Log in", for: .normal)
        loginButton.addTarget(self, action: #selector(pushProfileButtonTapped), for: .touchUpInside)
        return loginButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.view.addSubview(loginButton)
        loginButtonAddAutoLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular, .regular):
            NSLayoutConstraint.deactivate(iPhoneConstraints)
            NSLayoutConstraint.activate(iPhadConstraints)
        default:
            NSLayoutConstraint.deactivate(iPhadConstraints)
            NSLayoutConstraint.activate(iPhoneConstraints)
        }
        loginButton.layer.cornerRadius = loginButton.bounds.height/4
        loginButton.clipsToBounds = true
    }
    
    //MARK: - Push Profile
    @objc func pushProfileButtonTapped() {
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Private Interface
    private func loginButtonAddAutoLayout() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false

        iPhoneConstraints.append(loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        iPhoneConstraints.append(loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        iPhoneConstraints.append(loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2))
        //Horizontal Size Class Regular && Vertical Size Class Regular
        iPhadConstraints.append(loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        iPhadConstraints.append(loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        iPhadConstraints.append(loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4))
        iPhadConstraints.append(loginButton.heightAnchor.constraint(equalToConstant: 40))
    }
}
