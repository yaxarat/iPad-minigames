//
//  BaloonGameVC.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/27/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class BalloonGameVC: UIViewController {

    let seconds = UIImageView(frame: CGRect(x: 180, y: 80, width: 20, height: 30))
    let seconds1 = UIImageView(frame: CGRect(x: 210, y: 80, width: 20, height: 30))
    let minutes = UIImageView(frame: CGRect(x: 140, y: 80, width: 20, height: 30))
    let scoreImg = UIImageView(frame: CGRect(x:895, y:75, width: 20, height: 30))
    let score1Img = UIImageView(frame: CGRect(x:925, y:75, width: 20, height: 30))
    let score2Img = UIImageView(frame: CGRect(x:955, y:75, width: 20, height: 30))
    let score3Img = UIImageView(frame: CGRect(x:985, y:75, width: 20, height: 30))

    var thisDifficulty = GameSelector()
    var balloonViews = [UIImageView]()
    var numberViews = [UIImageView]()
    var time = Time(seconds: 0)
    var balloonTimer = Timer()
    var balloonTimerSeconds = 0
    var starTimer = Timer()
    var starSeconds = 0
    var scoreTimer = Timer()
    var scoreSeconds = 0
    var finalScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func allSetupProcess() {
        startTime()
        addBackgroundImage()
    }

    func startTime() {
        //time = setUpTimer()
        //time.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(BalloonGameVC.updateTimeUI)), userInfo: nil, repeats: true)
    }

    func addBackgroundImage() {
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named:"sky-background")
        self.view.addSubview(background)

        timeUI()
        scoreUI()
    }

    // Countdown Timer interface
    func timeUI() {
        let area = UIImageView(frame: CGRect(x: 40, y: 80, width: 50, height: 30))
        area.contentMode = .scaleAspectFill
        area.image = UIImage(named: "time")!
        self.view.addSubview(area)

        minutes.contentMode = .scaleAspectFill
        minutes.image = time.minutesImg
        self.view.addSubview(minutes)

        seconds.contentMode = .scaleAspectFill
        seconds.image = time.secondsImg
        self.view.addSubview(seconds)

        seconds1.contentMode = .scaleAspectFill
        seconds1.image = time.seconds1Img
        self.view.addSubview(seconds1)
    }

    func scoreUI(){
        let area = UIImageView(frame: CGRect(x:800, y: 80, width: 80, height: 30))
        area.contentMode = .scaleAspectFill
        area.image = UIImage(named:"score")
        self.view.addSubview(area)

        scoreImg.contentMode = .scaleAspectFill
        score1Img.contentMode = .scaleAspectFill
        score2Img.contentMode = .scaleAspectFill
        score3Img.contentMode = .scaleAspectFill

        scoreImg.image = numberImageArray[finalScore / 100]
        score1Img.image = numberImageArray[finalScore % 100]
        score2Img.image = numberImageArray[finalScore / 10]
        score3Img.image = numberImageArray[finalScore % 10]

        self.view.addSubview(scoreImg)
        self.view.addSubview(score1Img)
        self.view.addSubview(score2Img)
        self.view.addSubview(score3Img)
    }
}
