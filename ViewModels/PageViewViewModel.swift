//
//  PageViewViewModel.swift
//  PageViewController
//
//  Created by Adrian Ortiz on 1/19/18.
//  Copyright © 2018 Adrian Ortiz. All rights reserved.
//

import UIKit

class PageViewViewModel {
    
    // MARK - Properties
    var currentPage = 0
    var updateView: ((Bool) -> ())?
    var scrollToPosition: ((UIViewController, UIPageViewControllerNavigationDirection) -> ())?
    var scrollPage: ((Int) -> ())!
    var pages:[Page] = [] {
        didSet {
            setupView()
        }
    }
    
    private func setupView() {
        currentPage = 0
        guard let updateView = updateView else {
            return
        }
        updateView(true)
    }
    
    func nextPage(_ viewController:UIViewController) -> Page? {
        
        guard  let index = getIndexFrom(viewController: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        
        if nextIndex >= pages.count {
            return nil
        }

        return pages[nextIndex]
    }
    
    func getIndexFrom(viewController controller:UIViewController) -> Int? {
        return pages.index(where: { $0.viewController == controller })
    }
    
    func previousPage(_ viewController:UIViewController) -> Page? {
        guard let index = getIndexFrom(viewController: viewController) else {
                return nil
        }
        
        let previousIndex = index - 1
        
        if previousIndex < 0 || previousIndex > pages.count {
            return nil
        }

        return pages[previousIndex]
    }
    
    func updateCurrentPage(completed:Bool, page:Int?) {
        if completed {
            scrollPage(currentPage)
        } else {
            currentPage = page!
        }
    }
    
    func getNumberOfPages() -> Int {
        return pages.count
    }
    
    func getNumberOfSections() -> Int {
        return 1
    }
    
    func getTabName(at index:Int) -> String {
        return pages[index].tab.name
    }
    
    func getIconTab(at index:Int) -> String {
        return pages[index].tab.icon
    }
    
    func scrollToPage(_ index:Int) {
        guard let scrollToPosition = scrollToPosition,
            index >= 0 && index < pages.count  else {
            return
        }
        let direction = index < currentPage ? UIPageViewControllerNavigationDirection.reverse : UIPageViewControllerNavigationDirection.forward
        currentPage = index
        scrollToPosition(pages[index].viewController, direction)
    }
    
    func getTabWidth(at index:Int) -> CGFloat {
        if index >= 0 && index < pages.count {
            let font = UIFont(name: "Helvetica", size: 18)
            let fontAttributes = [NSAttributedStringKey.font: font]
            let width = (pages[index].tab.name as NSString).size(withAttributes: fontAttributes).width
            return width < 80 ? 80 : width
        }
        return 0
    }
    
}
