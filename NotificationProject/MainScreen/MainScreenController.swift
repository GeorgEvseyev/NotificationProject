//
//  FirstScreenController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import UIKit
import SnapKit

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
    static let visualShadowViewInset: CGFloat = 90
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
    func reloadTable()
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
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .separator
        return tableView
    }()

    let menuView: UIView = {
        let menuView = UIView()
        menuView.backgroundColor = .secondarySystemBackground
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
        visualShadowView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        visualShadowView.alpha = .darkAlpha
        return visualShadowView
    }()

    let bottomPartOfCalendarView: UIView = {
        let bottomPartOfCalendarView = UIView()
        bottomPartOfCalendarView.backgroundColor = .secondarySystemBackground
        return bottomPartOfCalendarView
    }()

    let topImageView: UIView = {
        let imageView = UIView()
        imageView.backgroundColor = .systemGroupedBackground
        return imageView
    }()

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.text = .empty
        return titleLabel
    }()

    let menuButton: UIButton = {
        var conf = UIButton.Configuration.tinted()
        conf.image = UIImage(systemName: "calendar")
        conf.cornerStyle = .capsule
        return UIButton(configuration: conf)
    }()

    let editButton: UIButton = {
        var conf = UIButton.Configuration.tinted()
        conf.image = UIImage(systemName: "slider.horizontal.3")
        conf.cornerStyle = .capsule
        return UIButton(configuration: conf)
    }()

    let addNotificationButton: UIButton = {
        var conf = UIButton.Configuration.filled()
        conf.image = UIImage(systemName: "plus")
        conf.cornerStyle = .capsule
        conf.baseBackgroundColor = .tintColor
        conf.baseForegroundColor = .white
        return UIButton(configuration: conf)
    }()

    let userLabel: UILabel = {
        let userLabel = UILabel()
        userLabel.text = "Username"
        userLabel.textAlignment = .right
        userLabel.textColor = .secondaryLabel
        userLabel.font = .preferredFont(forTextStyle: .subheadline)
        userLabel.adjustsFontForContentSizeCategory = true
        return userLabel
    }()

    let userButton: UIButton = {
        let userButton = UIButton()
        userButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return userButton
    }()

    let inclineButton: UIButton = {
        var conf = UIButton.Configuration.tinted()
        conf.image = UIImage(systemName: "arrow.down.right.circle")
        conf.title = "Incomes"
        conf.imagePadding = 8
        conf.cornerStyle = .capsule
        return UIButton(configuration: conf)
    }()

    let inclineLabel: UILabel = {
        let inclineLabel = UILabel()
        inclineLabel.text = "Incomes"
        inclineLabel.textColor = .secondaryLabel
        inclineLabel.font = .preferredFont(forTextStyle: .caption1)
        inclineLabel.adjustsFontForContentSizeCategory = true
        return inclineLabel
    }()

    let expensesButton: UIButton = {
        var conf = UIButton.Configuration.tinted()
        conf.image = UIImage(systemName: "arrow.up.left.circle")
        conf.title = "Expenses"
        conf.imagePadding = 8
        conf.cornerStyle = .capsule
        return UIButton(configuration: conf)
    }()

    let expensesLabel: UILabel = {
        let expensesLabel = UILabel()
        expensesLabel.text = "Expenses"
        expensesLabel.textColor = .secondaryLabel
        expensesLabel.font = .preferredFont(forTextStyle: .caption1)
        expensesLabel.adjustsFontForContentSizeCategory = true
        return expensesLabel
    }()

    private let presenter: IMainScreenPresenter
    private let storageService: IStorageService

    init(presenter: IMainScreenPresenter, storageService: IStorageService) {
        self.presenter = presenter
        self.storageService = storageService
        

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Загружаем уведомления через сервис или менеджер
        Manager.shared.loadNotifications()

        presenter.setDate(Date().formatted(date: .abbreviated, time: .omitted))
        titleLabel.text = presenter.getDate()

        tableView.register(EditableTableViewCell.self,
                           forCellReuseIdentifier: EditableTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self

        let selectionBehavior = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selectionBehavior
        calendarView.delegate = self

        setupUI()
        
        addNotificationButton.accessibilityLabel = "Добавить напоминание"
        addNotificationButton.accessibilityHint = "Открывает форму создания нового напоминания"

        menuButton.accessibilityLabel = "Календарь"
        menuButton.accessibilityHint = "Показать панель календаря"

        editButton.accessibilityLabel = "Редактировать"
        editButton.accessibilityHint = "Переключить режим редактирования списка"

        inclineButton.accessibilityLabel = "Доходы"
        expensesButton.accessibilityLabel = "Расходы"
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
                make.right.equalTo(self.view.snp.right).inset(CGFloat.visualShadowViewInset)
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
        }

        presenter.setDate(presenter.getDate())
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
        print(1)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension MainScreenController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.getFilteredNotifications().count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: EditableTableViewCell.identifier,
            for: indexPath
        ) as? EditableTableViewCell else {
            return UITableViewCell()
        }

        let notification = presenter.getFilteredNotifications()[indexPath.row]
        cell.configure(notification: notification)

        // чекбокс
        cell.configureButton { [weak self, weak tableView] in
            self?.presenter.toggleNotification(id: notification.id)
            tableView?.reloadRows(at: [indexPath], with: .automatic) // точечное обновление
        }

        // изменение текста
        cell.configureTextChanged { [weak self] newText in
            self?.presenter.updateNotificationText(id: notification.id, text: newText)
            // ⚠️ без reloadData(), чтобы не сбивать ввод
        }

        // кнопка деталей
        cell.configureDetailButton {
            print("Открыть детали для \(notification.text)")
        }

        return cell
    }

    // удаление
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let notification = presenter.getFilteredNotifications()[indexPath.row]
            presenter.deleteNotification(id: notification.id)

            // теперь можно безопасно удалить строку с анимацией
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // перемещение
    func tableView(_ tableView: UITableView,
                   canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }

    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        presenter.moveNotification(from: sourceIndexPath.row,
                                   to: destinationIndexPath.row)
        // reloadData() не нужен — данные уже обновлены
    }

    func editTableView() {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
}

// MARK: - Calendar
extension MainScreenController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate,
                       didSelectDate dateComponents: DateComponents?) {
        let date = dateComponents?.date?.formatted(date: .abbreviated, time: .omitted) ?? .error
        presenter.setDate(date)
        titleLabel.text = date
        tableView.reloadData()
        hideCalendar()
    }
}

extension MainScreenController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView,
                      decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        let dateString = dateComponents.date?.formatted(date: .abbreviated, time: .omitted) ?? .empty
        if presenter.hasNotifications(for: dateString) {
            return .default(color: .red, size: .large)
        } else {
            return nil
        }
    }
}

// MARK: - IMainScreenController
extension MainScreenController: IMainScreenController {
    func setLabelText(_ text: String) {
        self.title = text
    }

    func reloadTable() {
        tableView.reloadData()
    }
}

// MARK: - UIGestureRecognizerDelegate
extension MainScreenController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: menuView) == true {
            return false
        }
        return true
    }
}


