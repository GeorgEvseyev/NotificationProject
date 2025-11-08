//
//  InclineViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.03.24.
//

import Foundation
import UIKit

protocol IInclineScreenViewController: AnyObject {
    func setLabelText(_ text: String)
}

final class InclineScreenViewController: UIViewController, IInclineScreenViewController {
    func setLabelText(_ text: String) {
        print("text")
    }
    
    private var userMenu: [String] = ["Incline1", "Incline2", "Incline3"]

    private let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let presenter: IInclineScreenPresenter

    init(presenter: IInclineScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(EditableTableViewCell.self,
                           forCellReuseIdentifier: EditableTableViewCell.identifier)
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self

        setupUI()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension InclineScreenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userMenu.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EditableTableViewCell.identifier,
            for: indexPath
        ) as? IEditableTableViewCell else {
            return UITableViewCell()
        }
        cell.setText(userMenu[indexPath.row])
        return cell as! UITableViewCell
    }
}



//class InclineScreenViewController: UIViewController {
//    var userMenu: [String] = ["Incline1", "Incline2", "Incline2"]
//
//    let tableView: UITableView = {
//        let tableView = UITableView()
//        return tableView
//    }()
//    
//    private let presenter: IInclineScreenPresenter
//
//    init(presenter: IInclineScreenPresenter) {
//        self.presenter = presenter
//
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
//        view.backgroundColor = .white
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        setupUI()
//    }
//
//    private func setupUI() {
//        view.addSubview(tableView)
//        tableView.snp.makeConstraints { make in
//            make.height.width.equalToSuperview()
//        }
//    }
//}
//
//extension InclineScreenViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        userMenu.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
//        cell.cellTextView.text = userMenu[indexPath.row]
//        return cell
//    }
//}
//
//extension InclineScreenViewController: IInclineScreenViewController {
//    func setLabelText(_ text: String) {
//
//    }
//}
