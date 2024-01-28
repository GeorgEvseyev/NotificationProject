//
//  NetWorkSetvice.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 28.01.24.
//

import Foundation

class NetworkService {
    func sendRequest(completion: @escaping (Notification) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            completion(Notification(text: "Some Text", state: true))
        }
    }
}
