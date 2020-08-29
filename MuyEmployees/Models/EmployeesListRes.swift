//
//  EmployeesListRes.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import Foundation

// MARK: - EmployeesListRes
class EmployeesListRes: Codable {
    var companyName, address: String?
    var employees: [EmployeeRes]?

    enum CodingKeys: String, CodingKey {
        case companyName = "company_name"
        case address, employees
    }
}

// MARK: - EmployeesListResEmployee
class EmployeeRes: Codable {
    var id: Int?
    var name, position: String?
    var wage: Int?
    var employees: [SubEmployeeRes]?
}

// MARK: - EmployeeEmployee
class SubEmployeeRes: Codable {
    var id: Int?
    var name: String?
}
