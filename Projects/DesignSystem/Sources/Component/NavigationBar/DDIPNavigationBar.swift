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
        case mybox
        case noAlarm
        case alarm
        case back
        case cancel
        
        var icon: UIImage? {
            switch self {
            case .mybox:
                return UIImage(systemName: "swift")
            case .noAlarm:
                return UIImage(systemName: "bell")
            case .alarm:
                return UIImage(systemName: "bell.badge")
            case .back:
                return UIImage(systemName: "chevron.backward")
            case .cancel:
                return UIImage(systemName: "xmark")
            }
        }
    }
    
    private let titleLabel: UILabel? = UILabel()
    private var back: UIBarButtonItem?
    private var mybox: UIBarButtonItem?
    private var alarm: UIBarButtonItem?
    
    private let disposeBag = DisposeBag()
    
    public let backButtonTapEvent = PublishRelay<Void>()
    public let myboxButtonTapEvent = PublishRelay<Void>()
    public let alarmButtonTapEvent = PublishRelay<Void>()
    
    public init(
        frame: CGRect = .zero,
        leftBarItem: BarItem? = nil,
        title: String? = nil,
        myboxBarItem: BarItem? = nil,
        alarmBarItem: BarItem? = nil
    ) {
        self.leftBarItem = leftBarItem
        self.title = title
        self.myboxBarItem = myboxBarItem
        self.alarmBarItem = alarmBarItem
        
        super.init(frame: frame)
        
        setBarButtonItmes()
        setAttribute()
        setNavigationBar()
        bind()
    }
        
    public var myboxBarItem: BarItem? {
        didSet { self.myboxIcon = myboxBarItem?.icon }
    }
    
    public var alarmBarItem: BarItem? {
        didSet { self.alarmIcon = alarmBarItem?.icon }
    }
    
    public var leftBarItem: BarItem? {
        didSet { self.leftIcon = leftBarItem?.icon }
    }
    
    public var title: String? {
        didSet { self.titleLabel?.text = title }
    }
    
    private var myboxIcon: UIImage? {
        get { self.mybox?.image }
        set { self.mybox?.setBackgroundImage(newValue, for: .normal, barMetrics: .default) }
    }
    
    private var alarmIcon: UIImage? {
        get { self.alarm?.image }
        set { self.alarm?.setBackgroundImage(newValue, for: .normal, barMetrics: .default) }
    }
    
    private var leftIcon: UIImage? {
        get { self.back?.image }
        set { self.back?.setBackgroundImage(newValue, for: .normal, barMetrics: .default) }
    }
    
    public required init?(coder: NSCoder) {
        fatalError("Fatal Error")
    }
    
    private func setBarButtonItmes() {
        back = UIBarButtonItem(image: leftBarItem?.icon, style: .plain, target: nil, action: nil)
        mybox = UIBarButtonItem(image: myboxBarItem?.icon, style: .plain, target: nil, action: nil)
        alarm = UIBarButtonItem(image: alarmBarItem?.icon, style: .plain, target: nil, action: nil)
    }
    
    private func setAttribute() {
        back?.tintColor = UIColor.black
        mybox?.tintColor = UIColor.black
        alarm?.tintColor = UIColor.black
    }
    
    private func setNavigationBar() {
        var rightBarButtons: [UIBarButtonItem] = []
        
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 56, width: UIScreen.main.bounds.size.width, height: 38))
        let navigationItem = UINavigationItem(title: self.title ?? "")
        
        if let alarm = alarm, let mybox = mybox {
            rightBarButtons.append(alarm)
            rightBarButtons.append(mybox)
        }
        
        navigationItem.rightBarButtonItems = rightBarButtons
        navigationItem.leftBarButtonItem = back
        navigationBar.setItems([navigationItem], animated: false)
        
        self.addSubview(navigationBar)
    }
    
    private func bind() {
        back?.rx.tap.bind(to: self.backButtonTapEvent)
            .disposed(by: disposeBag)
        mybox?.rx.tap
            .bind(to: self.myboxButtonTapEvent)
            .disposed(by: disposeBag)
        alarm?.rx.tap.bind(to: self.alarmButtonTapEvent)
            .disposed(by: disposeBag)
    }
}
