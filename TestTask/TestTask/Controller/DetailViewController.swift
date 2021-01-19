//
//  DetailViewController.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit

class DetailViewController: UIViewController {

    var detailImage:Data?
    var company: String?
    var name: String?
    var surname: String?
    var birthday: String?

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        
    }
    
 
    
    func setUpView() {
        companyLabel.text = company
        nameLabel.text = name
        surnameLabel.text = surname
        birthdayLabel.text = birthday
        
        if let imageData = detailImage {
            detailImageView.image = UIImage(data: imageData)
        }
        
    }
    
    

}
