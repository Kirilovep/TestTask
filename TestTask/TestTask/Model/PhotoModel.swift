//
//  PhotoModel.swift
//  TestTask
//
//  Created by shizo on 20.01.2021.
//

import Foundation

struct PhotosJSONModel: Codable {
    let photoset: Photos
    let stat: String
}

struct Photos: Codable {
    let id: String?
    let photo: [Photo]
}


struct Photo: Codable {
    let id: String?
    let secret: String?
    let title: String?
}


