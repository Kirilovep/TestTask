//
//  NewWorkerViewController.swift
//  TestTask
//
//  Created by shizo on 18.01.2021.
//

import UIKit

class NewWorkerViewController: UITableViewController {
    
    
    //MARK:- Properties -
    var data: [CellsData] = []
    var profileData = ProfileData()
    var savedImageView = UIImageView()
    var photoId: String?
    var photoSecret: String?
    //MARK:- LifeCycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        registerTableViewCells()
        createCellsData()
    }
    
    //MARK:- Functions -
    private func createCellsData() {
        data.append(CellsData(type: .image, data: UIImage()))
        data.append(CellsData(type: .textInput, data: "Name"))
        data.append(CellsData(type: .textInput, data: "SurName"))
        data.append(CellsData(type: .textInput, data: "DateOfBirthday"))
        data.append(CellsData(type: .label, data: "Company"))
        data.append(CellsData(type: .button, data: "Save"))
    }
    
    private func registerTableViewCells() {
        
        let avatarNib = UINib(nibName: TableViewNibIdentifiers.photoTableNibCell.rawValue, bundle: nil)
        let nameNib = UINib(nibName: TableViewNibIdentifiers.nameTableNibCell.rawValue, bundle: nil)
        let surNameNib = UINib(nibName: TableViewNibIdentifiers.surNameTableNibCell.rawValue, bundle: nil)
        let birthDayNib = UINib(nibName: TableViewNibIdentifiers.birthdayTableNibCell.rawValue, bundle: nil)
        let companyNib = UINib(nibName: TableViewNibIdentifiers.companyTableNibCell.rawValue, bundle: nil)
        let saveNib = UINib(nibName: TableViewNibIdentifiers.saveTableNibCell.rawValue, bundle: nil)
        
        tableView.register(avatarNib, forCellReuseIdentifier: TableViewCellsIdentifiers.idPhotoCell.rawValue)
        tableView.register(nameNib, forCellReuseIdentifier: TableViewCellsIdentifiers.idNameCell.rawValue)
        tableView.register(surNameNib, forCellReuseIdentifier: TableViewCellsIdentifiers.idSurNameCell.rawValue)
        tableView.register(birthDayNib, forCellReuseIdentifier: TableViewCellsIdentifiers.idBirthdayCell.rawValue)
        tableView.register(companyNib, forCellReuseIdentifier: TableViewCellsIdentifiers.idCompanyCell.rawValue)
        tableView.register(saveNib, forCellReuseIdentifier: TableViewCellsIdentifiers.idSaveCell.rawValue)
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentData = data[indexPath.row]
        switch currentData.type {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.idPhotoCell.rawValue) as! PhotoTableViewCell
            cell.configure(resultId: photoId ?? " ", resultSecret: photoSecret ?? " " )
            cell.delegate = self
            if let newImage = cell.avatarImageView?.image {
                savedImageView.image = newImage
            }
            
            return cell
        case .textInput:
            if currentData.data as! String == "Name" {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.idNameCell.rawValue) as! NameTableViewCell
                cell.nameTextField.tag = indexPath.row
                cell.nameTextField.delegate = self
                
                return cell
            } else if currentData.data as! String == "SurName"{
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.idSurNameCell.rawValue) as! SurNameTableViewCell
                cell.surNameTextField.tag = indexPath.row
                cell.surNameTextField.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.idBirthdayCell.rawValue) as! BirthDayTableViewCell
                cell.birthDayTextField.tag = indexPath.row
                cell.birthDayTextField.delegate = self
                return cell
            }
        case .label:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.idCompanyCell.rawValue) as! CompanyTableViewCell
            cell.accessoryType = .disclosureIndicator
            cell.configure(someName: profileData.hisCompany?.name ?? "Выберите компанию")
            return cell
        case .button:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellsIdentifiers.idSaveCell.rawValue) as! SaveTableViewCell
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
            let vc = storyboard?.instantiateViewController(identifier: VCIdentifiers.secondVC.rawValue) as! SecondTableViewController
            vc.onFinish = { (backCompany) in
                self.profileData.hisCompany = backCompany
                tableView.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}

//MARK:- Extensions
extension NewWorkerViewController: PhotoCellDelegate {
    func sharePressed(cell: PhotoTableViewCell) {
        let vc = storyboard?.instantiateViewController(identifier: VCIdentifiers.avatarsVC.rawValue) as! AvatarsViewController
        vc.onFinish = { (backId, backSecret) in
            self.photoId = backId
            self.photoSecret = backSecret
            self.tableView.reloadData()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension NewWorkerViewController: SaveCellDelegate {
    func sharePressed(cell: SaveTableViewCell) {
        //guard let index = tableView.indexPath(for: cell)?.row else { return }
        
        if let name = profileData.name, let surName = profileData.surName, let birthday = profileData.birthDay, let company = profileData.hisCompany {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let workerEntity = WorkerEntity(context: context)
            workerEntity.name = name
            workerEntity.secondName = surName
            workerEntity.birthday = birthday
            workerEntity.hisCompany = company
            if let imageData = savedImageView.image?.pngData() {
                workerEntity.imageData = imageData
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
