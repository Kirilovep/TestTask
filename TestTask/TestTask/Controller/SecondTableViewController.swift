//
//  SecondTableViewController.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit

class SecondTableViewController: UITableViewController {
    
    //MARK:- Properties -
    var companiesFromCoreData: [CompanyEntity] = []
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var onFinish: ((CompanyEntity) -> ())?
    var fromNewWorkerVC: Bool?
    //MARK:- LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromCoreData()
    }
    //MARK:- Functions
    private func getDataFromCoreData() {
        do {
            companiesFromCoreData = try context.fetch(CompanyEntity.fetchRequest())
            tableView.reloadData()
        } catch {
            print("Fetching Failed!")
        }
    }
    
    private func addAlert() {
        let alert = UIAlertController(title: "Add new company", message: "", preferredStyle: .alert)
        alert.addTextField { (companyNameField) in
            companyNameField.font = .systemFont(ofSize: 17)
            companyNameField.autocapitalizationType = .words
            companyNameField.placeholder = "Name of company"
            
            let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
                guard let textField = companyNameField.text else { return }
                if (companyNameField.text!.isEmpty)  {
                    self.showNotCorrectAlert()
                    return
                } else {
                    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                    let companies = CompanyEntity(context: context)
                    
                    companies.name = textField
                    (UIApplication.shared.delegate as! AppDelegate).saveContext()
                    self.getDataFromCoreData()
                }
                self.tableView.reloadData()
            }
            alert.addAction(okAction)
        }
        let cancelACtion = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(cancelACtion)
        present(alert, animated: true, completion: nil)
    }
    
    private func showNotCorrectAlert() {
        let alert = UIAlertController(title: "Error!", message: "Name empty", preferredStyle: .alert)
        let tryAction = UIAlertAction(title: "Try again", style: .default) { (_) in
            self.addAlert()
        }
        let cancelACtion = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(tryAction)
        alert.addAction(cancelACtion)
        present(alert, animated: true, completion: nil)
        
    }
    
    //MARK:- IBActions
    @IBAction func buttonPress(_ sender: UIBarButtonItem) {
        addAlert()
    }
    
    //MARK:- Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companiesFromCoreData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.defaultCell.rawValue, for: indexPath)
        
        cell.textLabel?.text = companiesFromCoreData[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if fromNewWorkerVC == true {
            navigationController?.popViewController(animated: true)
            
            if let finish = self.onFinish {
                finish(self.companiesFromCoreData[indexPath.row])
            }
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: VCIdentifiers.detailCompaniesVC.rawValue) as! DetailInfoCompanyViewController
            vc.bringId = indexPath.row
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = companiesFromCoreData[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                companiesFromCoreData = try context.fetch(CompanyEntity.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
}
