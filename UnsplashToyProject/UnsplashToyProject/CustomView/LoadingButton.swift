//
//  LoadingButton.swift
//  UnsplashToyProject
//
//  Created by 박형석 on 2021/12/04.
//

import UIKit

class LoadingButton: UIButton {
    
    public var title: String = "" {
        didSet {
            self.setTitle(title, for: .normal)
        }
    }
    
    
    
}
