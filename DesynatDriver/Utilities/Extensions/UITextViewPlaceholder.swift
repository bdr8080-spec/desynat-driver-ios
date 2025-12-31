//
//  UITextViewExtension.swift
//  Altair
//
//  Created by Rakhi Kumari on 23/09/25.
//

import UIKit
import ObjectiveC

private var kPlaceholderLabelKey: UInt8 = 0

extension UITextView {

    @IBInspectable var placeholder: String? {
        get {
            placeholderLabel?.text
        }
        set {
            if placeholderLabel == nil {
                createPlaceholderLabel()
            }
            placeholderLabel?.text = newValue
            updatePlaceholderVisibility()
        }
    }

    private var placeholderLabel: UILabel? {
        get {
            objc_getAssociatedObject(self, &kPlaceholderLabelKey) as? UILabel
        }
        set {
            objc_setAssociatedObject(self, &kPlaceholderLabelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private func createPlaceholderLabel() {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = self.font
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6)
        ])

        placeholderLabel = label
    }

    func updatePlaceholderVisibility() {
        placeholderLabel?.isHidden = !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
