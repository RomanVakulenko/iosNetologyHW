//
//  ProfilePosts.swift
//  Navigation
//
//  Created by Roman Vakulenko on 07.06.2023.
//

import UIKit

class ProfilePosts {
    var author = String()
    var image = String()
    var description = String()
    var likes = Int()
    var views = Int()

    init(author: String, image: String, description: String, likes: Int, views: Int) {
        self.author = author
        self.image = image
        self.description = description
        self.likes = likes
        self.views = views
    }

    static func createProfilePosts() -> [ProfilePosts]{
        var model = [ProfilePosts]()

        let post1st = ProfilePosts(author: "Simba", image: "Bengal",
                                    description: "Это одна из самых молодых пород на планете, полученная путём селекции диких бенгальских кошек с домашними котами. В результате, получился довольно удачный гибрид, в котором органично сочетаются охотничьи повадки и игривый характер. Несмотря на то, что предками бенгалов были хищники, представители этой породы хорошо контактируют с людьми и другими домашними животными, поддаются дрессировке.",
                                    likes: 3, views: 5)

        let post2nd = ProfilePosts(author: "Persi", image: "FoxTerrier",
                                    description: "Собаки породы фокстерьер обладают достаточно большой физической силой, бесстрашием и даже безрассудством. Эти собаки способны атаковать зверя, ростом и весом намного превышающего их собственный рост и вес.",
                                    likes: 2, views: 9)

        let post3rd = ProfilePosts(author: "Mouse", image: "Jerry",
                                    description: "Второй главный герой мультфильма «Том и Джерри». Является основной целью в различного рода погонях и схватках для кота Тома, и старается постоянно устроить Тому какую-нибудь пакость.",
                                    likes: 1, views: 3)

        let post4th = ProfilePosts(author: "Tom", image: "Tom",
                                    description: "Кот серо-голубого окраса, первый главный герой мультсериала «Том и Джерри», гоняющийся за мышонком Джерри.",
                                    likes: 5, views: 2)

        model.append(post1st)
        model.append(post2nd)
        model.append(post3rd)
        model.append(post4th)

        return model
    }
}
