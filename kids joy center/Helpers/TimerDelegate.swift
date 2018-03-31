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

    func formatting(time:TimeInterval) -> String {
        let minutes = Int(time)/60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i",minutes,seconds)
        
    }
}
