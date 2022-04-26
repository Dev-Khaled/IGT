//
//  UIKit+Padding.swift
//  Snack
//
//  Created by Khaled Khaldi on 25/02/2022.
//

import UIKit

// MARK: - UITextField

class PaddingTextField: UITextField {
    
    @IBInspectable var inset: CGSize = CGSize.zero
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset.width, dy: inset.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
}

// MARK: - UITextView

class PaddingTextView: UITextView {
    
    @IBInspectable var inset: CGSize = CGSize.zero
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textContainerInset = UIEdgeInsets(top: inset.height, left: inset.width, bottom: inset.height, right: inset.width)
    }
    
}


// MARK: - UIButton

class PaddingButton: UIButton {
    
    @IBInspectable var padding: CGFloat = 0.0
    @IBInspectable var trailingImage: Bool = false
        
    override func layoutSubviews() {
        super.layoutSubviews()
        setPadding()
    }
    
    private func setPadding() {
        guard let imageView = imageView, let titleLabel = titleLabel else { return }
        
        let factor: CGFloat
        if UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .leftToRight {
            factor = 1
        } else {
            factor = -1
        }
        
        if trailingImage {
            imageEdgeInsets = UIEdgeInsets(
                top: imageEdgeInsets.top,
                left: (titleLabel.frame.width+(padding/2.0))*factor,
                bottom: imageEdgeInsets.bottom,
                right: (-titleLabel.frame.width-(padding/2.0))*factor
            )
            titleEdgeInsets = UIEdgeInsets(
                top: titleEdgeInsets.top,
                left: (-imageView.frame.width-(padding/2.0))*factor,
                bottom: titleEdgeInsets.bottom,
                right: (imageView.frame.width+(padding/2.0))*factor
            )
            
        } else {
            imageEdgeInsets = UIEdgeInsets(
                top: imageEdgeInsets.top,
                left: (-(padding/2.0))*factor,
                bottom: imageEdgeInsets.bottom,
                right: ((padding/2.0))*factor
            )
            titleEdgeInsets = UIEdgeInsets(
                top: titleEdgeInsets.top,
                left: ((padding/2.0))*factor,
                bottom: titleEdgeInsets.bottom,
                right: (-(padding/2.0))*factor
            )
        }

    }
    
    
    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += padding
        return size
    
    }

}


// MARK: - UILabel

class PaddingLabel: UILabel {

    @IBInspectable var topInset: CGFloat    = 0.0
    @IBInspectable var bottomInset: CGFloat = 0.0
    @IBInspectable var leftInset: CGFloat   = 0.0
    @IBInspectable var rightInset: CGFloat  = 0.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(
            top: topInset,
            left: leftInset,
            bottom: bottomInset,
            right: rightInset
        )
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width+leftInset+rightInset,
            height: size.height+topInset+bottomInset
        )
    }

}
