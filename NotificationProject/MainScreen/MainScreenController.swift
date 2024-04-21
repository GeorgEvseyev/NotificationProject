//
//  FirstScreenController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit

private extension CGFloat {
    static let height: CGFloat = 44
    static let cornerRadius: CGFloat = 30
    static let darkAlpha: CGFloat = 0.4
    static let standardAlpha: CGFloat = 1.0
    static let nonAlpha: CGFloat = 0
    static let standardPointSize: CGFloat = 44
    static let standardButtonSize: CGFloat = 44
    static let largeButtonSize: CGFloat = 60
    static let font: CGFloat = 24
    static let heightTopImageView: CGFloat = 90
    static let offsetForUserLabel: CGFloat = 60
    static let rightInsetForUserLabel: CGFloat = 160
    static let calendarWidth: CGFloat = 240
    static let defaultOffset: CGFloat = 25
    static let minimumOffset: CGFloat = 10
    static let smallOffset: CGFloat = 20
    static let maximumInset: CGFloat = 50
    static let buttonOffset: CGFloat = 80
    static let thirdOfHeight: CGFloat = 3
    static let menuViewLabelHeight: CGFloat = 120
    static let insetForUserButton: CGFloat = 60
    static let expensesButtonInset: CGFloat = 80
}

private extension String {
    static let empty: String = ""
    static let error: String = "Error"
}

private extension Double {
    static let defaultDuration: Double = 0.3
    static let longDuration: Double = 1
}

protocol IMainScreenController: AnyObject {
    func setLabelText(_ text: String)
}

