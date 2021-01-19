//
//  CompanyTableViewCell.swift
//  TestTask
//
//  Created by shizo on 18.01.2021.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfCompanyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
    func configure(someName: String) {
        nameOfCompanyLabel.text = someName
    }
    
}
