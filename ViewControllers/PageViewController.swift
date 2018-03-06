//
//  PageViewController.swift
//  PageViewController
//
//  Created by Adrian Ortiz on 1/10/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    var viewModel:PageViewViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.dataSource = self
        self.delegate = self
        viewModel.updateView = { (update) in
            if update {
                if let firstViewController = self.viewModel.pages.first {
                    self.setViewControllers([firstViewController.viewController], direction: .forward, animated: true, completion: nil)
                }
            }
        }
        viewModel.scrollToPosition = { (page, direction) in
            self.setViewControllers([page], direction: direction, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initPageViewController(withPages pages: [Page]) {
        viewModel.pages = pages
    }

}

// MARK: - PageController DataSource

extension PageViewController:UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let page = viewModel.previousPage(viewController) else {
            return nil
        }
        return page.viewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let page = viewModel.nextPage(viewController) else {
            return nil
        }
        return page.viewController
    }
}

// MARK: - PageController Delegate
extension PageViewController:UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        viewModel.updateCurrentPage(completed: false, page: viewModel.getIndexFrom(viewController: pendingViewControllers[0]))
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            viewModel.updateCurrentPage(completed: completed, page: nil)
        }
    }
    
}
