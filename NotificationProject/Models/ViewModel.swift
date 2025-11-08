//
//  ViewModel.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 28.01.24.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func updateView()
}

protocol IViewModel: AnyObject {
    func getNotifications() -> [MyNotification]
    func getNotification(index: Int) -> MyNotification
    func getFilteredNotifications() -> [MyNotification]
    func addNotificationButtonPressed()
}

final class ViewModel: IViewModel {
    weak var delegate: ViewModelDelegate?

    // MARK: - Получение всех заметок за выбранную дату
    func getNotifications() -> [MyNotification] {
        Manager.shared.notifications[Manager.shared.getDate()] ?? []
    }

    // MARK: - Получение конкретной заметки
    func getNotification(index: Int) -> MyNotification {
        getNotifications()[index]
    }

    // MARK: - Фильтрация и сортировка
    func getFilteredNotifications() -> [MyNotification] {
        let notifications = Manager.shared.notifications[Manager.shared.getDate()] ?? []
        return notifications.sorted { n1, n2 in
            if n1.state == n2.state {
                // если оба выполнены или оба активные → сортируем по тексту
                return n1.text.localizedCaseInsensitiveCompare(n2.text) == .orderedAscending
            }
            // активные (false) всегда выше выполненных (true)
            return !n1.state && n2.state
        }
    }

    // MARK: - Добавление новой заметки
    func addNotificationButtonPressed() {
        let notification = MyNotification(
            text: "",
            date: Manager.shared.getDate(),
            number: Manager.shared.getNumber(),
            state: false // новая заметка всегда активная
        )
        Manager.shared.addNotification(notification: notification)
        delegate?.updateView()
    }
}
