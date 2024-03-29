//
//  RegisterTime.swift
//  DDip
//
//  Created by 안상희 on 2022/08/31.
//  Copyright © 2022 dvHuni. All rights reserved.
//

import Foundation

enum RegisterTime: String, CaseIterable {
    case _5 = "5분"
    case _10 = "10분"
    case _20 = "20분"
    case _30 = "30분"
    case _60 = "1시간"
    case _90 = "1시간 30분"
    case _120 = "2시간"
    case _150 = "2시간 30분"
    case _180 = "3시간"
    case _210 = "3시간 30분"
    case _240 = "4시간"
    case _270 = "4시간 30분"
    case _300 = "5시간"
    case _330 = "5시간 30분"
    case _360 = "6시간"
    case _390 = "6시간 30분"
    case _420 = "7시간"
    case _450 = "7시간 30분"
    case _480 = "8시간"
    case _510 = "8시간 30분"
    case _540 = "9시간"
    case _570 = "9시간 30분"
    case _600 = "10시간"
    case _630 = "10시간 30분"
    case _660 = "11시간"
    case _690 = "11시간 30분"
    case _720 = "12시간"
    case _750 = "12시간 30분"
    case _780 = "13시간"
    case _810 = "13시간 30분"
    case _840 = "14시간"
    case _870 = "14시간 30분"
    case _900 = "15시간"
    case _930 = "15시간 30분"
    case _960 = "16시간"
    case _990 = "16시간 30분"
    case _1020 = "17시간"
    case _1050 = "17시간 30분"
    case _1080 = "18시간"
    case _1110 = "18시간 30분"
    case _1140 = "19시간"
    case _1170 = "19시간 30분"
    case _1200 = "20시간"
    case _1230 = "20시간 30분"
    case _1260 = "21시간"
    case _1290 = "21시간 30분"
    case _1320 = "22시간"
    case _1350 = "22시간 30분"
    case _1380 = "23시간"
    case _1410 = "23시간 30분"
    case _1440 = "24시간"
    
    var description: Int {
        switch self {
        case ._5:
            return 5
        case ._10:
            return 10
        case ._20:
            return 20
        case ._30:
            return 30
        case ._60:
            return 60
        case ._90:
            return 90
        case ._120:
            return 120
        case ._150:
            return 150
        case ._180:
            return 180
        case ._210:
            return 210
        case ._240:
            return 240
        case ._270:
            return 270
        case ._300:
            return 300
        case ._330:
            return 330
        case ._360:
            return 360
        case ._390:
            return 390
        case ._420:
            return 420
        case ._450:
            return 450
        case ._480:
            return 480
        case ._510:
            return 510
        case ._540:
            return 540
        case ._570:
            return 570
        case ._600:
            return 600
        case ._630:
            return 630
        case ._660:
            return 660
        case ._690:
            return 690
        case ._720:
            return 720
        case ._750:
            return 750
        case ._780:
            return 780
        case ._810:
            return 810
        case ._840:
            return 840
        case ._870:
            return 870
        case ._900:
            return 900
        case ._930:
            return 930
        case ._960:
            return 960
        case ._990:
            return 990
        case ._1020:
            return 1020
        case ._1050:
            return 1050
        case ._1080:
            return 1080
        case ._1110:
            return 1110
        case ._1140:
            return 1140
        case ._1170:
            return 1170
        case ._1200:
            return 1200
        case ._1230:
            return 1230
        case ._1260:
            return 1260
        case ._1290:
            return 1290
        case ._1320:
            return 1320
        case ._1350:
            return 1350
        case ._1380:
            return 1380
        case ._1410:
            return 1410
        case ._1440:
            return 1440
        }
    }
}
