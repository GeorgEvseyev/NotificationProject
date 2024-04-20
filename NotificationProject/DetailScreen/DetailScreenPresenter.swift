//
//  DetailPresenter.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 13.04.24.
//

import Foundation

protocol IDetailScreenPresenter {
    func buttonPressed()
}

final class DetailScreenPresenter: IDetailScreenPresenter {
    
    private let output: DetailScreenPresenterOutput
    weak var view: IDetailScreenController?

    init(output: DetailScreenPresenterOutput) {
        self.output = output
    }

    func buttonPressed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.output.detailScreenBackButtonPressed()
        }
    }
}
