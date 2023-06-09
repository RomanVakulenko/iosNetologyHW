//
//  ProfilePosts.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.06.2023.
//

import UIKit

struct ProfilePosts {
    let author: String
    let image: UIImage
    let description: String
    let likes: Int
    let views: Int

    static func createProfilePosts() -> [ProfilePosts]{
        var model = [ProfilePosts]()

        let section1 = ProfilePosts(author: "Simba", image: UIImage(named: "Bengal")!, description: "Bengal", likes: 3, views: 5)
        let section2 = ProfilePosts(author: "Persi", image: UIImage(named: "FoxTerrier")!, description: "For terrier", likes: 2, views: 9)
        let section3 = ProfilePosts(author: "Mouse", image: UIImage(named: "Jerry")!, description: "Jerry", likes: 1, views: 3)
        let section4 = ProfilePosts(author: "Tom", image: UIImage(named: "Tom")!, description: "Tom", likes: 5, views: 2)

        model.append(section1)
        model.append(section2)
        model.append(section3)
        model.append(section4)

        return model
    }
}
