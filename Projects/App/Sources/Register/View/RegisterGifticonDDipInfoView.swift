//
//  RegisterGifticonDDipInfoView.swift
//  GGiriGGiri
//
//  Created by 안상희 on 2022/07/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import UIKit

import SnapKit

/// 기프티콘 정보 - 기프티콘 뿌리기 정보 뷰
final class RegisterGifticonDDipInfoView: BaseView {
    
    private let titleLabel = TempLabel(color: .black,
                                       text: "뿌리기 정보",
                                       font: .systemFont(ofSize: 16))
    
    private let ddipTitleLabel = TempLabel(color: .black,
                                          text: "마감시간",
                                          font: .systemFont(ofSize: 14))
    
    private let timeInputView = TimeInputView()
    
    override func setLayout() {
        super.setLayout()
        
        addSubviews(with: [titleLabel, ddipTitleLabel, timeInputView])
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        ddipTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(20)
        }
        
        timeInputView.snp.makeConstraints {
            $0.top.equalTo(ddipTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54)
        }
    }
}

/// 마감 시간 선택 뷰
fileprivate class TimeInputView: BaseView {
    
    private var timeList = ["30분", "1시간", "2시간", "3시간", "4시간", "5시간", "6시간", "7시간"]
    
    private let timePickerView = UIPickerView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        timePickerView.subviews[1].backgroundColor = .clear
    }
    
    override func setLayout() {
        super.setLayout()
        
        addSubview(timePickerView)
        
        timePickerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configure() {
        super.configure()
        
        timePickerView.dataSource = self
        timePickerView.delegate = self
        
        self.layer.cornerRadius = 12
        backgroundColor = UIColor(red: 251.0 / 256, green: 251.0 / 256, blue: 251.0 / 256, alpha: 1)
    }
}


extension TimeInputView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerContainerView = UIView()
        let pickerLabel = UILabel()
        pickerLabel.font = UIFont.systemFont(ofSize: 23)
        pickerLabel.textColor = UIColor.black
        pickerLabel.backgroundColor = .clear
        pickerLabel.textAlignment = .left
        pickerLabel.text = "\(timeList[row])"
        pickerContainerView.addSubview(pickerLabel)
        pickerLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        return pickerContainerView
    }
}

extension TimeInputView: UIPickerViewDelegate {
    
}
