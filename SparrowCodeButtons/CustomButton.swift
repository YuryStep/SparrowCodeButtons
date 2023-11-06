//
//  CustomButton.swift
//  SparrowCodeButtons
//
//  Created by Юрий Степанчук on 06.11.2023.
//

import UIKit

final class CustomButton: UIButton {
    private struct Constants {
        static let imageName = "arrow.right.circle.fill"
        static let fontSize: CGFloat = 16
        static let verticalContentPadding: CGFloat = 10
        static let horizontalContentPadding: CGFloat = 14
        static let imagePadding: CGFloat = 8
    }

    private var animator: UIViewPropertyAnimator?

    init(text: String) {
        super.init(frame: .zero)
        configureButton(withText: text)
        setAnimation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var baseColor: UIColor { self.tintAdjustmentMode == .dimmed ? .systemGray2 : .systemBlue }
    var imageAndTextColor: UIColor { self.tintAdjustmentMode == .dimmed ? .systemGray3 : .white }

    private func configureButton(withText text: String) {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: Constants.fontSize)
        layer.cornerRadius = 10

        var customConfig = UIButton.Configuration.filled()
        customConfig.imagePlacement = .trailing
        customConfig.imagePadding = Constants.imagePadding
        customConfig.contentInsets = NSDirectionalEdgeInsets(
            top: Constants.verticalContentPadding,
            leading: Constants.horizontalContentPadding,
            bottom: Constants.verticalContentPadding,
            trailing: Constants.horizontalContentPadding
        )

        configurationUpdateHandler = { button in
            let imageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: self.imageAndTextColor)
            button.configuration?.image = UIImage(systemName: Constants.imageName, withConfiguration: imageConfiguration)
            button.configuration?.background.backgroundColor = self.baseColor
            button.titleLabel?.textColor = self.imageAndTextColor
        }

        configuration = customConfig
    }

    private func setAnimation() {
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: [.touchUpInside, .touchUpOutside])
    }

    @objc private func touchDown() {
        animateButton(scaleX: 0.9, scaleY: 0.9)
    }

    @objc private func touchUp() {
        animateButton(scaleX: 1.0, scaleY: 1.0)
    }

    private func animateButton(scaleX: CGFloat, scaleY: CGFloat) {
        animator?.stopAnimation(true)
        animator = UIViewPropertyAnimator(duration: 0.2, dampingRatio: 1) {
            self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        }
        animator?.startAnimation()
    }
}
