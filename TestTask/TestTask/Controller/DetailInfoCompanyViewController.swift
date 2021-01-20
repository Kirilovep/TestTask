//
//  DetailInfoCompanyViewController.swift
//  TestTask
//
//  Created by shizo on 20.01.2021.
//

import UIKit
import CoreData
class DetailInfoCompanyViewController: UIViewController {
    
    //MARK:- Properties -
    var listOfCompany: [CompanyEntity] = []
    var bringId: Int?
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:- IBOutlets -
    @IBOutlet weak var detailTableView: UITableView! {
        didSet {
            detailTableView.delegate = self
            detailTableView.dataSource = self
            
            let nib = UINib(nibName: TableViewNibIdentifiers.detailCompanyTableNibCell.rawValue, bundle: nil)
            detailTableView.register(nib, forCellReuseIdentifier: TableViewCellsIdentifiers.idCompaniesCell.rawValue)
        }
    }
    
    //MARK:- LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromCoreData(id: bringId ?? 0)
    }
    
    //MARK:- Functions -
    private func getDataFromCoreData(id:Int) {
        
        do {
            let result = try context.fetch(CompanyEntity.fetchRequest())
            
            if result.count > 0 {
                let person = result[id] as! NSManagedObject
                listOfCompany.append(person as! CompanyEntity)
            }
        } catch {
            print("Fetching Failed!")
        }
    }
}
//MARK:- Extensions -
extension DetailInfoCompanyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCompany.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.idCompaniesCell.rawValue) as! DetailCompanyTableViewCell
        cell.companyNameLabel.text = listOfCompany[indexPath.row].name
        
        if let countEmployees = listOfCompany[indexPath.row].employees?.count {
            cell.countEmloyees.text = "\(countEmployees)"
        }
        return cell
    }
}
