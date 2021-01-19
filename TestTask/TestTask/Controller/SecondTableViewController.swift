//
//  SecondTableViewController.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit

class SecondTableViewController: UITableViewController {

    var dataOfCompany: [CompanyData] = [CompanyData(name: "Apple"), CompanyData(name: "Google"), CompanyData(name: "IBM"), CompanyData(name: "Tesla"), CompanyData(name: "Microsoft")]
    
    var onFinish: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    
    func createCompanies() {
       
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataOfCompany.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = dataOfCompany[indexPath.row].name
         
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popToRootViewController(animated: true)
        if let finish = self.onFinish {
            finish(self.dataOfCompany[indexPath.row].name)
        }
    }
    
}
