//
//  ViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 4.12.23.
//

import SnapKit
import UIKit

private extension CGFloat {
    static let height: CGFloat = 44
    static let cornerRadius: CGFloat = 30
    static let darkAlpha: CGFloat = 0.4
    static let font: CGFloat = 24
}

private extension String {
    static let empty: String = ""
    static let error: String = "Error"
}

private extension Double {
    static let defaultDuration: Double = 0.3
}

final class ViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }

    var date: String?

    var viewModel = ViewModel()

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = .height
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
    
    let buttonView: UIView = {
        let buttonView = UIView()
        buttonView.backgroundColor = .blue
        return buttonView
    }()

    let visualShadowView: UIView = {
        let visualShadowView = UIView()
        visualShadowView.backgroundColor = .black
        visualShadowView.alpha = .darkAlpha
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
        titleLabel.font = .systemFont(ofSize: .font)
        titleLabel.text = .empty
        return titleLabel
    }()

    let menuButton: UIView = {
        let button = BurgerMenu()
        button.backgroundColor = .green
        return button
    }()

    let editButton: UIButton = {
        let editButton = UIButton()
        editButton.backgroundColor = .green
        editButton.setImage(.actions, for: .normal)
        return editButton
    }()

    let addNotificationButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = .cornerRadius
        button.backgroundColor = .orange
        return button
    }()

    let userLabel: UILabel = {
        let userLabel = UILabel()
        userLabel.backgroundColor = .red
        return userLabel
    }()

    let userButton: UIButton = {
        let userButton = UIButton()
        userButton.backgroundColor = .green
        return userButton
    }()
    
    let inclineButton: UIButton = {
       let inclineButton = UIButton()
        inclineButton.backgroundColor = .darkGray
        return inclineButton
    }()
    
    let expensesButton: UIButton = {
       let expensesButton = UIButton()
        expensesButton.backgroundColor = .darkGray
        return expensesButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        Manager.shared.delegate = self
        viewModel.delegate = self

        Manager.shared.load()
        Manager.shared.setDate(date: Date().formatted(date: .abbreviated, time: .omitted))
        titleLabel.text = Manager.shared.getDate()
        let selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selectionBehavior

        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.delegate = self

        view.addSubview(tableView)
        view.addSubview(topImageView)
        view.addSubview(menuButton)
        view.addSubview(editButton)
        view.addSubview(titleLabel)

        setUpAddNotificationButton()
        setUpEditButton()
        setupUserButton()
        setupInclineButton()
        setupExpensesButton()

        view.addSubview(visualShadowView)
        view.addSubview(menuView)
        view.addSubview(buttonView)

        setupRecognizers()

        menuView.addSubview(bottomPartOfCalendarView)
        menuView.addSubview(calendarView)
        menuView.addSubview(userLabel)
//        menuView.addSubview(userButton)

        makeConstraints()
    }
}

private extension ViewController {
    func setUpEditButton() {
        let action = UIAction { _ in
            self.editTableView()
        }
        editButton.addAction(action, for: .touchUpInside)
    }

    func setUpAddNotificationButton() {
        let action = UIAction { _ in
            self.viewModel.addNotificationButtonPressed()
        }
        addNotificationButton.addAction(action, for: .touchUpInside)
        view.addSubview(addNotificationButton)
    }
    
    func setupUserButton() {
        let action = UIAction { _ in
            self.moveToUserViewController()
        }
        userButton.addAction(action, for: .touchUpInside)
        menuView.addSubview(userButton)
    }
    
    func setupInclineButton() {
        let action = UIAction { _ in
            self.moveToInclineViewController()
        }
        inclineButton.addAction(action, for: .touchUpInside)
        buttonView.addSubview(inclineButton)
    }
    
    func setupExpensesButton() {
        let action = UIAction { _ in
            self.moveToExpensesViewController()
        }
        expensesButton.addAction(action, for: .touchUpInside)
        buttonView.addSubview(expensesButton)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getFilteredNotifications().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.setEditing(true, animated: false)
        cell.cellTextView.delegate = cell

        cell.configure(notification: viewModel.getNotification(index: indexPath.row), index: indexPath.row)
        cell.configureButton {
            cell.prepareForReuse()
            Manager.shared.toggleNotificationState(notification: self.viewModel.getNotification(index: indexPath.row))
        }
        cell.configureDetailButton {
            self.moveDetailViewController()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let notification = viewModel.getFilteredNotifications()[indexPath.row]
            Manager.shared.removeNotification(notification: notification)
            Manager.shared.delegate?.updateData()
        }
    }

    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        var filteredNotifications = Manager.shared.notifications[Manager.shared.getDate()] ?? [Notification]()

        let item = filteredNotifications[sourceIndexPath.row]

        filteredNotifications.remove(at: sourceIndexPath.row)
        filteredNotifications.insert(item, at: destinationIndexPath.row)

