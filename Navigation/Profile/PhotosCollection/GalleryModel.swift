//
//  GalleryModel.swift
//  Navigation
//
//  Created by Roman Vakulenko on 15.06.2023.
//

import UIKit

struct GalleryModel {
    var photo: String

    static func createMockModel() -> [GalleryModel] {
        var imageArr = [GalleryModel]()


        for i in 1...20 {
            let image = GalleryModel(photo: String(i))
            imageArr.append(image)
        }
        return imageArr
    }
}

