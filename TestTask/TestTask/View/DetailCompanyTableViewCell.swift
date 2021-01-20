//
//  DetailCompanyTableViewCell.swift
//  TestTask
//
//  Created by shizo on 20.01.2021.
//

import UIKit

class DetailCompanyTableViewCell: UITableViewCell {

    //MARK:- IBOutlets -
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var countEmloyees: UILabel!
    
    //MARK:- LifeCycle -
    override func awakeFromNib() {
        super.awakeFromNib()

    }
}
