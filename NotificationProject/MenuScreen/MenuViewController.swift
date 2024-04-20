//
//  MenuViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 7.12.23.
//

import Foundation
import UIKit


protocol IMenuScreenController: AnyObject {
    func setLabelText(_ text: String)
}

class MenuScreenViewController: UIViewController {
    
    private let presenter: IMenuScreenPresenter

    init(presenter: IMenuScreenPresenter) {
        self.presenter = presenter

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }
}

extension MenuScreenViewController: IMenuScreenController {
    func setLabelText(_ text: String) {

    }
}
