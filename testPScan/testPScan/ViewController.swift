//
//  ViewController.swift
//  testPScan
//
//  Created by CampbellQi on 2018/6/12.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let view = self.view.viewWithTag(10)
        view?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(scan)))
    }

    @objc func scan() {
        let images = ["timg.jpeg", "timg-2.jpeg"]
        let vc = WQPictureScanController()
        vc.sourcePictures = images
        vc.currentIndex = 1
        vc.imageLoad = {(iv, index, finished) in
            iv.image = UIImage.init(named: images[index])
            finished?()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.viewWithTag(10)
    }
}

