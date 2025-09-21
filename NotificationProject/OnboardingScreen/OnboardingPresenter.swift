//
//  OnboardingPresenter.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 21.09.25.
//

import Foundation

protocol IOnboardingPresenter {
    func continueButtonPressed()
}

protocol OnboardingPresenterOutput: AnyObject {
    func onboardingDidFinish()
}

protocol IOnboardingView: AnyObject {
    // сюда можно добавить методы для обновления UI, если появятся
}


final class OnboardingPresenter: IOnboardingPresenter {
    private weak var view: IOnboardingView?
    private weak var output: OnboardingPresenterOutput?

    init(output: OnboardingPresenterOutput) {
        self.output = output
    }

    func attachView(_ view: IOnboardingView) {
        self.view = view
    }

    func continueButtonPressed() {
        output?.onboardingDidFinish()
    }
}
