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
    func getNotifications() -> [Notification]
    func getNotification(index: Int) -> Notification
    func getFilteredNotifications()-> [Notification]
    func addNotificationButtonPressed()
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
//        detailButtonPressed()
    }
    
    func userButtonPressed() {
        output.moveToUserViewController()
    }
    
    func getFilteredNotifications() -> [Notification] {
        let filteredNotifications = viewModel.getFilteredNotifications()
        return filteredNotifications
    }
    
    func getNotifications() -> [Notification] {
        let notifications = viewModel.getNotifications()
        return notifications
    }
    
    func getNotification(index: Int) -> Notification {
        let notification = viewModel.getNotification(index: index)
        return notification
    }
    
    func addNotificationButtonPressed() {
        viewModel.addNotificationButtonPressed()
    }
}