final class MainScreenController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }

    private var isButtonViewVisible = false

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
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.backgroundColor = .gray
        buttonView.alpha = .standardAlpha
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

    private let menuButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: .standardPointSize, weight: .regular, scale: .default)
        button.setImage(UIImage(systemName: "line.horizontal.3", withConfiguration: largeConfig), for: .normal)
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
        let largeConfig = UIImage.SymbolConfiguration(pointSize: .standardPointSize, weight: .regular, scale: .default)
        button.setImage(UIImage(systemName: "plus.circle", withConfiguration: largeConfig), for: .normal)
        return button
    }()

    let userLabel: UILabel = {
        let userLabel = UILabel()
        userLabel.text = "Username"
        userLabel.textAlignment = .right
        return userLabel
    }()

    let userButton: UIButton = {
        let userButton = UIButton()
        userButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return userButton
    }()

    let inclineButton: UIButton = {
        let inclineButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: .standardPointSize, weight: .regular, scale: .default)
        inclineButton.setImage(UIImage(systemName: "arrow.down.right.and.arrow.up.left.circle", withConfiguration: largeConfig), for: .normal)
        return inclineButton
    }()

    let inclineLabel: UILabel = {
        let inclineLabel = UILabel()
        inclineLabel.text = "Incomes"
        return inclineLabel
    }()

    let expensesButton: UIButton = {
        let expensesButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: .standardPointSize, weight: .regular, scale: .default)
        expensesButton.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right.circle", withConfiguration: largeConfig), for: .normal)
        return expensesButton
    }()

    let expensesLabel: UILabel = {
        let expensesLabel = UILabel()
        expensesLabel.text = "Expenses"
        return expensesLabel
    }()

    private let presenter: IMainScreenPresenter

    init(presenter: IMainScreenPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        StorageService().getNotification()
        presenter.setDate(date: Date().formatted(date: .abbreviated, time: .omitted))
        titleLabel.text = presenter.getDate()

        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        let selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selectionBehavior
        calendarView.delegate = self

        setupUI()
    }

    private func setupUI() {
        let tapGestureRecognizerToView: UITapGestureRecognizer = {
            let tapGestureRecognizerToView = UITapGestureRecognizer(target: self, action: #selector(toggleButtonView))
            tapGestureRecognizerToView.delegate = self
            return tapGestureRecognizerToView
        }()
        view.addGestureRecognizer(tapGestureRecognizerToView)

        view.addSubview(topImageView)
        topImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(CGFloat.heightTopImageView)
        }

        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topImageView.snp.bottom)
        }

        view.addSubview(addNotificationButton)
        let addNotificationButtonAction = UIAction { _ in
            self.presenter.addNotificationButtonPressed()
            self.tableView.reloadData()
        }
        addNotificationButton.addAction(addNotificationButtonAction, for: .touchUpInside)
        addNotificationButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Insets.maximumInset)
            make.bottom.equalToSuperview().inset(Insets.maximumInset)
            make.height.width.equalTo(CGFloat.largeButtonSize)
        }

        view.addSubview(menuButton)
        menuButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.minimumOffset)
            make.bottom.equalTo(topImageView.snp.bottom).inset(Offsets.smallOffset)
            make.height.width.equalTo(CGFloat.standardButtonSize)
        }
        let tapGestureRecognizer: UITapGestureRecognizer = {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showCalendar))
            return tapGestureRecognizer
        }()
        menuButton.addGestureRecognizer(tapGestureRecognizer)

        view.addSubview(editButton)
        let action = UIAction { _ in
            self.editTableView()
        }
        editButton.addAction(action, for: .touchUpInside)
        editButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Insets.minimumInset)
            make.bottom.equalTo(topImageView.snp.bottom).inset(Insets.minimumInset)
            make.height.width.equalTo(CGFloat.standardButtonSize)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(topImageView.snp.centerX)
            make.bottom.equalTo(topImageView.snp.bottom).inset(Insets.minimumInset)
        }

        view.addSubview(visualShadowView)
        visualShadowView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        visualShadowView.alpha = .nonAlpha
        let tapGestureRecognizerToHideCalendar: UITapGestureRecognizer = {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideCalendar))
            return tapGestureRecognizer
        }()
        visualShadowView.addGestureRecognizer(tapGestureRecognizerToHideCalendar)

        view.addSubview(menuView)
        menuView.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.right.equalTo(view.snp.left)
        }
        let swipeGestureRecognizer: UISwipeGestureRecognizer = {
            let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(hideCalendar))
            swipeRecognizer.direction = .left
            return swipeRecognizer
        }()
        menuView.addGestureRecognizer(swipeGestureRecognizer)

        menuView.addSubview(bottomPartOfCalendarView)
        bottomPartOfCalendarView.snp.makeConstraints { make in
            make.bottom.left.right.equalTo(menuView)
            make.height.equalTo(menuView.snp.height).dividedBy(CGFloat.thirdOfHeight)
        }
        let tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView: UITapGestureRecognizer = {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideCalendar))
            return tapGestureRecognizer
        }()
        bottomPartOfCalendarView.addGestureRecognizer(tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView)

        menuView.addSubview(userLabel)
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat.offsetForUserLabel)
            make.right.equalToSuperview().inset(CGFloat.rightInsetForUserLabel)
            make.height.equalTo(CGFloat.standardButtonSize)
            make.width.equalTo(CGFloat.menuViewLabelHeight)
        }

        menuView.addSubview(userButton)
        let userButtonAction = UIAction { _ in
            self.presenter.userButtonPressed()
        }
        userButton.addAction(userButtonAction, for: .touchUpInside)
        userButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(CGFloat.insetForUserButton)
            make.left.equalTo(userLabel.snp.right)
            make.height.equalTo(CGFloat.standardButtonSize)
            make.width.equalTo(CGFloat.standardButtonSize)
        }

        menuView.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(CGFloat.defaultOffset)
            make.right.equalToSuperview().inset(CGFloat.defaultOffset)
            make.width.equalTo(CGFloat.calendarWidth)
        }

        view.addSubview(buttonView)
        buttonView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.bottom)
        }

        buttonView.addSubview(inclineButton)
        let inclineButtonAction = UIAction { _ in
            self.moveToInclineViewController()
        }
        inclineButton.addAction(inclineButtonAction, for: .touchUpInside)
        inclineButton.snp.makeConstraints { make in
            make.height.width.equalTo(CGFloat.standardButtonSize)
            make.top.equalTo(buttonView.snp.top).offset(Offsets.defaultOffset)
            make.left.equalTo(topImageView.snp.left).offset(CGFloat.buttonOffset)
        }

        buttonView.addSubview(inclineLabel)
        inclineLabel.snp.makeConstraints { make in
            make.top.equalTo(inclineButton.snp.bottom)
            make.centerX.equalTo(inclineButton.snp.centerX)
        }

        buttonView.addSubview(expensesButton)
        let expensesButtonAction = UIAction { _ in
            self.moveToExpensesViewController()
        }
        expensesButton.addAction(expensesButtonAction, for: .touchUpInside)
        expensesButton.snp.makeConstraints { make in
            make.height.width.equalTo(CGFloat.standardButtonSize)
            make.top.equalTo(buttonView.snp.top).offset(Insets.defaultInset)
            make.right.equalTo(topImageView.snp.right).inset(CGFloat.expensesButtonInset)
        }

        buttonView.addSubview(expensesLabel)
        expensesLabel.snp.makeConstraints { make in
            make.top.equalTo(expensesButton.snp.bottom)
            make.centerX.equalTo(expensesButton.snp.centerX)
        }
    }

    func buttonPressed() {
        presenter.buttonPressed()
    }

    func addNotificationButtonPressed() {
    }

    func moveToUserViewController() {
    }

    func moveToInclineViewController() {
    }

    func moveToExpensesViewController() {
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
            self.visualShadowView.alpha = .nonAlpha
            self.menuView.snp.remakeConstraints { make in
                make.top.bottom.width.equalToSuperview()
                make.right.equalTo(self.view.snp.left)
            }
            self.view.layoutIfNeeded()
            Manager.shared.delegate?.updateData()
        }
    }

    @objc func toggleButtonView() {
        if isButtonViewVisible == false {
            showButtonView()
        } else {
            hideButtonView()
        }
        isButtonViewVisible.toggle()
    }

    @objc func showButtonView() {
        UIView.animate(withDuration: .defaultDuration) {
            self.buttonView.snp.makeConstraints { make in
                make.width.height.equalToSuperview()
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.snp.bottom).inset(80)
                self.buttonView.alpha = 1
            }
            self.addNotificationButton.snp.remakeConstraints { make in
                make.right.equalToSuperview().inset(Insets.maximumInset)
                make.bottom.equalToSuperview().inset(130)
                make.height.width.equalTo(CGFloat.largeButtonSize)
                self.addNotificationButton.alpha = .nonAlpha
                self.addNotificationButton.isEnabled = false
            }
            self.view.layoutIfNeeded()
        }
    }

    @objc func hideButtonView() {
        UIView.animate(withDuration: .defaultDuration) {
            self.buttonView.snp.remakeConstraints { make in
                make.width.height.equalToSuperview()
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.snp.bottom)
                self.buttonView.alpha = .nonAlpha
            }
            self.addNotificationButton.snp.remakeConstraints { make in
                make.right.equalToSuperview().inset(Insets.maximumInset)
                make.bottom.equalToSuperview().inset(Insets.maximumInset)
                make.height.width.equalTo(CGFloat.largeButtonSize)
                self.addNotificationButton.alpha = .standardAlpha
                self.addNotificationButton.isEnabled = true
            }
            self.view.layoutIfNeeded()
        }
    }
}

extension MainScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getFilteredNotifications().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.setEditing(true, animated: false)
        cell.cellTextView.delegate = cell

        cell.configure(notification: presenter.getNotification(index: indexPath.row), index: indexPath.row)
        cell.configureButton {
            Manager.shared.toggleNotificationState(notification: self.presenter.getNotification(index: indexPath.row))
            self.tableView.reloadData()
        }
        cell.configureDetailButton {
            self.presenter.cellButtonPressed()
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let notification = presenter.getFilteredNotifications()[indexPath.row]
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
}

extension MainScreenController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        Manager.shared.setDate(date: dateComponents?.date?.formatted(date: .abbreviated, time: .omitted) ?? .error)
        titleLabel.text = dateComponents?.date?.formatted(date: .abbreviated, time: .omitted)
        tableView.reloadData()
        hideCalendar()
    }
}

extension MainScreenController: UICalendarViewDelegate {
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

extension MainScreenController: IMainScreenController {
    func setLabelText(_ text: String) {
    }
}

extension MainScreenController: UIGestureRecognizerDelegate {
    // menuView without gesturerecognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: menuView) == true {
            return false
        }
        return true
    }
}
