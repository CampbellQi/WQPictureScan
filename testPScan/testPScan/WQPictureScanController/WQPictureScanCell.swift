//
//  WQPictureScanCell.swift
//  testPScan
//
//  Created by CampbellQi on 2018/6/12.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class WQPictureScanCell: UICollectionViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView = UIImageView()
        scrollView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
}

