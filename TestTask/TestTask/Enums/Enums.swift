//
//  Enums.swift
//  TestTask
//
//  Created by shizo on 19.01.2021.
//

import Foundation

enum DataType {
    case label
    case textInput
    case image
    case button
}


enum TextFieldData: Int {
    case nameTextField = 1
    case surnameTextField
    case birthDayTextField
}

enum HelperUrl: String {
    case loadPhotoUrl = "https://live.staticflickr.com/"
}


enum TableViewNibIdentifiers: String {
    case photoTableNibCell = "PhotoTableViewCell"
    case nameTableNibCell = "NameTableViewCell"
    case surNameTableNibCell = "SurNameTableViewCell"
    case birthdayTableNibCell = "BirthDayTableViewCell"
    case companyTableNibCell = "CompanyTableViewCell"
    case saveTableNibCell = "SaveTableViewCell"
    case staffTableNibCell = "StaffTableViewCell"
    case photosTableNibCell = "PhotosCollectionViewCell"
    case detailCompanyTableNibCell = "DetailCompanyTableViewCell"
}

enum TableViewCellsIdentifiers: String  {
    case idPhotoCell = "photoCell"
    case idNameCell = "nameCell"
    case idSurNameCell = "surNameCell"
    case idBirthdayCell = "birthDayCell"
    case idCompanyCell = "companyCell"
    case idSaveCell = "saveCell"
    case defaultCell = "reuseIdentifier"
    case idStaffCell = "staffCell"
    case idPhotosCell = "photosCell"
    case idCompaniesCell = "companiesCell"
}

enum VCIdentifiers: String {
    case secondVC = "secondVC"
    case avatarsVC = "avatarsVC"
    case newWorkerVC = "newWorkerVC"
    case detailVC = "detailVC"
    case detailCompaniesVC = "detailCompaniesVC"
}
