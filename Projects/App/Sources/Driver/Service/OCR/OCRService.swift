//
//  OCRService.swift
//  GGiriGGiri
//
//  Created by AhnSangHoon on 2022/08/10.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

protocol OCRServiceLogic {
    typealias ResultResponse = ResponseData<OCRResponseModel>
    
    func request(_ model: OCRRequestModel) -> ResultResponse
}

struct OCRService: OCRServiceLogic {
    private let network: Networking
    
    init(network: Networking) {
        self.network = network
    }
    
    func request(_ model: OCRRequestModel) -> ResultResponse {
        network.requestMultipartFormData(OCRAPI.request(model)).map()
    }
}
