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
            cell.configure(someName: nameOfCompany)
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
            return 40
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentData = data[indexPath.row]
        switch currentData.type {
        case .label:
            let vc = storyboard?.instantiateViewController(identifier: "secondVC") as! SecondTableViewController
            vc.onFinish = { (backNameOfCompany) in
                self.nameOfCompany = backNameOfCompany
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
        print("hello")
        let alert = UIAlertController(title: "Successfully!", message: "Ваши данные сохранены", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let workerEntity = WorkerEntity(context: context)
        workerEntity.name = profileData.name
        workerEntity.secondName = profileData.surName
        workerEntity.birthday = profileData.birthDay
        workerEntity.company = nameOfCompany
        if let imageData = savedImageView.image?.pngData() {
            workerEntity.newImage = imageData
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
//        if let imageData = savedImageView.image?.pngData() {
//            DataBaseHelper.shareInstance.saveImage(data: imageData)
//        }
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
