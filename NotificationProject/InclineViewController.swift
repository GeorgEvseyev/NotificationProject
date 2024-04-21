//
//  InclineViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.03.24.
//

import Foundation
import UIKit

class InclineViewController: UIViewController {
    
    var userMenu: [String] = ["Incline1", "Incline2", "Incline2"]
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self

        
        makeConsraints()
    }
}

extension InclineViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.cellTextView.text = userMenu[indexPath.row]
        return cell
    }
    
    func makeConsraints() {
        tableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
}
