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

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    convenience init (hex:String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
    
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
}
extension UIView {
    
    func view(withId id: String) -> UIView? {
        
        for view in self.subviews {
            if view.tag == Int(id) {
                return view
            }
        }
        return nil
    }
}

extension String {
        var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
 
   
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
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



//Riddhi

extension NSDictionary {
    
//    func convertToString() -> String {
//        let jsonData = try! JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) as NSData?
//
//        if jsonData  == nil{
//            return "{}"
//        }else {
//            return String(data: jsonData! as Data, encoding: String.Encoding.utf8)!
//        }
//
//        /*
//        do {
//        let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
//        let jsonString = NSString.init(data: jsonData, encoding: String.Encoding.utf8.rawValue)
//        return jsonString as! String
//        }
//        catch {
//        return "Not a valid json object"
//        }
//        */
//    }
    
    func object_forKeyWithValidationForClass_Int(aKey: String) -> Int {
        
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return Int()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return Int()
            }
        } else {
            // KEY NOT FOUND
            return Int()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return Int()
        }
        else if(aValue.isKind(of: NSString.self)){
            return Int((aValue as! NSString).intValue)
        }
        else {
            
            if aValue is Int {
                return self.object(forKey: aKey) as! Int
            }
            else{
                return Int()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_Double(aKey: String) -> Double {
        
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return Double()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return Double()
            }
        } else {
            // KEY NOT FOUND
            return Double()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return Double()
        }
        else if(aValue.isKind(of: NSString.self)){
            return Double((aValue as! NSString).doubleValue)
        }
        else {
            
            if aValue is Int {
                return self.object(forKey: aKey) as! Double
            }
            else{
                return Double()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_CGFloat(aKey: String) -> CGFloat {
        
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return CGFloat()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return CGFloat()
            }
        } else {
            // KEY NOT FOUND
            return CGFloat()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return CGFloat()
        }
        else {
            
            if aValue is CGFloat {
                return self.object(forKey: aKey) as! CGFloat
            }
            else{
                return CGFloat()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_String(aKey: String) -> String {
        
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return String()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return String()
            }
        } else {
            // KEY NOT FOUND
            return String()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return String()
        }
        else if(aValue.isKind(of: NSNumber.self)){
            return String(format:"%f", (aValue as! NSNumber).doubleValue)
        }
        else {
            
            if aValue is String {
                return self.object(forKey: aKey) as! String
            }
            else{
                return String()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_StringInt(aKey: String) -> String {
        
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return String()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return String()
            }
        } else {
            // KEY NOT FOUND
            return String()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return String()
        }
        else if(aValue.isKind(of: NSNumber.self)){
            return String(format:"%d", (aValue as! NSNumber).int64Value)
//            return String(format:"%.0f", (aValue as! NSNumber).doubleValue)

        }
        else {
            
            if aValue is String {
                return self.object(forKey: aKey) as! String
            }
            else{
                return String()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_Bool(aKey: String) -> Bool {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return Bool()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return Bool()
            }
        } else {
            // KEY NOT FOUND
            return Bool()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return Bool()
        }
        else {
            
            if aValue is Bool {
                return self.object(forKey: aKey) as! Bool
            }
            else{
                return Bool()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_NSArray(aKey: String) -> NSArray {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return NSArray()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return NSArray()
            }
        } else {
            // KEY NOT FOUND
            return NSArray()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return NSArray()
        }
        else {
            if aValue is NSArray {
                return self.object(forKey: aKey) as! NSArray
            }
            else{
                return NSArray()
            }
        }
    }
    func object_forKeyWithValidationForClass_stringArray(aKey: String) -> [String] {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return [String]()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return [String]()
            }
        } else {
            // KEY NOT FOUND
            return [String]()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return [String]()
        }
        else {
            if aValue is [String] {
                return self.object(forKey: aKey) as! [String]
            }
            else{
                return [String]()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_NSMutableArray(aKey: String) -> NSMutableArray {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return NSMutableArray()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return NSMutableArray()
            }
        } else {
            // KEY NOT FOUND
            return NSMutableArray()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return NSMutableArray()
        }
        else {
            
            if aValue is NSMutableArray {
                return self.object(forKey: aKey) as! NSMutableArray
            }
            else{
                return NSMutableArray()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_NSDictionary(aKey: String) -> NSDictionary {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return NSDictionary()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return NSDictionary()
            }
        } else {
            // KEY NOT FOUND
            return NSDictionary()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return NSDictionary()
        }
        else {
            
            if aValue is NSDictionary {
                return self.object(forKey: aKey) as! NSDictionary
            }
            else{
                return NSDictionary()
            }
        }
    }
    
    func object_forKeyWithValidationForClass_NSMutableDictionary(aKey: String) -> NSMutableDictionary {
        // CHECK FOR EMPTY
        if(self.allKeys.count == 0) {
            return NSMutableDictionary()
        }
        
        // CHECK IF KEY EXIST
        if let val = self.object(forKey: aKey) {
            if((val as AnyObject).isEqual(NSNull())) {
                return NSMutableDictionary()
            }
        } else {
            // KEY NOT FOUND
            return NSMutableDictionary()
        }
        
        // CHECK FOR NIL VALUE
        let aValue : AnyObject = self.object(forKey: aKey)! as AnyObject
        if aValue.isEqual(NSNull()) {
            return NSMutableDictionary()
        }
        else {
            if aValue is NSMutableDictionary {
                return self.object(forKey: aKey) as! NSMutableDictionary
            }
            else{
                return NSMutableDictionary()
            }
        }
    }
}
