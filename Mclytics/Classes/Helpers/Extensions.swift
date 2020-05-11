//
//  Extensions.swift
//  Matchfit
//
//  Created by Gunjan Raval on 23/08/18.
//  Copyright © 2018 Gunjan. All rights reserved.
//
//

import Foundation
import UIKit

extension UITextField {

	func notEmpty() -> Bool {

		if let txt = self.text {

			let trimmedString = txt.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

			if trimmedString != "" {
				return true
			}
		}

		return false
	}
}

extension String {
	func capitalizingFirstLetter() -> String {
		return prefix(1).uppercased() + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}

	func trim() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
	}

	func index(from: Int) -> Index {
		return self.index(startIndex, offsetBy: from)
	}

	subscript(_ range: NSRange) -> String {
		let start = self.index(self.startIndex, offsetBy: range.lowerBound)
		let end = self.index(self.startIndex, offsetBy: range.upperBound)
		let subString = self[start..<end]
		return String(subString)
	}

	func width(width: CGFloat, font: UIFont) -> CGFloat {
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: .greatestFiniteMagnitude))
		label.numberOfLines = 0
		label.lineBreakMode = NSLineBreakMode.byWordWrapping
		label.font = font
		label.text = self
		label.sizeToFit()

		return label.frame.height
	}
}

extension UISegmentedControl {
	func removeBorders() {
		setBackgroundImage(imageWithColor(color: backgroundColor!), for: .normal, barMetrics: .default)
		setBackgroundImage(imageWithColor(color: tintColor!), for: .selected, barMetrics: .default)
		setDividerImage(imageWithColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
	}

	// create a 1x1 image with this color
	private func imageWithColor(color: UIColor) -> UIImage {
		let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
		UIGraphicsBeginImageContext(rect.size)
		let context = UIGraphicsGetCurrentContext()
		context!.setFillColor(color.cgColor);
		context!.fill(rect);
		let image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		return image!
	}
}

extension UIScrollView {

	override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		if self.isDragging {
			super.touchesBegan(touches, with: event)
		} else {
			self.superview?.touchesBegan(touches, with: event)
		}
	}

	override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)    {
		if self.isDragging {
			super.touchesCancelled(touches, with: event)
		} else {
			self.superview?.touchesCancelled(touches, with: event)
		}
	}

	override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		if self.isDragging {
			super.touchesEnded(touches, with: event)
		} else {
			self.superview?.touchesEnded(touches, with: event)
		}
	}

	override open func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		if self.isDragging {
			super.touchesMoved(touches, with: event)
		} else {
			self.superview?.touchesMoved(touches, with: event)
		}
	}
}

extension UITextView{
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        let fixedWidth = arg.frame.size.width
        let newSize = arg.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        arg.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        arg.isScrollEnabled = false
        arg.sizeToFit()
    }
}

extension UIImage
{
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
    // convenience function in UIImage extension to resize a given image
    func convert(toSize size:CGSize, scale:CGFloat) ->UIImage
    {
        let imgRect = CGRect(origin: CGPoint(x:0.0, y:0.0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        self.draw(in: imgRect)
        let copied = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return copied!
    }
    func jpeg(_ quality: JPEGQuality) -> Data? {
        
        return self.jpegData(compressionQuality: quality.rawValue)

//        return UIImageJPEGRepresentation(self, quality.rawValue)
        
//        return UIImagePNGRepresentation(self)
        
    }
}





