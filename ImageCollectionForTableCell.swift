//
//  ImageCollectionForTableCell.swift
//  Navigation
//
//  Created by Roman Vakulenko on 16.06.2023.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    private lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - setup
    func setupImageCollectionCell(model: GalleryModel){
        photoView.image = UIImage(named: model.photo)
    }

    //MARK: - Layout
    private func layout(){
        contentView.addSubview(photoView)

        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
//            photoView.heightAnchor.constraint(equalToConstant: 100),
            photoView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
