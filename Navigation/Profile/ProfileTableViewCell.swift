//
//  ProfileTableViewCell.swift
//  Navigation
//
//  Created by Roman Vakulenko on 08.06.2023.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    private lazy var postContentView: UIView = {
        let postView = UIView()
        postView.translatesAutoresizingMaskIntoConstraints = false
        return postView
    }()

    private lazy var labelView: UILabel = {
        let postLabel = UILabel()
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        postLabel.font = .systemFont(ofSize: 20, weight: .bold)
        postLabel.textColor = .black
        postLabel.numberOfLines = 2
        return postLabel
    }()

    private lazy var imageViewForPost: UIImageView = {
        let postImage = UIImageView()
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.contentMode = .scaleAspectFit
        postImage.clipsToBounds = true
        postImage.backgroundColor = .black
        return postImage
    }()

    private lazy var descriptionLabelView: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()

    lazy var likesLabelView: UILabel = {
        let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.font = .systemFont(ofSize: 16, weight: .regular)
        likesLabel.textColor = .black
        return likesLabel
    }()

    private lazy var viewsLabelView: UILabel = {
        let viewsLabel = UILabel()
        viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        viewsLabel.font = .systemFont(ofSize: 16, weight: .regular)
        viewsLabel.textColor = .black
        viewsLabel.textAlignment = .right
        return viewsLabel
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

    override func prepareForReuse() {
        super.prepareForReuse()
        labelView.text = nil
        imageViewForPost.image = nil
        descriptionLabelView.text = nil
        likesLabelView.text = nil
        viewsLabelView.text = nil
    }

    func setupCell(model: ProfilePosts) {
        labelView.text = model.author
        imageViewForPost.image = UIImage(named: model.image)
        descriptionLabelView.text = model.description
        likesLabelView.text = "Likes: " + model.likes.description
        viewsLabelView.text = "Views: " + model.views.description
    }

    //MARK: - layout
    private func layout() {
        [labelView, imageViewForPost, descriptionLabelView, likesLabelView, viewsLabelView].forEach { postContentView.addSubview($0) }
        contentView.addSubview(postContentView)
        let inset: CGFloat = 16
        NSLayoutConstraint.activate([
            postContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            labelView.topAnchor.constraint(equalTo: postContentView.topAnchor, constant: inset),
            labelView.leadingAnchor.constraint(equalTo: postContentView.leadingAnchor, constant: inset),
            labelView.widthAnchor.constraint(equalTo: postContentView.widthAnchor, constant: -32),

            imageViewForPost.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 12),
            imageViewForPost.leadingAnchor.constraint(equalTo: postContentView.leadingAnchor),
            imageViewForPost.trailingAnchor.constraint(equalTo: postContentView.trailingAnchor),
            imageViewForPost.heightAnchor.constraint(equalToConstant: contentView.frame.width),

            descriptionLabelView.topAnchor.constraint(equalTo: imageViewForPost.bottomAnchor, constant: inset),
            descriptionLabelView.leadingAnchor.constraint(equalTo: postContentView.leadingAnchor, constant: inset),
            descriptionLabelView.trailingAnchor.constraint(equalTo: postContentView.trailingAnchor, constant: -inset),

            likesLabelView.topAnchor.constraint(equalTo: descriptionLabelView.bottomAnchor, constant: inset),
            likesLabelView.leadingAnchor.constraint(equalTo: postContentView.leadingAnchor, constant: inset),
            likesLabelView.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),

            viewsLabelView.topAnchor.constraint(equalTo: descriptionLabelView.bottomAnchor, constant: inset),
            viewsLabelView.trailingAnchor.constraint(equalTo: postContentView.trailingAnchor, constant: -inset),
            viewsLabelView.widthAnchor.constraint(equalToConstant: contentView.frame.width/2),
            viewsLabelView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor, constant: -inset)
        ])
    }
}


