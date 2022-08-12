//
//  DDIPCardListButton.swift
//  DesignSystem
//
//  Created by Eddy on 2022/07/02.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

public class DDIPCardListButton: UIButton {
    public enum ApplyStatus {
        /// 응모하기
        case enable
        
        /// 응모완료
        case complete
        
        /// 버튼에 적용될 문구
        var title: String {
            switch self {
            case .enable: return "응모하기"
            case .complete: return "응모완료"
            }
        }
    }

    public enum AppliedStatus {
        /// 결과확인
        case confirmResult
        
        /// 응모중
        case inprogress
        
        /// 당첨
        case win
        
        /// 꽝
        case lose
        
        var title: String {
            switch self {
            case .confirmResult: return "결과 확인"
            case .inprogress: return "응모중"
            case .win: return "당첨"
            case .lose: return "꽝"
            }
        }
    }

    public init() {
        super.init(frame: .zero)
        setButton()
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setButton() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setAttribute() {
        self.layer.cornerRadius = 12

        self.setTitleColor(.designSystem(.neutralWhite), for: .normal)
        self.titleLabel?.font = .designSystem(.pretendard, family: .bold, size: ._14)
        self.titleLabel?.textAlignment = .center

    }
    
    private func setLayout() {
        self.titleLabel?.widthAnchor.constraint(equalToConstant: 52).isActive = true

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 34),
            self.widthAnchor.constraint(equalToConstant: 96)
        ])
    }
}

// MARK: - 외부 주입 메서드

extension DDIPCardListButton {
    public func setButtonAttribute(title: String, buttonColor: DDIPColor, isHidden: Bool, isEnabled: Bool) {
        self.setTitle(title, for: .normal)
        self.isHidden = isHidden
        self.backgroundColor = UIColor.designSystem(buttonColor)
        self.isEnabled = isEnabled
    }
}
