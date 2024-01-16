//
//  ViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 4.12.23.
//

import SnapKit
import UIKit

protocol ConstraintsDelegate: AnyObject {
    func updateConstraints(index: Int)
}

protocol ViewControllerDelegate: AnyObject {
    func addNotification()
    func addNotificationText(index: Int, text: String)
}

class ViewController: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    weak var cellHeightDelegate: ConstraintsDelegate?

    weak var delegate: ViewControllerDelegate?

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
        
        Manager.shared.delegate = self
        

        
        if let savedNotifications = Manager.shared.defaults.object(forKey: "notifications") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                Manager.shared.notifications = try jsonDecoder.decode([Notification].self, from: savedNotifications)
            } catch {
                print("Failed to load")
            }
        }

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
        view.addSubview(calendarView)
        calendarView.addSubview(bottomPartOfCalendarView)
        menuButton.addGestureRecognizer(tapGestureRecognizer)
        calendarView.addGestureRecognizer(swipeGestureRecognizer)
        bottomPartOfCalendarView.addGestureRecognizer(tapGestureRecognizerToHideCalendarForBottomPartOfCalenarView)
        visualShadowView.addGestureRecognizer(tapGestureRecognizerToHideCalendar)
        makeConstraints()
    }

    func setUpAddNotificationButton() {
        let action = UIAction { _ in
            self.addNotification()
        }
        addNotificationButton.addAction(action, for: .touchUpInside)
        view.addSubview(addNotificationButton)
    }

    func addNotification() {
        Manager.shared.addNotification()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Manager.shared.notifications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditableTableViewCell.identifier, for: indexPath) as? EditableTableViewCell else { return EditableTableViewCell() }

        cell.configure(with: indexPath.row)
        cell.configureButton {
            cell.prepareForReuse()
            Manager.shared.toggleButtonImage(index: indexPath.row)
            Manager.shared.delegate?.updateData()
        }
        cellHeightDelegate = cell
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
}

extension ViewController: ManagerDelegate {
    func updateData() {
        tableView.reloadData()
    }
}
