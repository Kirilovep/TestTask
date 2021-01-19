//
//  NewWorkerViewController.swift
//  TestTask
//
//  Created by shizo on 18.01.2021.
//

import UIKit

class NewWorkerViewController: UITableViewController {
    
    var data: [CellsData] = []
    var profileData = ProfileData()
    var nameOfCompany: String = ""
    var savedImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerTableViewCells()
        createCellsData()
    }
    
    
    func createCellsData() {
        data.append(CellsData(type: .image, data: UIImage()))
        data.append(CellsData(type: .textInput, data: "Name"))
        data.append(CellsData(type: .textInput, data: "SurName"))
        data.append(CellsData(type: .textInput, data: "DateOfBirthday"))
        data.append(CellsData(type: .label, data: "Company"))
        data.append(CellsData(type: .button, data: "Save"))
    }
    
    func registerTableViewCells() {
        
        let avatarNib = UINib(nibName: "PhotoTableViewCell", bundle: nil)
        let nameNib = UINib(nibName: "NameTableViewCell", bundle: nil)
        let surNameNib = UINib(nibName: "SurNameTableViewCell", bundle: nil)
        let birthDayNib = UINib(nibName: "BirthDayTableViewCell", bundle: nil)
        let companyNib = UINib(nibName: "CompanyTableViewCell", bundle: nil)
        let saveNib = UINib(nibName: "SaveTableViewCell", bundle: nil)
        
        tableView.register(avatarNib, forCellReuseIdentifier: "photoCell")
        tableView.register(nameNib, forCellReuseIdentifier: "nameCell")
        tableView.register(surNameNib, forCellReuseIdentifier: "surNameCell")
        tableView.register(birthDayNib, forCellReuseIdentifier: "birthDayCell")
        tableView.register(companyNib, forCellReuseIdentifier: "companyCell")
        tableView.register(saveNib, forCellReuseIdentifier: "saveCell")
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentData = data[indexPath.row]
        switch currentData.type {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell") as! PhotoTableViewCell
            cell.delegate = self
            if let newImage = cell.avatarImageView?.image {
                savedImageView.image = newImage
                //print(savedImageView.image)
            }
            
            
            return cell
        case .textInput:
            if currentData.data as! String == "Name" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell") as! NameTableViewCell
                cell.nameTextField.tag = indexPath.row
                cell.nameTextField.delegate = self
                
                return cell
            } else if currentData.data as! String == "SurName"{
                let cell = tableView.dequeueReusableCell(withIdentifier: "surNameCell") as! SurNameTableViewCell
                cell.surNameTextField.tag = indexPath.row
                cell.surNameTextField.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "birthDayCell") as! BirthDayTableViewCell
                cell.birthDayTextField.tag = indexPath.row
                cell.birthDayTextField.delegate = self
                return cell
            }
        case .label:
            let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell") as! CompanyTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.configure(someName: profileData.company ?? "Выберите компанию")
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell") as! SaveTableViewCell
            cell.delegate = self
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch data[indexPath.row].type {
        case .image:
            return 200
        default:
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentData = data[indexPath.row]
        switch currentData.type {
        case .label:
            let vc = storyboard?.instantiateViewController(identifier: "secondVC") as! SecondTableViewController
            vc.onFinish = { (backNameOfCompany) in
                self.profileData.company = backNameOfCompany
                tableView.reloadData()
                print(self.nameOfCompany)
            }
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
        
        
    }
    
}

extension NewWorkerViewController: PhotoCellDelegate {
    func buttonPressed(cell: PhotoTableViewCell) {
        tableView.reloadData()
    }
    
    
}


extension NewWorkerViewController: SaveCellDelegate {
    func sharePressed(cell: SaveTableViewCell) {
        //guard let index = tableView.indexPath(for: cell)?.row else { return }
        
        if let name = profileData.name, let surName = profileData.surName, let birthday = profileData.birthDay, let company = profileData.company {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let workerEntity = WorkerEntity(context: context)
            workerEntity.name = name
            workerEntity.secondName = surName
            workerEntity.birthday = birthday
            workerEntity.company = company
            if let imageData = savedImageView.image?.pngData() {
                workerEntity.newImage = imageData
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            let alert = UIAlertController(title: "Successfully!", message: "Ваши данные сохранены", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Error", message: "Вы указали не все данные", preferredStyle: .alert)
            let action = UIAlertAction(title: "Try again", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
        
        
    }
}

extension NewWorkerViewController : UITextFieldDelegate {
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(valueChanged), for: .editingChanged)
    }
    
    @objc func valueChanged(_ textField: UITextField){
        
        if let newTextField = textField.text {
            switch textField.tag {
            case TextFieldData.nameTextField.rawValue:
                profileData.name = newTextField
            case TextFieldData.surnameTextField.rawValue:
                profileData.surName = newTextField
            case TextFieldData.birthDayTextField.rawValue:
                profileData.birthDay = newTextField
            default:
                break
            }
        }
        
        
    }
}
