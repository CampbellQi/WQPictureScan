//
//  WQPictureScanController.swift
//  testPictureScan
//
//  Created by CampbellQi on 2018/6/12.
//  Copyright © 2018年 CampbellQi. All rights reserved.
//

import UIKit

class WQPictureScanController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    private let cellId = "WQPictureScanCell"
    
    @objc var imageLoad: ((_ currentIV: UIImageView, _ index: Int, _ finished: (() -> Void)?) -> Void)?
    @objc var currentIndex: Int = 0
    //图片源数据
    @objc var sourcePictures: [Any] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.navigationItem.title == nil){
            self.setUpNavTitle()
        }
        
        
        //注册cell
        collectionView.register(UINib.init(nibName: cellId, bundle: Bundle.main), forCellWithReuseIdentifier: cellId)
        
        //设置布局
        let height = UIScreen.main.bounds.height - (self.navigationController?.navigationBar.frame.height ?? 0)
        let width = UIScreen.main.bounds.width
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = CGSize.init(width: width, height: height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        
        self.collectionView.reloadData()

        self.collectionView.layoutIfNeeded()
        self.collectionView.scrollToItem(at: IndexPath.init(row: currentIndex, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
        
        

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpNavTitle() {
        self.navigationItem.title = "\(currentIndex+1)/\(sourcePictures.count)"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WQPictureScanController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! WQPictureScanCell
        
//        cell.scrollView.frame = collectionView.bounds
        cell.scrollView.delegate = self
        self.imageLoad?(cell.imageView, indexPath.row, {
//            cell.contentIV.image = UIImage.init(named: sourcePictures[indexPath.row])
            if(cell.imageView.image == nil)
            {
                return;
            }
            let width = collectionView.frame.width
            let height = width/cell.imageView.image!.size.width * cell.imageView.image!.size.height
            cell.imageView.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
            cell.imageView.center = CGPoint.init(x: collectionView.frame.size.width/2, y: collectionView.frame.size.height/2)
            cell.scrollView.contentSize = cell.imageView.frame.size
        })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sourcePictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! WQPictureScanCell
        cell.scrollView.zoomScale = 1
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == self.collectionView {
            currentIndex = Int(ceil(scrollView.contentOffset.x / scrollView.frame.width))
            self.setUpNavTitle()
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollView.subviews[0]
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        var centerX = scrollView.center.x, centerY = scrollView.center.y
        centerX = scrollView.contentSize.width > scrollView.frame.width ? scrollView.contentSize.width/2 : centerX
        centerY = scrollView.contentSize.height > scrollView.frame.height ? scrollView.contentSize.height/2 :centerY
        scrollView.subviews[0].center = CGPoint.init(x: centerX, y: centerY)
    }
}
