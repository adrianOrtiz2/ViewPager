//
//  TabCellCollectionViewCell.swift
//  PageViewController
//
//  Created by Adrian Ortiz on 3/5/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import UIKit

class TabCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var name:UILabel!
    @IBOutlet weak var icon:UIImageView!
    @IBOutlet weak var underLine:UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
