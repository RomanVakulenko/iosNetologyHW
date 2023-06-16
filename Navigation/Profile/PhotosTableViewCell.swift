//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Roman Vakulenko on 15.06.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private let gallery = GalleryModel.createMockModel()

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

    private lazy var imageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.identifier)
        imageCollection.dataSource = self
        imageCollection.delegate = self
        imageCollection.reloadData()
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
        imageCollection.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath)
    }

    func layout(){
        [labelView, arrowView, imageCollection].forEach { photosContentView.addSubview($0) }
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

            imageCollection.leadingAnchor.constraint(equalTo: photosContentView.leadingAnchor, constant: 12),
            imageCollection.trailingAnchor.constraint(equalTo: photosContentView.trailingAnchor, constant: -12),
            imageCollection.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 12),
            imageCollection.bottomAnchor.constraint(equalTo: photosContentView.bottomAnchor, constant: -12),
        ])
    }
}

// MARK: - UICollectionViewDataSource
extension PhotosTableViewCell: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        gallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.identifier, for: indexPath) as? GalleryCollectionViewCell else { return UICollectionViewCell()}

        cell.setupGalleryCell(model: gallery[indexPath.section])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {

    private var inset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - inset * 5) / 4
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

}
