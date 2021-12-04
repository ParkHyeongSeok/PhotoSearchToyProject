//
//  PhotoTableViewCell.swift
//  UnsplashToyProject
//
//  Created by 박형석 on 2021/12/04.
//

import Foundation
import UIKit

class PhotoTableViewCell: UITableViewCell {
    static let identifier = "PhotoTableViewCell"
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var phoyographerImage: UIImageView!
    @IBOutlet weak var photographerName: UILabel!
    @IBOutlet weak var photoDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
