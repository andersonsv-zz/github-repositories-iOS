//
//  UIViewExtension.swift
//  githubrepositories
//
//  Created by Anderson Vieira on 03/07/20.
//  Copyright © 2020 Vieira. All rights reserved.
//

import UIKit


extension UIView {
    var saferAreaLayoutGuide: UILayoutGuide {
        get {
            if #available(iOS 11.0, *) {
                return self.safeAreaLayoutGuide
            } else {
                return self.layoutMarginsGuide
            }
        }
    }
}
