//
//  ImagesCell.swift
//  AutoLayoutProject
//
//  Created by Harut Mikichyan on 10/19/19.
//  Copyright © 2019 Harut Mikichyan. All rights reserved.
//

import UIKit

class ImagesCell: UICollectionViewCell {
    static let id = "imagesCellId"

    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewAddAutoLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func imageViewAddAutoLayout() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
}
