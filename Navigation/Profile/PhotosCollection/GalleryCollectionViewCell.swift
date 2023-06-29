//
//  GalleryCollectionViewCell.swift
//  Navigation
//
//  Created by Roman Vakulenko on 15.06.2023.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    private lazy var photoView: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFill
        photo.clipsToBounds = true
        return photo
    }()

    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        prepareForReuse()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) not been implemented")
    }

    //MARK: - setup

    func setupGalleryCell(model: GalleryModel){
        photoView.image = UIImage(named: model.photo)
    }

    override func prepareForReuse() {
        photoView.image = nil
    }

    //MARK: - layout
    private func layout(){
        contentView.addSubview(photoView)

        NSLayoutConstraint.activate([
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
