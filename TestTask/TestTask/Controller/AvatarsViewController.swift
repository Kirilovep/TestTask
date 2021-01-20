//
//  PhotosViewController.swift
//  TestTask
//
//  Created by shizo on 20.01.2021.
//

import UIKit

class AvatarsViewController: UIViewController {
    
    //MARK:- Properties -
    private var photosFromAlbum: [Photo] = []
    var imageDataFromCell: [Data] = []
    var onFinish: ((String,String) -> ())?
    //MARK:- IBOutlets -
    @IBOutlet weak var mainCollectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: TableViewNibIdentifiers.photosTableNibCell.rawValue, bundle: nil)
            
            mainCollectionView.delegate = self
            mainCollectionView.dataSource = self
            mainCollectionView.register(nib, forCellWithReuseIdentifier: TableViewCellsIdentifiers.idPhotosCell.rawValue)
        }
    }
    
    //MARK:- LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPhotos()
    }
    
    //MARK: - Functions -
    private func loadPhotos() {
        NetworkManager.shared.loadPhotosFromAlbum { (photos) in
            DispatchQueue.main.async {
                self.photosFromAlbum = photos
                self.mainCollectionView.reloadData()
            }
        }
    }
}
//MARK:- Extensions -
extension AvatarsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosFromAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TableViewCellsIdentifiers.idPhotosCell.rawValue, for: indexPath) as! PhotosCollectionViewCell
        cell.configure(result: photosFromAlbum[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let finish = self.onFinish {
            finish(self.photosFromAlbum[indexPath.row].id ?? " ", self.photosFromAlbum[indexPath.row].secret ?? " ")
        }
        navigationController?.popViewController(animated: true)
    }
}
