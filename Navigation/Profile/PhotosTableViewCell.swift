//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Roman Vakulenko on 15.06.2023.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    private let gallery = GalleryModel.createMockModel()

    private lazy var imageContentView: UIView = {
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
        layout.scrollDirection = .horizontal

        let imageCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        imageCollection.translatesAutoresizingMaskIntoConstraints = false
        imageCollection.showsHorizontalScrollIndicator = false
        imageCollection.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        imageCollection.dataSource = self
        imageCollection.delegate = self
        imageCollection.reloadData()
        return imageCollection
    }()

//    private lazy var photoView: UIImageView = {
//        let photo = UIImageView()
//        photo.translatesAutoresizingMaskIntoConstraints = false
//        photo.contentMode = .scaleAspectFit
//        photo.clipsToBounds = true
//        return photo
//    }()

    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - setup
    func setupPhotoForTableCell(model: GalleryModel) {
        labelView.text = "Photos"
        arrowView.text = ">"
        imageCollection.dataSource = self
        imageCollection.delegate = self
        imageCollection.reloadData()
    }

    func layout(){
//        imageCollection.addSubview(photoView)
        [labelView, arrowView, imageCollection].forEach { imageContentView.addSubview($0) }
        contentView.addSubview(imageContentView)

        NSLayoutConstraint.activate([
            imageContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            labelView.leadingAnchor.constraint(equalTo: imageContentView.leadingAnchor, constant: 12),
            labelView.topAnchor.constraint(equalTo: imageContentView.topAnchor, constant: 12),

            arrowView.trailingAnchor.constraint(equalTo: imageContentView.trailingAnchor, constant: -12),
            arrowView.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),

            imageCollection.leadingAnchor.constraint(equalTo: imageContentView.leadingAnchor, constant: 12),
            imageCollection.trailingAnchor.constraint(equalTo: imageContentView.trailingAnchor, constant: -12),
            imageCollection.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 12),
            imageCollection.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor, constant: -12),
        ])
    }
}


// MARK: - UICollectionViewDataSource
extension PhotosTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else { return UICollectionViewCell()}

        cell.setupImageCollectionCell(model: gallery[indexPath.item])
        cell.layer.cornerRadius = 5
        return cell
    }
}

 
// MARK: - UICollectionViewDelegate
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {

    private var inset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (UIScreen.main.bounds.width - inset * 3) / 4
//        let height = width * 9 / 16
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}

