//
//  MainViewController.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/06/14.
//  Copyright © 2022 dvHuni. All rights reserved.

import UIKit

final class MainViewController: UIViewController {
    
    static let sectionHeaderElementKind = "sectionHeaderElementKind"
     
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let mainView = MainView()
    private let dataSource = MainCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        mainView.configureDataSource(dataSource)
        self.view = mainView
    }
    
    private func configureNavigationBar() {
        let button = TempBarButton()
        let myButtonItem = UIBarButtonItem(customView: button.myButton)
        let notiButton = UIBarButtonItem(customView: button.notiButton)
        self.navigationItem.rightBarButtonItems = [notiButton, myButtonItem]
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.title = "DDIP"
    }
}
