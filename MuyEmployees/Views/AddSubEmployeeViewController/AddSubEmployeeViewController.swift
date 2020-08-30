//
//  AddSubEmployeeViewController.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 29/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import UIKit
import NotificationBannerSwift
import SVProgressHUD

class AddSubEmployeeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = AddSubEmployeeViewModel()
    
    private var employees : [Employee]?
    var employee : Employee?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        initListener()
        viewModel.getEmployeesList()
        self.title = "Añadir"
        // Do any additional setup after loading the view.
    }
    
    init(){
        super.init(nibName: "AddSubEmployeeViewController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Init Listeners
    
    private func initListener(){
        viewModel.employeesListRes = { [weak self] response in
            guard let strongSelf = self else{return}
            strongSelf.employees = response
            guard let subEmployes = strongSelf.employee?.subEmployees?.allObjects as? [SubEmployees] else {return}
            for subEmployee in subEmployes{
                strongSelf.employees?.removeAll(where: {$0.id == subEmployee.id})
            }
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
        
        viewModel.addSubEmployeeToEmployeeRes = {
            let banner = NotificationBanner(title: "Genial!", subtitle: "Has agregado un nuevo colaborador", style: .success)
                     banner.backgroundColor = .systemGreen
                     banner.show()
            SVProgressHUD.dismiss()
            self.navigationController?.popViewController(animated: true)
        }
        
        viewModel.onFailure = {
            let banner = NotificationBanner(title: "Error", subtitle: "Ocurrio un problema con tu busqueda, trabajamos para resolverlo.", style: .danger)
            banner.backgroundColor = .systemYellow
            banner.show()
        }
    }
    private func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
        let nibCell = UINib(nibName: "SubEmployeeTableViewCell", bundle: nil)
        tableView.register(nibCell.self, forCellReuseIdentifier: "subEmployeeCell")
    }
}

//MARK: Extensions

extension AddSubEmployeeViewController : UITableViewDelegate{
    
}

extension AddSubEmployeeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subEmployeeCell") as? SubEmployeeTableViewCell
        cell?.labelName.text = employees?[indexPath.row].name
        cell?.setDelegate(delegate: self)
        cell?.indexRow = indexPath.row
        return cell ?? UITableViewCell()
    }
}

extension AddSubEmployeeViewController : SubEmployeeTableViewCellDelegate{
    func addSubEmployee(index: Int) {
        guard let employeeToAdded = employees?[index] else{return}
        SVProgressHUD.show()
        viewModel.addSubEmployeeToEmployee(employee: self.employee!, name: employeeToAdded.name ?? "", id: Int("\(employeeToAdded.id)") ?? 0)
    }
}
