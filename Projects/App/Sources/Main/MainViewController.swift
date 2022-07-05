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
    private let delegate = MainCollectionViewDelegate()
    private let dataSource = MainCollectionViewDataSource()
    private let floatingButton = TempButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        floatingButton.frame = CGRect(x: view.frame.size.width - 48 - 16,
                                      y: view.frame.size.height - 48 - 48,
                                      width: 48,
                                      height: 48)
    }
    
    private func configure() {
        configureNavigationBar()
        
        floatingButton.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
        
        mainView.configureDataSource(dataSource)
        mainView.configureDelegate(delegate)
        mainView.addSubview(floatingButton)
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
    
    @objc private func addButtonDidTapped() {
        // TODO: + 버튼 탭 되었을 때의 액션 구현
    }
}
