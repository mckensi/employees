//
//  AddSubEmployeeViewController.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 29/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import UIKit

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
    
    private func initListener(){
        viewModel.employeesListRes = { response in
            self.employees = response
            guard let subEmployes = self.employee?.subEmployees?.allObjects as? [SubEmployees] else {return}
            for subEmployee in subEmployes{
                self.employees?.removeAll(where: {$0.id == subEmployee.id})
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    private func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
        let nibCell = UINib(nibName: "SubEmployeeTableViewCell", bundle: nil)
        tableView.register(nibCell.self, forCellReuseIdentifier: "subEmployeeCell")
    }
}

extension AddSubEmployeeViewController : UITableViewDelegate{
    
}

extension AddSubEmployeeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "subEmployeeCell") as? SubEmployeeTableViewCell
        cell?.labelName.text = employees?[indexPath.row].name
        return cell ?? UITableViewCell()
    }
    
    
}
