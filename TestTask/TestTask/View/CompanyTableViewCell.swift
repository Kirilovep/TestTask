//
//  CompanyTableViewCell.swift
//  TestTask
//
//  Created by shizo on 18.01.2021.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    //MARK:- IBOutlets-
    @IBOutlet weak var nameOfCompanyLabel: UILabel!
    
    //MARK:- LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    //MARK:- Functions -
    func configure(someName: String) {
        nameOfCompanyLabel.text = someName
    }
}
