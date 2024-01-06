//
//  ViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 4.12.23.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }

    var cellViewModels: [EditableViewModel] = []

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = .lightGray
        tableView.separatorColor = .orange
        return tableView
    }()

    let calendarView: UIView = {
        let calendarView = UIView()
        calendarView.backgroundColor = .opaqueSeparator
        return calendarView
    }()

    let visualShadowView: UIView = {
        let visualShadowView = UIView()
        visualShadowView.backgroundColor = .black
        visualShadowView.alpha = 0.4
        return visualShadowView
    }()

    let bottomPartOfCalendarView: UIView = {
        let bottomPartOfCalendarView = UIView()
        bottomPartOfCalendarView.backgroundColor = .opaqueSeparator
        return bottomPartOfCalendarView
    }()

    let topImageView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = .green
        return imageView
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 24)
        titleLabel.text = "Сегодня, ВС"
        return titleLabel
    }()

    let menuButton: UIView = {
        let button = BurgerMenu()
        button.backgroundColor = .green
        return button
    }()

    let addNotificationButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 30
        button.backgroundColor = .orange
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addCellViewModels()

        Manager.shared.delegate = self


        let tapGestureRecognizer: UITapGestureRecognizer = {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
            return tapGestureRecognizer
        }()
        
        let swipeGestureRecognizer: UISwipeGestureRecognizer = {
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(hideCalendar))
            swipeRecognizer.direction = .left
            return swipeRecognizer
        }()

        let tapGestureRecognizerToHideCalendar: UITapGestureRecognizer = {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideCalendar))
            return tapGestureRecognizer
        }()
        
        let tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView: UITapGestureRecognizer = {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideCalendar))
            return tapGestureRecognizer
        }()

        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        view.addSubview(topImageView)
        view.addSubview(menuButton)
        view.addSubview(titleLabel)
//        setUpMenuButton()
        setUpAddNotificationButton()
        view.addSubview(visualShadowView)
        view.addSubview(calendarView)
        calendarView.addSubview(bottomPartOfCalendarView)
        menuButton.addGestureRecognizer(tapGestureRecognizer)
        calendarView.addGestureRecognizer(swipeGestureRecognizer)
        bottomPartOfCalendarView.addGestureRecognizer(tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView)
        visualShadowView.addGestureRecognizer(tapGestureRecognizerToHideCalendar)

        makeConstraints()
    }

//    func setUpMenuButton() {
//        let action = UIAction { _ in
//            self.showCalendar()
//        }
//        menuButton.addAction(action, for: .touchUpInside)
//        view.addSubview(menuButton)
//    }

    func setUpAddNotificationButton() {
        let action = UIAction { _ in
            self.addNotification()
        }
        addNotificationButton.addAction(action, for: .touchUpInside)
        view.addSubview(addNotificationButton)
    }

    func addNotification() {
        Manager.shared.notifications.append(Notification(text: "text", state: false))
        addCellViewModels()
        tableView.reloadData()
    }

    func showMenu() {
        let menuViewController = MenuViewController()
        present(menuViewController, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        let cellViewModel = cellViewModels[indexPath.row]
        if cellViewModel.cellState {
            cellViewModel.configureUncheckCell(cell: cell)
            cell.cellTextView.isUserInteractionEnabled = false
        } else {
            cellViewModel.configureCheckCell(cell: cell)
        }
//        cell.configure(object: Manager.shared.notifications[indexPath.row])
//        cell.configureButton {
//            cell.cellTextView.attributedText = cell.checked(text: Manager.shared.notifications[indexPath.row].text)
//            cell.cellTextView.isUserInteractionEnabled = false
//        }
        return cell
    }

    func makeConstraints() {
        topImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(60)
        }

        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topImageView.snp.bottom)
        }
        addNotificationButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
            make.height.width.equalTo(60)
        }
        menuButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.top.equalToSuperview().offset(8)
            make.height.width.equalTo(44)
        }
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(topImageView.snp.center)
        }
        visualShadowView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
        calendarView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
        bottomPartOfCalendarView.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(calendarView)
            make.height.equalTo(calendarView.snp.height).dividedBy(3)
        }
    }

    @objc func showCalendar() {
        visualShadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        calendarView.snp.remakeConstraints { make in
            make.right.equalTo(view.snp.right).inset(90)
            make.height.width.equalToSuperview()
        }
    }

    @objc func hideCalendar() {
        visualShadowView.snp.remakeConstraints { make in
            make.top.bottom.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
        calendarView.snp.remakeConstraints { make in
            make.top.bottom.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
    }

    func addCellViewModels() {
        cellViewModels = []
        for notification in Manager.shared.notifications {
            let cellViewModel = EditableViewModel(cellText: notification.text, cellState: notification.state)
            cellViewModels.append(cellViewModel)
        }
    }
}

extension ViewController: ManagerDelegate {
    func updateData() {
        tableView.reloadData()
    }
}
