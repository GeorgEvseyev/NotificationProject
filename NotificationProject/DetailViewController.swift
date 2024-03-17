//
//  DetailViewController.swift
//  NotificationProject
//
//  Created by Георгий Евсеев on 17.03.24.
//

import UIKit

final class DetailViewController: UIViewController {
    let bottomPartofView: UIView = {
        let bottomPartofView = UIView()
        bottomPartofView.backgroundColor = .opaqueSeparator
        return bottomPartofView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        view.addSubview(bottomPartofView)
        makeConstraints()
        addRecognizer()
    }
    
    func makeConstraints() {
        bottomPartofView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview().dividedBy(3)
        }
    }
    
    func addRecognizer() {
        let tapRecognizer: UITapGestureRecognizer = {
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(moveViewController))
            return tapRecognizer
        }()
        bottomPartofView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func moveViewController() {
        navigationController?.popViewController(animated: true)
    }
}
