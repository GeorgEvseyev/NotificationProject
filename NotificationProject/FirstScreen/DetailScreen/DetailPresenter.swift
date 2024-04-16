//
//  DetailPresenter.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import Foundation

protocol IDetailPresenter {
    func buttonPressed()
}

final class DetailPresenter: IDetailPresenter {
    
    private let output: DetailPresenterOutput
    weak var view: IDetailController?

    init(output: DetailPresenterOutput) {
        self.output = output
    }

    func buttonPressed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output.backButtonPressed()
        }
    }
}
