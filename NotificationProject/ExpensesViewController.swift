//
//  ExpensesViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.03.24.
//

import Foundation
import UIKit

final class ExpensesViewController: UIViewController {
    
    var userMenu: [String] = ["Expense1", "Expensee2", "Expense3" ]
    
    private let tableView: UITableView = {
      let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        makeConstraints()
    }
}

extension ExpensesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.cellTextView.text = userMenu[indexPath.row]
        return cell
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
}
