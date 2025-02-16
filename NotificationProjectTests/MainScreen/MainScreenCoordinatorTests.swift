//
//  MainScreenCoordinatorTests.swift
//  NotificationProjectTests
//
//  Created by Георгий Евсеев on 30.08.24.
//

@testable import NotificationProject
import XCTest

final class MainScreenCoordinatorTests: XCTestCase {
    
    var sut: MainScreenCoordinator!
    var navigationController: UINavigationController!

    override func setUpWithError() throws {
        navigationController = UINavigationController()
        sut = MainScreenCoordinator(navigationController: navigationController)

    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_detailButtonPressed() {
        sut.detailButtonPressed()
    }
    
    func test_moveToMenuViewController() {
        sut.moveToMenuViewController()
    }
    
    func test_moveToUserViewController() {
        sut.moveToUserViewController()
    }
    
    func test_moveToInclineViewController() {
        sut.moveToInclineViewController()
    }
    
    func test_moveToExpensesViewController() {
        sut.moveToExpensesViewController()
    }
    
    func test_detailScreenBackButtonPressed() {
        sut.detailScreenBackButtonPressed()
    }
    
    func test_menuScreenBackButtonPressed() {
        sut.menuScreenBackButtonPressed()
    }
    
    func test_userScreenBackButtonPressed() {
        sut.userScreenBackButtonPressed()
    }
    
    func test_inclineScreenBackButtonPressed() {
        sut.inclineScreenBackButtonPressed()
    }
    
    func test_expensesScreenBackButtonPressed() {
        sut.expensesScreenBackButtonPressed()
    }
    

}
