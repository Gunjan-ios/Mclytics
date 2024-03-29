//
//  UIView+Borders.swift
//  UIViewWithSelectableBorders
//
//  Created by Chris Forant on 5/23/15.
//  Copyright (c) 2015 Totem. All rights reserved.
//

//import UIKit
//
//// MARK: - UIView
//extension UIView {
//
//    @IBInspectable var cornerRadius: CGFloat {
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//
//    @IBInspectable var borderWidth: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//
//    @IBInspectable var borderColor: UIColor? {
//        get {
//            return UIColor(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }
//
//    @IBInspectable var borderShadow: UIColor? {
//        get {
//            return UIColor(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.shadowColor = UIColor.black.cgColor
//            layer.shadowOpacity = 2.2
//            layer.shadowOffset = CGSize.zero
//            //cell.ViewImageBack.layer.shadowRadius = 5
//            print(bounds)
//            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5).cgPath
//        }
//    }
//
//
//    @IBInspectable var leftBorderWidth: CGFloat {
//        get {
//            return 0.0   // Just to satisfy property
//        }
//        set {
//            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: newValue, height: bounds.height))
//            line.translatesAutoresizingMaskIntoConstraints = false
//            line.backgroundColor = UIColor(cgColor: layer.borderColor!)
//           line.tag = 110
//            self.addSubview(line)
//
//            let views = ["line": line]
//            let metrics = ["lineWidth": newValue]
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
//        }
//    }
//
//    @IBInspectable var topBorderWidth: CGFloat {
//        get {
//            return 0.0   // Just to satisfy property
//        }
//        set {
//            let line = UIView(frame: CGRect(x: 0.0, y: 0.0, width: bounds.width, height: newValue))
//            line.translatesAutoresizingMaskIntoConstraints = false
//            line.backgroundColor = borderColor
//           line.tag = 110
//            self.addSubview(line)
//
//            let views = ["line": line]
//            let metrics = ["lineWidth": newValue]
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line(==lineWidth)]", options: [], metrics: metrics, views: views))
//        }
//    }
//
//    @IBInspectable var rightBorderWidth: CGFloat {
//        get {
//            return 0.0   // Just to satisfy property
//        }
//        set {
//            let line = UIView(frame: CGRect(x: bounds.width, y: 0.0, width: newValue, height: bounds.height))
//            line.translatesAutoresizingMaskIntoConstraints = false
//            line.backgroundColor = borderColor
//           line.tag = 110
//            self.addSubview(line)
//
//            let views = ["line": line]
//            let metrics = ["lineWidth": newValue]
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[line]|", options: [], metrics: nil, views: views))
//        }
//    }
//    @IBInspectable var bottomBorderWidth: CGFloat {
//        get {
//            return 0.0   // Just to satisfy property
//        }
//        set {
//            let line = UIView(frame: CGRect(x: 0.0, y: bounds.height, width: bounds.width, height: newValue))
//            line.translatesAutoresizingMaskIntoConstraints = false
//            line.backgroundColor = borderColor
//          line.tag = 110
//            self.addSubview(line)
//
//            let views = ["line": line]
//            let metrics = ["lineWidth": newValue]
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[line]|", options: [], metrics: nil, views: views))
//            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[line(==lineWidth)]|", options: [], metrics: metrics, views: views))
//        }
//    }
//     func removeborder() {
//          for view in self.subviews {
//               if view.tag == 110  {
//                    view.removeFromSuperview()
//               }
//
//          }
//     }
//    @IBInspectable
//    var shadowRadius: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowRadius = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowOpacity: Float {
//        get {
//            return layer.shadowOpacity
//        }
//        set {
//            layer.shadowOpacity = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowOffset: CGSize {
//        get {
//            return layer.shadowOffset
//        }
//        set {
//            layer.shadowOffset = newValue
//        }
//    }
//
//    @IBInspectable
//    var shadowColor: UIColor? {
//        get {
//            if let color = layer.shadowColor {
//                return UIColor(cgColor: color)
//            }
//            return nil
//        }
//        set {
//            if let color = newValue {
//                layer.shadowColor = color.cgColor
//            } else {
//                layer.shadowColor = nil
//            }
//        }
//    }
//}
//
