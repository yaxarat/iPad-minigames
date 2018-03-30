//
//  TimerDelegate.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/27/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class Time {
    var timer = Timer()
    var seconds: Int
    var minutesImg: UIImage?
    var secondsImg: UIImage?
    var seconds1Img: UIImage?

    let timeImageArray: [UIImage] = [
        UIImage(named: "cartoon-number-0")!,
        UIImage(named: "cartoon-number-1")!,
        UIImage(named: "cartoon-number-2")!,
        UIImage(named: "cartoon-number-3")!,
        UIImage(named: "cartoon-number-4")!,
        UIImage(named: "cartoon-number-5")!,
        UIImage(named: "cartoon-number-6")!,
        UIImage(named: "cartoon-number-7")!,
        UIImage(named: "cartoon-number-8")!,
        UIImage(named: "cartoon-number-9")!
    ]
    
    init(seconds: Int){
        self.seconds = seconds
    }
    
    func updateImages(time: TimeInterval){
        let min = Int(time)/60 % 60
        let sec = Int(time) % 60 / 10
        let sec1 = Int(time) % 60 % 10
        
        self.minutesImg = timeImageArray[min]
        self.secondsImg = timeImageArray[sec]
        self.seconds1Img = timeImageArray[sec1]
    }

    func formatedTime(time:TimeInterval) -> String {
        let minutes = Int(time)/60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i",minutes,seconds)
        
    }
}
