//
//  UserViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 20.03.24.
//

import Foundation
import UIKit

protocol IUserScreenController: AnyObject {
    func setLabelText(_ text: String)
}

final class UserScreenViewController: UIViewController {
    var userMenu: [String] = ["Incline", "Expenses", "Settings"]

    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let presenter: IUserScreenPresenter

    init(presenter: IUserScreenPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self

        setupUI()
    }

    private func setupUI() {
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
}

extension UserScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.cellLabel.text = userMenu[indexPath.row]
        return cell
    }
}

extension UserScreenViewController: IUserScreenController {
    func setLabelText(_ text: String) {

    }
}
