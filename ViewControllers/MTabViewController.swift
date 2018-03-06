//
//  MTabViewController.swift
//  PageViewController
//
//  Created by Adrian Ortiz on 1/31/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import UIKit

class MTabViewController: UIViewController {
    
    private let pageViewModel = PageViewViewModel()
    private var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initPageViewController(withPages pages: [Page]) {
        pageViewModel.pages = pages
        pageViewModel.scrollPage = { (index) in
            let indexPath = IndexPath(item: index, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
        collectionView.reloadData()
    }
    
    private func initView() {
        
        let mainView = UIView()
        //Create collectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50), collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "TabCellCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PageViewTab")
        collectionView.backgroundColor = UIColor.white
        mainView.addSubview(collectionView)
        
        // Init PageViewController
        let page = PageViewController.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [:])
        page.viewModel = pageViewModel

        add(asChildViewController: page, container: mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainView)
        addConstraints(mainView: mainView)
        
        //CollectionView contrainst
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: mainView.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: mainView.rightAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    private func addConstraints(mainView: UIView) {
        
        if #available(iOS 11, *) {
            let safeGuide = self.view.safeAreaLayoutGuide
            mainView.topAnchor.constraint(equalTo: safeGuide.topAnchor).isActive = true
            mainView.bottomAnchor.constraint(equalTo: safeGuide.bottomAnchor).isActive = true
            mainView.leftAnchor.constraint(equalTo: safeGuide.leftAnchor).isActive = true
            mainView.rightAnchor.constraint(equalTo: safeGuide.rightAnchor).isActive = true
            
        } else {
            let guide = self.view!
            mainView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            mainView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
            mainView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        }
    }
    
    private func add(asChildViewController viewController: UIViewController, container:UIView) {
        addChildViewController(viewController)
        container.addSubview(viewController.view)
        
        viewController.view.frame = CGRect(x: 0, y: 50, width: container.bounds.size.width, height: container.bounds.size.height)
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        viewController.didMove(toParentViewController: self)
        
    }

}

// MARK: - Collection View DataSource
extension MTabViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pageViewModel.getNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageViewModel.getNumberOfPages()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageViewTab", for: indexPath) as! TabCellCollectionViewCell
        cell.name.text = pageViewModel.getTabName(at: indexPath.row)
        cell.icon.image = UIImage(named: pageViewModel.getIconTab(at: indexPath.row))
        cell.underLine.isHidden = !(pageViewModel.currentPage == indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        pageViewModel.scrollToPage(indexPath.row)
        collectionView.reloadData()
        //Center cell
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MTabViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: pageViewModel.getTabWidth(at: indexPath.row), height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
    }
    
}

// MARK: - Custom actions view pager
extension MTabViewController {
    
    func setTabBackgroundColor(_ color:UIColor) {
        collectionView.backgroundColor = color
    }
    
}
