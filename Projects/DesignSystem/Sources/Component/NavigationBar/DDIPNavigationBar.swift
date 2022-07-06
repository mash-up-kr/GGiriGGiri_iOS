//
//  DDIPNavigationBar.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/01.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public class DDIPNavigationBar: UIView {
    public enum BarItem {
        case back
        case cancel
        
        var icon: UIImage? {
            switch self {
            case .back:
                return UIImage(systemName: "chevron.backward")
            case .cancel:
                return UIImage(systemName: "xmark")
            }
        }
    }
    
    private let titleLabel: UILabel? = UILabel()
    private var rightButtonsItems: [UIBarButtonItem]?
    private var leftButtonItem: UIBarButtonItem?
    
    private let disposeBag = DisposeBag()
    
    public let leftButtonTapEvent = PublishRelay<Void>()
    
    public init(
        frame: CGRect = .zero,
        leftBarItem: BarItem? = nil,
        title: String? = nil,
        rightButtonsItem: [UIBarButtonItem]? = nil
    ) {
        self.leftBarItem = leftBarItem
        self.title = title
        self.rightButtonsItems = rightButtonsItem
    
        super.init(frame: frame)
        
        setBarButtonItmes()
        setAttribute()
        setNavigationBar()
        bind()
    }
        
    public var title: String? {
        didSet { self.titleLabel?.text = title }
    }
    
    public var leftBarItem: BarItem? {
        didSet { self.leftIcon = leftBarItem?.icon }
    }
    
    private var leftIcon: UIImage? {
        get { self.leftButtonItem?.image }
        set { self.leftButtonItem?.setBackgroundImage(newValue, for: .normal, barMetrics: .default) }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Fatal Error")
    }
    
    private func setBarButtonItmes() {
        leftButtonItem = UIBarButtonItem(image: leftBarItem?.icon, style: .plain, target: nil, action: nil)
    }
    
    private func setAttribute() {
        leftButtonItem?.tintColor = UIColor.black
    }
    
    private func setNavigationBar() {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 56, width: UIScreen.main.bounds.size.width, height: 38))
        let navigationItem = UINavigationItem(title: self.title ?? "")
        
        navigationItem.leftBarButtonItem = leftButtonItem
        navigationItem.rightBarButtonItems = rightButtonsItems
        navigationBar.setItems([navigationItem], animated: false)
        
        self.addSubview(navigationBar)
    }
    
    private func bind() {
        leftButtonItem?.rx.tap.bind(to: self.leftButtonTapEvent)
            .disposed(by: disposeBag)
    }
}
