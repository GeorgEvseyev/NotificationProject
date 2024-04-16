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
    static let font: CGFloat = 24
}

private extension String {
    static let empty: String = ""
    static let error: String = "Error"
}

private extension Double {
    static let defaultDuration: Double = 0.3
    static let longDuration: Double = 1
}

protocol IFirstScreenController: AnyObject {
    func setLabelText(_ text: String)
}

final class FirstScreenController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

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
        buttonView.alpha = 1.0
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
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 44, weight: .regular, scale: .default)
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
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 44, weight: .regular, scale: .default)
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
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 44, weight: .regular, scale: .default)
        inclineButton.setImage(UIImage(systemName: "arrow.down.right.and.arrow.up.left.circle", withConfiguration: largeConfig), for: .normal)
        return inclineButton
    }()
    
    let inclineLabel: UILabel = {
       let inclineLabel = UILabel()
        inclineLabel.text = "Incline"
        return inclineLabel
    }()

    let expensesButton: UIButton = {
        let expensesButton = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 44, weight: .regular, scale: .default)
        expensesButton.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right.circle", withConfiguration: largeConfig), for: .normal)
        return expensesButton
    }()
    
    let expensesLabel: UILabel = {
       let expensesLabel = UILabel()
        expensesLabel.text = "Expenses"
        return expensesLabel
    }()


    private let presenter: IFirstScreenPresenter

    init(presenter: IFirstScreenPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(EditableTableViewCell.self, forCellReuseIdentifier: EditableTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        calendarView.delegate = self
        
        setupUI()
    }

    private func setupUI() {
//        view.backgroundColor = .white
//
//        view.addSubview(nextButton)
//        let action = UIAction { _ in
//            self.buttonPressed()
//        }
//        nextButton.addAction(action, for: .touchUpInside)
//
//        nextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
//        nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64).isActive = true
//        nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        nextButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
//
//        view.addSubview(label)
//        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
//        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 64).isActive = true
//        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        label.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        let tapGestureRecognizerToView: UITapGestureRecognizer = {
            let tapGestureRecognizerToView = UITapGestureRecognizer(target: self, action: #selector(toggleButtonView))
            tapGestureRecognizerToView.delegate = self
            return tapGestureRecognizerToView
        }()
        view.addGestureRecognizer(tapGestureRecognizerToView)
        
        view.addSubview(topImageView)
        topImageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(90)
        }


        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topImageView.snp.bottom)
        }
        
        view.addSubview(addNotificationButton)
        let addNotificationButtonAction = UIAction { _ in
            self.viewModel.addNotificationButtonPressed()
        }
        addNotificationButton.addAction(addNotificationButtonAction, for: .touchUpInside)
        addNotificationButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(50)
            make.height.width.equalTo(60)
        }
        
        view.addSubview(menuButton)
        menuButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.minimumOffset)
            make.bottom.equalTo(topImageView.snp.bottom).inset(Offsets.smallOffset)
            make.height.width.equalTo(44)
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
            make.height.width.equalTo(44)
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
        visualShadowView.alpha = 0
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
            make.height.equalTo(menuView.snp.height).dividedBy(3)
        }
        let tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView: UITapGestureRecognizer = {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideCalendar))
            return tapGestureRecognizer
        }()
        bottomPartOfCalendarView.addGestureRecognizer(tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView)
        
        menuView.addSubview(userLabel)
        userLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.right.equalToSuperview().inset(160)
            make.height.equalTo(44)
            make.width.equalTo(120)
        }
        
        menuView.addSubview(userButton)
        let userButtonAction = UIAction { _ in
            self.moveToUserViewController()
        }
        userButton.addAction(userButtonAction, for: .touchUpInside)
        userButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.left.equalTo(userLabel.snp.right)
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        
        menuView.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(userLabel.snp.bottom).offset(Offsets.defaultOffset)
            make.right.equalToSuperview().inset(25)
            make.width.equalTo(240)
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
            make.height.width.equalTo(44)
            make.top.equalTo(buttonView.snp.top).offset(16)
            make.left.equalTo(topImageView.snp.left).offset(80)
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
            make.height.width.equalTo(44)
            make.top.equalTo(buttonView.snp.top).offset(16)
            make.right.equalTo(topImageView.snp.right).inset(80)
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
    
    func editTableView() {
        
    }
    
    func addNotificationButtonPressed() {
        
    }
    
    func moveToUserViewController() {
        
    }
    
    func moveToInclineViewController() {
        
    }
    
    func moveToExpensesViewController() {
        
    }
    
    @objc func toggleButtonView() {
        
    }
    
    @objc func showCalendar() {
        
    }
    
    @objc func hideCalendar() {
        
    }
}

extension FirstScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getFilteredNotifications().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }
        cell.setEditing(true, animated: false)
        cell.cellTextView.delegate = cell
        
        cell.configure(notification: viewModel.getNotification(index: indexPath.row), index: indexPath.row)
        cell.configureButton {
            Manager.shared.toggleNotificationState(notification: self.viewModel.getNotification(index: indexPath.row))
            self.tableView.reloadData()
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
}

extension FirstScreenController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        Manager.shared.setDate(date: dateComponents?.date?.formatted(date: .abbreviated, time: .omitted) ?? .error)
        titleLabel.text = dateComponents?.date?.formatted(date: .abbreviated, time: .omitted)
//        Manager.shared.delegate?.updateData()
        hideCalendar()
    }
}

extension FirstScreenController: UICalendarViewDelegate {
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

extension FirstScreenController: IFirstScreenController {
    func setLabelText(_ text: String) {
        label.text = text
    }
}

extension FirstScreenController: UIGestureRecognizerDelegate {
    //menuView without gesturerecognizer
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: menuView) == true {
            return false
        }
        return true
    }
}


