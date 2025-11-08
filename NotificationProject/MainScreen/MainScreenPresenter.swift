//
//  MainScreenPresenter.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import Foundation

protocol IMainScreenPresenter {
    func buttonPressed()
    func cellButtonPressed()
    func userButtonPressed()
    func getNotifications() -> [MyNotification]
    func getNotification(index: Int) -> MyNotification
    func getFilteredNotifications() -> [MyNotification]
    func addNotificationButtonPressed()
    func setDate(_ date: String)
    func getDate() -> String
    
    // Новые методы (работа через id)
    func toggleNotification(id: UUID)
    func updateNotificationText(id: UUID, text: String)
    func deleteNotification(id: UUID)
    
    func hasNotifications(for date: String) -> Bool
    func moveNotification(from sourceIndex: Int, to destinationIndex: Int)
}

final class MainScreenPresenter: IMainScreenPresenter {
    private let output: MainPresenterOutput
    private let viewModel: IViewModel
    private let manager: IManager
    weak var view: IMainScreenController?

    init(
        output: MainPresenterOutput,
        viewModel: IViewModel,
        manager: IManager = Manager.shared
    ) {
        self.output = output
        self.viewModel = viewModel
        self.manager = manager
    }

    // MARK: - Навигация
    func buttonPressed() { }
    func cellButtonPressed() { output.detailButtonPressed() }
    func userButtonPressed() { output.moveToUserViewController() }

    // MARK: - Данные
    func getFilteredNotifications() -> [MyNotification] { viewModel.getFilteredNotifications() }
    func getNotifications() -> [MyNotification] { viewModel.getNotifications() }
    func getNotification(index: Int) -> MyNotification { viewModel.getNotification(index: index) }

    func addNotificationButtonPressed() {
        viewModel.addNotificationButtonPressed()
        view?.reloadTable()
    }

    func setDate(_ date: String) {
        manager.setDate(date: date)
        view?.reloadTable()
    }

    func getDate() -> String { manager.getDate() }

    // MARK: - Новая логика
    func toggleNotification(id: UUID) {
        manager.toggleNotificationState(id: id)
        view?.reloadTable()
    }

    func updateNotificationText(id: UUID, text: String) {
        manager.updateNotificationText(id: id, newText: text)
        // ⚠️ reloadTable не нужен, иначе будет сбиваться ввод
    }

    func deleteNotification(id: UUID) {
        manager.removeNotification(id: id)
    }


    func hasNotifications(for date: String) -> Bool {
        return manager.hasNotifications(for: date)
    }

    func moveNotification(from sourceIndex: Int, to destinationIndex: Int) {
        let date = manager.getDate()
        manager.moveNotification(from: sourceIndex, to: destinationIndex, for: date)
        view?.reloadTable()
    }
}




////
////  FirstScreenPresenter.swift
////  NotificationProject
////
////  Created by Георгий Евсеев on 13.04.24.
////
//
//import Foundation
//
//protocol IMainScreenPresenter {
//    func buttonPressed()
//    func cellButtonPressed()
//    func userButtonPressed()
//    func getNotifications() -> [MyNotification]
//    func getNotification(index: Int) -> MyNotification
//    func getFilteredNotifications()-> [MyNotification]
//    func addNotificationButtonPressed()
//    func setDate(date: String)
//    func getDate() -> String
//}
//
//final class MainScreenPresenter: IMainScreenPresenter {
//
//    private let output: MainPresenterOutput
//    var viewModel: IViewModel
//    weak var view: IMainScreenController?
//
//    init(
//        output: MainPresenterOutput, viewModel: IViewModel
//    ) {
//        self.output = output
//        self.viewModel = viewModel
//    }
//
//    func buttonPressed() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
////            self.output.exitButtonPressed()
//        }
//    }
//    
//    func cellButtonPressed() {
//        output.detailButtonPressed()
//    }
//    
//    func userButtonPressed() {
//        output.moveToUserViewController()
//    }
//    
//    func getFilteredNotifications() -> [MyNotification] {
//        let filteredNotifications = viewModel.getFilteredNotifications()
//        return filteredNotifications
//    }
//    
//    func getNotifications() -> [MyNotification] {
//        let notifications = viewModel.getNotifications()
//        return notifications
//    }
//    
//    func getNotification(index: Int) -> MyNotification {
//        let notification = viewModel.getNotification(index: index)
//        return notification
//    }
//    
//    func addNotificationButtonPressed() {
//        viewModel.addNotificationButtonPressed()
//    }
//    
//    func setDate(date: String) {
//        Manager.shared.selectedDate = date
//    }
//    
//    func getDate() -> String {
//        Manager.shared.selectedDate
//    }
//}