        if let sourceIndex = Manager.shared.notifications[item.date]?.firstIndex(where: { $0.id == item.id }) {
            if let destinationIndex = Manager.shared.notifications[item.date]?.firstIndex(where: { $0.id == filteredNotifications[destinationIndexPath.row].id }) {
                for notification in filteredNotifications {
                    print(notification.text)
                }

                Manager.shared.notifications[Manager.shared.getDate()]?.swapAt(sourceIndex, destinationIndex)
                Manager.shared.notifications[item.date] = filteredNotifications
                for notification in Manager.shared.notifications[item.date]! {
                    print(notification.text)
                }
            }
        }
        tableView.reloadData()
    }

    func editTableView() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }

    func makeConstraints() {
        topImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(90)
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
            make.left.equalToSuperview().offset(Offsets.minimumOffset)
            make.bottom.equalTo(topImageView.snp.bottom).inset(Offsets.smallOffset)
            make.height.width.equalTo(44)
        }
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Insets.minimumInset)
            make.bottom.equalTo(topImageView.snp.bottom).inset(Insets.minimumInset)
            make.height.width.equalTo(44)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(topImageView.snp.centerX)
            make.bottom.equalTo(topImageView.snp.bottom).inset(Insets.minimumInset)
        }
        visualShadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        visualShadowView.alpha = 0

        menuView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
        buttonView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
        }
        
        inclineButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.top.equalTo(buttonView.snp.top).offset(16)
            make.centerX.equalTo(buttonView.snp.centerX).inset(80)
        }
        
        expensesButton.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.top.equalTo(buttonView.snp.top).offset(16)
            make.centerX.equalTo(buttonView.snp.centerX).offset(80)
        }
        
        bottomPartOfCalendarView.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(menuView)
            make.height.equalTo(menuView.snp.height).dividedBy(3)
        }
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(160)
            make.height.equalTo(44)
            make.width.equalTo(120)
        }
        userButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.left.equalTo(userLabel.snp.right)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(Offsets.defaultOffset)
            make.right.equalToSuperview().inset(25)
            make.width.equalTo(240)
        }
    }

    func setupRecognizers() {
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
        
        let tapGestureRecognizerToView: UITapGestureRecognizer = {
            let tapGestureRecognizerToView = UITapGestureRecognizer(target: self, action: #selector(showButtonView))
            return tapGestureRecognizerToView
        }()

        view.addGestureRecognizer(tapGestureRecognizerToView)
        menuButton.addGestureRecognizer(tapGestureRecognizer)
        menuView.addGestureRecognizer(swipeGestureRecognizer)
        bottomPartOfCalendarView.addGestureRecognizer(tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView)
        visualShadowView.addGestureRecognizer(tapGestureRecognizerToHideCalendar)
    }

    @objc func showCalendar() {
        UIView.animate(withDuration: .defaultDuration) {
            self.visualShadowView.alpha = .darkAlpha
            self.menuView.snp.remakeConstraints { make in
                make.right.equalTo(self.view.snp.right).inset(90)
                make.height.width.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
    }

    @objc func hideCalendar() {
        UIView.animate(withDuration: .defaultDuration) {
            self.visualShadowView.alpha = 0
            self.menuView.snp.remakeConstraints { make in
                make.top.bottom.width.equalToSuperview()
                make.right.equalTo(self.view.snp.left)
            }
            self.view.layoutIfNeeded()
            Manager.shared.delegate?.updateData()
        }
    }
    
    @objc func showButtonView() {
        UIView.animate(withDuration: .defaultDuration) {
            self.buttonView.snp.remakeConstraints { make in
                make.top.equalTo(self.view.snp.bottom).inset(80)
            }
        }
        
    }
    
    @objc func hideButtonView() {
        UIView.animate(withDuration: .defaultDuration) {
            self.buttonView.snp.remakeConstraints { make in
                make.top.equalTo(self.view.snp.bottom)
            }
        }
    }

    func moveDetailViewController() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToUserViewController() {
        let vc = UserViewController()
        navigationController?.present(vc, animated: true)
    }
    
    func moveToInclineViewController() {
        let vc = InclineViewController()
        navigationController?.present(vc, animated: true)
    }
    
    func moveToExpensesViewController() {
        let vc = ExpensesViewController()
        navigationController?.present(vc, animated: true)
    }
}

extension ViewController: ManagerDelegate {
    func updateData() {
        Manager.shared.save()
        tableView.reloadData()
    }
}

extension ViewController: ViewModelDelegate {
    func updateView() {
        tableView.reloadData()
    }
}

extension ViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        Manager.shared.setDate(date: dateComponents?.date?.formatted(date: .abbreviated, time: .omitted) ?? .error)
        titleLabel.text = dateComponents?.date?.formatted(date: .abbreviated, time: .omitted)
//        Manager.shared.delegate?.updateData()
        hideCalendar()
    }
}

extension ViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        var dateComponentsForReloading: [DateComponents] = []
        dateComponentsForReloading.append(dateComponents)
        DispatchQueue.main.async {
            calendarView.reloadDecorations(forDateComponents: dateComponentsForReloading, animated: true)
        }

        let dateString = dateComponents.date?.formatted(date: .abbreviated, time: .omitted) ?? .empty
        if Manager.shared.notifications[dateString]?.isEmpty == false {
            return .default(color: .red, size: .large)
        } else {
            return nil
        }
    }
}
