//
//  FirstScreenPresenter.swift
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
    func getFilteredNotifications()-> [MyNotification]
    func addNotificationButtonPressed()
    func setDate(date: String)
    func getDate() -> String
}

final class MainScreenPresenter: IMainScreenPresenter {

    private let output: MainPresenterOutput
    var viewModel: IViewModel
    weak var view: IMainScreenController?

    init(
        output: MainPresenterOutput, viewModel: IViewModel
    ) {
        self.output = output
        self.viewModel = viewModel
    }

    func buttonPressed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            self.output.exitButtonPressed()
        }
    }
    
    func cellButtonPressed() {
        output.detailButtonPressed()
    }
    
    func userButtonPressed() {
        output.moveToUserViewController()
    }
    
    func getFilteredNotifications() -> [MyNotification] {
        let filteredNotifications = viewModel.getFilteredNotifications()
        return filteredNotifications
    }
    
    func getNotifications() -> [MyNotification] {
        let notifications = viewModel.getNotifications()
        return notifications
    }
    
    func getNotification(index: Int) -> MyNotification {
        let notification = viewModel.getNotification(index: index)
        return notification
    }
    
    func addNotificationButtonPressed() {
        viewModel.addNotificationButtonPressed()
    }
    
    func setDate(date: String) {
        Manager.shared.selectedDate = date
    }
    
    func getDate() -> String {
        Manager.shared.selectedDate
    }
}
