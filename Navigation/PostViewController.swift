//
//  PostViewController.swift
//  Navigation
//
//  Created by Roman Vakulenko on 10.05.2023.
//

import UIKit

protocol PostVCLikesDelegate: AnyObject {
    func updateLikes(_ likes: Int, at indexPath: IndexPath)
}

final class PostViewController: UIViewController {

    //MARK: - properties

    var profileVC = ProfileViewController()
    var indexPath: IndexPath?
    var post: ProfilePosts?
    weak var delegate: PostVCLikesDelegate?

    private lazy var labelView: UILabel = {
        let postLabel = UILabel()
        postLabel.translatesAutoresizingMaskIntoConstraints = false
        postLabel.font = .systemFont(ofSize: 20, weight: .bold)
        postLabel.textColor = .black
        postLabel.textAlignment = .center
        postLabel.numberOfLines = 1
        return postLabel
    }()

    private lazy var imageViewForPost: UIImageView = {
        let postImage = UIImageView()
        postImage.translatesAutoresizingMaskIntoConstraints = false
        postImage.contentMode = .scaleAspectFill
        postImage.clipsToBounds = true
        postImage.backgroundColor = .black
        return postImage
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsVerticalScrollIndicator = false
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        return scrollview
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.clipsToBounds = true
        return contentView
    }()

    private lazy var likesLabelView: UILabel = {
        let likesLabel = UILabel()
        likesLabel.translatesAutoresizingMaskIntoConstraints = false
        likesLabel.font = .systemFont(ofSize: 16, weight: .regular)
        likesLabel.textColor = .black
        let tapGestureAtImageRecognizer = UITapGestureRecognizer(target: self, action: #selector(increaseLikes(_:)))
        likesLabel.addGestureRecognizer(tapGestureAtImageRecognizer)
        likesLabel.isUserInteractionEnabled = true
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

    private lazy var descriptionLabelView: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = .systemGray
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()

    //MARK: - lifecyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setPostModel() // 1.1. Правильно ли вызывать его тут или лучше в дидЛоад и почему? тут, думаю, потому что, уже находясь в PostViewController, жмем лайк и он увеличивается и должен обновиться - некое обновление семантически связываю с viewWillAppear - или не так - поясните, плиз. 1.2. Или метод надо вызывать вообще в ProfileViewController, когда создаем  PostViewController (187 строка там)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "More info",
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(rightHandAction))
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        setPostModel()
    }

    //MARK: - private methods
    private func layout(){
        view.addSubview(labelView)
        view.addSubview(imageViewForPost)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [likesLabelView, viewsLabelView, descriptionLabelView].forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            labelView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            labelView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            imageViewForPost.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageViewForPost.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageViewForPost.topAnchor.constraint(equalToSystemSpacingBelow: labelView.bottomAnchor, multiplier: 1),
            imageViewForPost.heightAnchor.constraint(equalToConstant: view.frame.width+100),

            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: imageViewForPost.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.leadingAnchor.constraint(equalToSystemSpacingAfter: scrollView.leadingAnchor, multiplier: 2),
            contentView.trailingAnchor.constraint(equalToSystemSpacingAfter: scrollView.trailingAnchor, multiplier: -2),
            contentView.topAnchor.constraint(equalToSystemSpacingBelow: scrollView.topAnchor, multiplier: 2),
            contentView.bottomAnchor.constraint(equalToSystemSpacingBelow: scrollView.bottomAnchor, multiplier: -2),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32),

            likesLabelView.topAnchor.constraint(equalTo: contentView.topAnchor),
            likesLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            likesLabelView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            viewsLabelView.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewsLabelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewsLabelView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            descriptionLabelView.topAnchor.constraint(equalToSystemSpacingBelow: viewsLabelView.bottomAnchor, multiplier: 1),
            descriptionLabelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            descriptionLabelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            descriptionLabelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setPostModel() {
        guard let post = post else {return}
        labelView.text = post.title
        imageViewForPost.image = UIImage(named: post.image)
        likesLabelView.text = "Likes: " + post.likes.description
        viewsLabelView.text = "Views: " + post.views.description
        descriptionLabelView.text = post.description + "some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text some text "
    }

    @objc func rightHandAction() {
        let infoViewController = InfoViewController()
        infoViewController.view.backgroundColor = .green
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .popover

        present(infoViewController, animated: true)
    }

    @objc func increaseLikes(_ sender: UITapGestureRecognizer) {
        guard let post = post,
              let indexPath = indexPath else {return}
        post.likes += 1
        likesLabelView.text = "Likes: " + post.likes.description
//        setPostModel() // 1.0. Онлайн обновлять отображение лайков на странице поста надо ЗДЕСЬ ПО ТАПУ или в методах ЖЦ этого PostViewController? Как это работает?

        delegate?.updateLikes(post.likes, at: indexPath) //говорим: делегат, обнови лайки (вот этими новыми лайками по нужному indexPath)
    }

    deinit {
        print( "PostViewController deinited")
    }
}

