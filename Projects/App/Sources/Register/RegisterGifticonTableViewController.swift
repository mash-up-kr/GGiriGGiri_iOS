//
//  RegisterGifticonTableViewController.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/09.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

final class RegisterGifticonTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        let closeButton = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(closeButtonDidTapped))
        
        self.navigationItem.leftBarButtonItem = closeButton
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.navigationItem.title = "기프티콘 등록"
    }
    
    @objc private func closeButtonDidTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}
