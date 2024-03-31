//
//  UserViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 20.03.24.
//

import Foundation
import UIKit

final class UserViewController: UIViewController {
    
    var userMenu: [String] = ["Incline", "Expenses", "Settings" ]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        makeConstraints()
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.cellLabel.text = userMenu[indexPath.row]
        return cell
    }
    
    func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
}
