//
//  ProfileViewController.swift
//  AutoLayoutProject
//
//  Created by Harut Mikichyan on 10/17/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Private Properties
    private var compactConstraints = [NSLayoutConstraint]()
    private var regularConstraints = [NSLayoutConstraint]()
    private var iPhadConstraints = [NSLayoutConstraint]()
    
    private let profileImage: UIImageView = {
        let image = UIImage(named: "ProfileImage")
        let profileImage = UIImageView(image: image)
        profileImage.contentMode = .scaleAspectFit
        return profileImage
    }()
    
    private let signOutButton: UIButton = {
        let signOutButton = UIButton(type: .custom)
        signOutButton.isUserInteractionEnabled = true
        signOutButton.backgroundColor = .blue
        signOutButton.setTitle("Sign Out", for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        return signOutButton
    }()
    
    private let userName: UILabel = {
        let userName = UILabel()
        userName.font = userName.font.withSize(36)
        userName.textAlignment = NSTextAlignment.center
        userName.text = "Harut Mikichyan"
        return userName
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(profileImage)
        view.addSubview(signOutButton)
        view.addSubview(userName)
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImagesCell.self, forCellWithReuseIdentifier: ImagesCell.id)
        
        signOutButtonAddAutoLayout()
        userNameAddAutoLayout()
        collectionViewAddAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController!.setNavigationBarHidden(true, animated: false)
        navigationController!.viewControllers = [self]
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageAddAutoLayout()
        activateConstraints()
    }
    
    @objc func signOutButtonTapped() {
        let vc = LoginRegistrationViewController()
        navigationController!.viewControllers = [vc, self]
        navigationController!.popToViewController(vc, animated: true)
    }
    
    //MARK: - Private Interface
    private func activateConstraints() {
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular, .regular):
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.activate(iPhadConstraints)
        case (.compact, .regular):
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.deactivate(iPhadConstraints)
            NSLayoutConstraint.activate(compactConstraints)
        case (.regular, .compact), (.compact, .compact):
            NSLayoutConstraint.deactivate(compactConstraints)
            NSLayoutConstraint.deactivate(iPhadConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        default:
            break
        }
    }
    
    private func profileImageAddAutoLayout() {
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.layer.masksToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        //Horizontal Size Class Compact && Vertical Size Class Regular
        compactConstraints.append(profileImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4))
        compactConstraints.append(profileImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4))
        compactConstraints.append(profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40))
        compactConstraints.append(profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        //Horizontal Size Class Regular && Vertical Size Class Compact
        regularConstraints.append(profileImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4))
        regularConstraints.append(profileImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4))
        regularConstraints.append(profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40))
        regularConstraints.append(profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140))
        //Horizontal Size Class Regular && Vertical Size Class Regular
        iPhadConstraints.append(profileImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/6))
        iPhadConstraints.append(profileImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/6))
        iPhadConstraints.append(profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40))
        iPhadConstraints.append(profileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120))
    }
    
    private func signOutButtonAddAutoLayout() {
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        signOutButton.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 12).isActive = true
        signOutButton.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        signOutButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func userNameAddAutoLayout() {
        userName.translatesAutoresizingMaskIntoConstraints = false
        //Horizontal Size Class Compact && Vertical Size Class Regular
        compactConstraints.append(userName.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 12))
        compactConstraints.append(userName.centerXAnchor.constraint(equalTo: signOutButton.centerXAnchor))
        //Horizontal Size Class Regular && Vertical Size Class Compact
        regularConstraints.append(userName.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 40))
        regularConstraints.append(userName.centerXAnchor.constraint(equalTo: signOutButton.centerXAnchor))
        //Horizontal Size Class Regular && Vertical Size Class Regular
        iPhadConstraints.append(userName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 40))
        iPhadConstraints.append(userName.topAnchor.constraint(equalTo: profileImage.centerYAnchor))
    }
    
    private func collectionViewAddAutoLayout() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        //Horizontal Size Class Compact && Vertical Size Class Regular
        compactConstraints.append(collectionView.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 40))
        compactConstraints.append(collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        compactConstraints.append(collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        compactConstraints.append(collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        //Horizontal Size Class Regular && Vertical Size Class Compact
        regularConstraints.append(collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40))
        regularConstraints.append(collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40))
        regularConstraints.append(collectionView.leadingAnchor.constraint(equalTo: userName.trailingAnchor))
        regularConstraints.append(collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        //Horizontal Size Class Regular && Vertical Size Class Regular
        iPhadConstraints.append(collectionView.topAnchor.constraint(equalTo: signOutButton.bottomAnchor, constant: 40))
        iPhadConstraints.append(collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        iPhadConstraints.append(collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        iPhadConstraints.append(collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch (traitCollection.horizontalSizeClass, traitCollection.verticalSizeClass) {
        case (.regular, .regular):
            return CGSize(width: (view.bounds.width/3) - 16, height: 400)
        default:
            return CGSize(width: (collectionView.bounds.width/3) - 16, height: 160)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCell.id, for: indexPath) as! ImagesCell
        cell.imageView.image = indexPath.row % 2 == 0 ? UIImage(named: "UK") : UIImage(named: "Car")
        return cell
    }
}
