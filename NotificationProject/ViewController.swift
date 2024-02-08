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

    var date: String?

    var viewModel = ViewModel()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.backgroundColor = .lightGray
        tableView.separatorColor = .orange
        return tableView
    }()

    let menuView: UIView = {
        let menuView = UIView()
        menuView.backgroundColor = .opaqueSeparator
        return menuView
    }()

    let calendarView: UICalendarView = {
        let calendarView = UICalendarView()

        calendarView.locale = .current

        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.calendar = Calendar.current
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
        titleLabel.text = ""
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
        Manager.shared.delegate = self
        viewModel.delegate = self
        UserDefaultsManager.shared.load()
        Manager.shared.notificationDate = calendarView.visibleDateComponents.date?.formatted(date: .abbreviated, time: .omitted) ?? ""
        titleLabel.text = Manager.shared.notificationDate

        let selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selectionBehavior

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
        setUpAddNotificationButton()
        view.addSubview(visualShadowView)
        view.addSubview(menuView)
        menuView.addSubview(bottomPartOfCalendarView)
        menuView.addSubview(calendarView)
        menuButton.addGestureRecognizer(tapGestureRecognizer)
        menuView.addGestureRecognizer(swipeGestureRecognizer)
        bottomPartOfCalendarView.addGestureRecognizer(tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView)
        visualShadowView.addGestureRecognizer(tapGestureRecognizerToHideCalendar)
        makeConstraints()
    }

    func setUpAddNotificationButton() {
        let action = UIAction { _ in
            self.viewModel.addNotificationButtonPressed()
        }
        addNotificationButton.addAction(action, for: .touchUpInside)
        view.addSubview(addNotificationButton)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Manager.shared.getFilteredNotifications().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.cellTextView.delegate = cell
        cell.configure(with: indexPath.row)
        cell.configureButton {
            cell.prepareForReuse()
            self.viewModel.toggleNotificationState(index: indexPath.row)
        }
        cell.cellTextView.delegate = cell

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
            make.edges.equalToSuperview()
        }
        visualShadowView.alpha = 0

        menuView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
        bottomPartOfCalendarView.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(menuView)
            make.height.equalTo(menuView.snp.height).dividedBy(3)
        }
        calendarView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(25)
            make.width.equalTo(240)
        }
    }

    @objc func showCalendar() {
        UIView.animate(withDuration: 0.3) {
            self.visualShadowView.alpha = 0.4
            self.menuView.snp.remakeConstraints { make in
                make.right.equalTo(self.view.snp.right).inset(90)
                make.height.width.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
    }

    @objc func hideCalendar() {
        visualShadowView.snp.remakeConstraints { make in
            make.top.bottom.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
        menuView.snp.remakeConstraints { make in
            make.top.bottom.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
        Manager.shared.delegate?.updateData()
    }
}

extension ViewController: ManagerDelegate {
    func updateData() {
        UserDefaultsManager.shared.save()
        tableView.reloadData()
    }
}

extension ViewController: ViewModelDelegate {
    func addNotification(notification: Notification) {
        Manager.shared.notifications.append(notification)
        UserDefaultsManager.shared.save()
        Manager.shared.delegate?.updateData()
    }
}

extension ViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        Manager.shared.notificationDate = dateComponents?.date?.formatted(date: .abbreviated, time: .omitted) ?? ""
        titleLabel.text = Manager.shared.notificationDate
        hideCalendar()
    }
}
