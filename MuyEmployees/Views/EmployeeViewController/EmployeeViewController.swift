//
//  EmployeeViewController.swift
//  MuyEmployees
//
//  Created by Daniel Steven Murcia Almanza on 28/08/20.
//  Copyright © 2020 selvamatic. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var employee : Employee?
    private var subEmployees : [SubEmployeeRes]?
    private var viewModel = EmployeeViewModel()
    let headerSubEmployeesSectionView = HeaderSubEmployeesSectionView.instanceFromNib() as? HeaderSubEmployeesSectionView
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        self.title = employee?.name ?? ""
        setUpTable()
        initListener()
    }
    
    init(){
        super.init(nibName: "EmployeeViewController", bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initListener(){
        viewModel.employedDeleted = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func setUpTable(){
        tableView.delegate = self
        tableView.dataSource = self
        let nibCell = UINib(nibName: "HeaderEmployeeTableViewCell", bundle: nil)
        tableView.register(nibCell.self, forCellReuseIdentifier: "headerEmployeeCell")
        
        let nibCellSubEmployee = UINib(nibName: "EmplooyeTableViewCell", bundle: nil)
        tableView.register(nibCellSubEmployee.self, forCellReuseIdentifier: "subEmployeeCell")
    }
}

extension EmployeeViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 0:
            let action = UIContextualAction(style: .normal, title: "Editar") { (action, view, handler) in
                let alert = UIAlertController(title: "Editar colaborador", message: nil, preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "Nombre"
                }
                alert.addTextField { (textField) in
                    textField.placeholder = "Cargo"
                }
                let saveAction = UIAlertAction(title: "Guardar", style: .default) { (action) in
                    let textInFieldName = alert.textFields?[0].text ?? ""
                    let textInFieldPosition = alert.textFields?[1].text ?? ""
                }
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
                
                alert.addAction(saveAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true)
            }
            return UISwipeActionsConfiguration(actions: [action])
        case 1:
            let action = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, handler) in
                let subEmployes = self.employee?.subEmployees?.allObjects as? [SubEmployees]
                if let subEmployeeToDelete = subEmployes?[indexPath.row]{
                    self.viewModel.removeSubEmployee(subEmployed: subEmployeeToDelete)
                }
            
            }
            
            return UISwipeActionsConfiguration(actions: [action])

        default:
            return nil
        }
    }
}

extension EmployeeViewController : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 100
        default:
            return tableView.estimatedRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 80
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            return headerSubEmployeesSectionView ?? UIView()
        default:
            return UIView()
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return employee?.subEmployees?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerEmployeeCell") as? HeaderEmployeeTableViewCell
            cell?.labelPosition.text = "Cargo: \(employee?.position ?? "")"
            cell?.labelWage.text = "Salario: \(employee?.wage ?? 0)"
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "subEmployeeCell") as? EmplooyeTableViewCell
            let subEmployes = employee?.subEmployees?.allObjects as? [SubEmployees]
            cell?.labelName.text = subEmployes?[indexPath.row].name ?? ""
            cell?.labelPosition.isHidden = true
            return cell ?? UITableViewCell()
        default:
            return UITableViewCell()
        }
        
    }
    
    
}
