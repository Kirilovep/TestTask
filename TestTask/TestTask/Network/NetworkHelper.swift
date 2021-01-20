//
//  networkManager.swift
//  TestTask
//
//  Created by shizo on 20.01.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init(){}
    
    func loadPhotosFromAlbum(_ completionHandler: @escaping ([Photo]) -> Void ) {
        let url = "https://www.flickr.com/services/rest/?method=flickr.photosets.getPhotos&api_key=3b41e67ae76859760e5ab80d88f61eea&photoset_id=72157639990929493&user_id=66956608@N06&extras=media&format=json&nojsoncallback=1"
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, responce, error ) in
                if error != nil {
                    print("error in request")
                } else {
                    if let resp = responce as? HTTPURLResponse,
                       resp.statusCode == 200,
                       let responceData = data {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let resultPhotos = try? decoder.decode(PhotosJSONModel.self, from: responceData)
                        completionHandler(resultPhotos?.photoset.photo ?? [ ])
                    }
                }
            }.resume()
        }
    }
}
