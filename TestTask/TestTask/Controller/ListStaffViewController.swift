//
//  ListStaffViewController.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import UIKit

class ListStaffViewController: UIViewController {
    
    //MARK:- Properties -
    var listWorkers: [WorkerEntity] = []
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:- IBOutlets -
    @IBOutlet weak var listStaffTableView: UITableView! {
        didSet {
            listStaffTableView.delegate = self
            listStaffTableView.dataSource = self
            
            let nib = UINib(nibName: TableViewNibIdentifiers.staffTableNibCell.rawValue, bundle: nil)
            listStaffTableView.register(nib, forCellReuseIdentifier: TableViewCellsIdentifiers.idStaffCell.rawValue)
            listStaffTableView.rowHeight = 70
        }
    }
    //MARK:- LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDataFromCoreData()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    //MARK:- Functions -
    private func getDataFromCoreData() {
        do {
            listWorkers = try context.fetch(WorkerEntity.fetchRequest())
            listStaffTableView.reloadData()
        } catch {
            print("Fetching Failed!")
        }
    }
    
    //MARK:- IBActions -
    @IBAction func buttonPress(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(identifier: VCIdentifiers.newWorkerVC.rawValue) as! NewWorkerViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: - Extension -
extension ListStaffViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listWorkers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.idStaffCell.rawValue, for: indexPath) as! StaffTableViewCell
        
        cell.configure(result: listWorkers[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: VCIdentifiers.detailVC.rawValue) as! DetailViewController
        vc.name = listWorkers[indexPath.row].name
        vc.surname = listWorkers[indexPath.row].secondName
        vc.birthday = listWorkers[indexPath.row].birthday
        vc.company = listWorkers[indexPath.row].hisCompany?.name
        vc.detailImage = listWorkers[indexPath.row].imageData
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = listWorkers[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                listWorkers = try context.fetch(WorkerEntity.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        listStaffTableView.reloadData()
    }
}
