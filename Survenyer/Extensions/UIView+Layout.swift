//
//  UIView+Layout.swift
//  Survenyer
//
//  Created by 齋藤健悟 on 2020/02/02.
//  Copyright © 2020 齋藤健悟. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var top: CGFloat {
        get {
            frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            frame.origin.y + frame.size.height
        }
        set {
            frame.origin.y = newValue - frame.size.height
        }
    }
    
    var left: CGFloat {
        get {
            frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    var right: CGFloat {
        get {
            frame.origin.x + frame.size.width
        }
        set {
            frame.origin.x = newValue - frame.size.width
        }
    }
    
    var viewWidth: CGFloat {
        get {
            frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    var viewHeight: CGFloat {
        get {
            frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
}
