//
//  DDIPCountDownTimer.swift
//  DesignSystem
//
//  Created by AhnSangHoon on 2022/08/01.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

import RxSwift
import RxRelay

public final class DDIPCountDownTimer {
    public enum CountDownType {
        case minute
        case second
        
        var interval: RxTimeInterval {
            switch self {
            case .minute:
                return .seconds(60)
            case .second:
                return .seconds(1)
            }
        }
    }
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        return formatter
    }()
    private let calendar = Calendar(identifier: .gregorian)
    
    private let countdownType: CountDownType
    
    private var standardDate: Date?
    private var usageDate: Date? {
        didSet {
            updateDateComponents()
        }
    }
    
    public let hour = BehaviorRelay<Int?>(value: nil)
    public let minute = BehaviorRelay<Int?>(value: nil)
    public let second = BehaviorRelay<Int?>(value: nil)
    
    private var disposeBag = DisposeBag()
    
    public init(_ countdownType: CountDownType = .second, date: Date? = nil) {
        self.countdownType = countdownType
        self.standardDate = date
        self.usageDate = date
        bind()
    }
    
    private func bind() {
        guard let _ = standardDate else {
            disposeBag = DisposeBag()
            return
        }
        
        Observable<Int>.interval(countdownType.interval, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.desrecase()
            })
            .disposed(by: disposeBag)
    }
    
    private func desrecase() {
        guard let usageDate = usageDate else {
            disposeBag = DisposeBag()
            return
        }

        let date: Date? = {
            switch countdownType {
            case .minute:
                return calendar.date(byAdding: .minute, value: -1, to: usageDate, wrappingComponents: true)
            case .second:
                return calendar.date(byAdding: .second, value: -1, to: usageDate, wrappingComponents: true)
            }
        }()
        
        guard let decreasedDate = date else {
            disposeBag = DisposeBag()
            return
        }
        
        self.usageDate = decreasedDate
    }
    
    private func updateDateComponents() {
        guard let usageDate = usageDate else {
            return
        }
        let components = calendar.dateComponents([.hour, .minute, .second], from: usageDate)
        
        hour.accept(components.hour)
        minute.accept(components.minute)
        second.accept(components.second)
    }
}

extension DDIPCountDownTimer {
    func update(date: Date?) {
        disposeBag = DisposeBag()
        
        standardDate = date
        usageDate = date
        bind()
    }
}
