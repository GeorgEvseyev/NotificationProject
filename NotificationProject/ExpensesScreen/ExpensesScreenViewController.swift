//
//  ExpensesViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.03.24.
//

import Foundation
import UIKit

protocol IExpensesScreenController: AnyObject {
    func setLabelText(_ text: String)
}

final class ExpensesScreenViewController: UIViewController {
    var userMenu: [String] = ["Expense1", "Expensee2", "Expense3"]

    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let presenter: IExpensesScreenPresenter

    init(presenter: IExpensesScreenPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
    }
}

extension ExpensesScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.cellTextView.text = userMenu[indexPath.row]
        return cell
    }
}

extension ExpensesScreenViewController: IExpensesScreenController {
    func setLabelText(_ text: String) {

    }
}
