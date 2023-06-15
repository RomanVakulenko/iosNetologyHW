//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Roman Vakulenko on 15.06.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private lazy var photosContentView: UIView = {
        let photosContentView = UIView()
        photosContentView.translatesAutoresizingMaskIntoConstraints = false
        return photosContentView
    }()

    private lazy var labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()

    private lazy var arrowView: UILabel = {
        let arrow = UILabel()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.textColor = .black
        return arrow
    }()

    private lazy var photoView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)

        return imageCollection
    }()

    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - setup

    func setupPhotoForTableCell(model: GalleryModel, indexPath: IndexPath){
        labelView.text = "Photos"
        arrowView.text = ">"
        photoView = model.
    }

    func layout(){
        [labelView, arrowView, photoView].forEach { photosContentView.addSubview($0) }
        contentView.addSubview(photosContentView)

        NSLayoutConstraint.activate([
            photosContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photosContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photosContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            photosContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            labelView.leadingAnchor.constraint(equalTo: photosContentView.leadingAnchor, constant: 12),
            labelView.topAnchor.constraint(equalTo: photosContentView.topAnchor, constant: 12),

            arrowView.trailingAnchor.constraint(equalTo: photosContentView.trailingAnchor, constant: -12),
            arrowView.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),

            photoView.leadingAnchor.constraint(equalTo: photosContentView.leadingAnchor, constant: 12),
            photoView.trailingAnchor.constraint(equalTo: photosContentView.trailingAnchor, constant: -12),
            photoView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 12),
            photoView.bottomAnchor.constraint(equalTo: photosContentView.bottomAnchor, constant: -12),
        ])
    }
}
