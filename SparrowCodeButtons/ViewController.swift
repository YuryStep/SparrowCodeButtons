//
//  ViewController.swift
//  SparrowCodeButtons
//
//  Created by Юрий Степанчук on 06.11.2023.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var firstButton = CustomButton(text: "First Button")
    private lazy var secondMediumButton = CustomButton(text: "Second Medium Button")
    private lazy var thirdButton = CustomButton(text: "Third")

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setTransition()
    }

    private func setupView() {
        view.addSubview(firstButton)
        view.addSubview(secondMediumButton)
        view.addSubview(thirdButton)

        NSLayoutConstraint.activate([
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            secondMediumButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            firstButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor , multiplier: 1),
            secondMediumButton.topAnchor.constraint(equalToSystemSpacingBelow: firstButton.bottomAnchor, multiplier: 1),
            thirdButton.topAnchor.constraint(equalToSystemSpacingBelow: secondMediumButton.bottomAnchor, multiplier: 1)
        ])
    }

    private func setTransition() {
        thirdButton.addTarget(self, action: #selector(thirdButtonTapped), for: .touchUpInside)
    }

    @objc private func thirdButtonTapped() {
        showModalController()
    }

    private func showModalController() {
        let modalViewController = UIViewController()
        modalViewController.view.backgroundColor = .white
        let navigationController = UINavigationController(rootViewController: modalViewController)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true, completion: nil)
    }

}

