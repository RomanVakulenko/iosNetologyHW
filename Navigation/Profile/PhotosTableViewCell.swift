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
        imageCollection.register(ImageCollectionForTableCell.self, forCellWithReuseIdentifier: ImageCollectionForTableCell.identifier)
        imageCollection.dataSource = self
        imageCollection.delegate = self
        imageCollection.reloadData()
//        imageCollection.isUserInteractionEnabled = false //если не нужно взаимодействовать с элементами коллекции
        return imageCollection
    }()


//    private lazy var picView: UIImageView = {
//        let pic = UIImageView()
//        pic.translatesAutoresizingMaskIntoConstraints = false
//        pic.layer.cornerRadius = 10
//        pic.image = UIImage(named: "1")
//        pic.clipsToBounds = true
//        return pic
//    }()
//    private lazy var pic2View: UIImageView = {
//        let pic = UIImageView()
//        pic.translatesAutoresizingMaskIntoConstraints = false
//        pic.layer.cornerRadius = 10
//        pic.image = UIImage(named: "2")
//        pic.clipsToBounds = true
//        return pic
//    }()
//    private lazy var pic3View: UIImageView = {
//        let pic = UIImageView()
//        pic.translatesAutoresizingMaskIntoConstraints = false
//        pic.layer.cornerRadius = 10
//        pic.image = UIImage(named: "3")
//        pic.clipsToBounds = true
//        return pic
//    }()
//    private lazy var pic4View: UIImageView = {
//        let pic = UIImageView()
//        pic.translatesAutoresizingMaskIntoConstraints = false
//        pic.layer.cornerRadius = 10
//        pic.image = UIImage(named: "4")
//        pic.clipsToBounds = true
//        return pic
//    }()

//    var tapHandler: (() -> ())? // это свойство нужно добавить модели вьюхи где будешь юзать (например модель ячейки или модель панели в ячейке)

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
    }

    func layout(){
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

//            picView.leadingAnchor.constraint(equalTo: imageContentView.leadingAnchor, constant: 12),
//            picView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width - 12*5)/4),
//            picView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 12),
//            picView.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor, constant: -12),
//
//            pic2View.leadingAnchor.constraint(equalTo: picView.trailingAnchor, constant: 12),
//            pic2View.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width - 12*5)/4),
//            pic2View.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 12),
//            pic2View.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor, constant: -12),
//
//            pic3View.leadingAnchor.constraint(equalTo: pic2View.trailingAnchor, constant: 12),
//            pic3View.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width - 12*5)/4),
//            pic3View.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 12),
//            pic3View.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor, constant: -12),
//
//            pic4View.leadingAnchor.constraint(equalTo: pic3View.trailingAnchor, constant: 12),
//            pic4View.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.size.width - 12*5)/4),
//            pic4View.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 12),
//            pic4View.bottomAnchor.constraint(equalTo: imageContentView.bottomAnchor, constant: -12),

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
        gallery.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionForTableCell.identifier, for: indexPath) as? ImageCollectionForTableCell else { return UICollectionViewCell()}

        cell.setupImageCollectionCell(model: gallery[indexPath.item])
        return cell
    }
}

 
// MARK: - UICollectionViewDelegate
extension PhotosTableViewCell: UICollectionViewDelegateFlowLayout {

    private var inset: CGFloat { return 8 }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 24 ) / 4
        return CGSize(width: width, height: width * 5.6 / 7)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        что написать, чтобы по тапу перейти в галлерею - контроллер ???
            let galleryVC = GallaryCollectionViewController()
//            navigationController?.pushViewController(galleryVC, animated: true)
        UIApplication.topViewController()!.navigationController?.pushViewController(galleryVC, animated: true)
        print(indexPath)
    }
}

