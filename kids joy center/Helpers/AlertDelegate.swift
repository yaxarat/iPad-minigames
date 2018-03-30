//
//  AlertDelegate.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/28/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class AlertMessage {
    var viewController: UIViewController?
    var score = 0
    init(viewController: UIViewController, score: Int){
        self.viewController = viewController
        self.score = score
    }

    func presentWinAlert() {
        let alert = UIAlertController(title: "Great Job", message: "Your Score Was: \(score)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Return to Menu", style: .cancel, handler: { action in
            _ = self.viewController!.navigationController?.popViewController(animated: true)

        }))
        self.viewController!.present(alert, animated: true, completion: nil)
    }
    
    func endTimeAlert() {
        let alert = UIAlertController(title: "Ouch!", message: "Time is UP", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Return to Menu", style: .cancel, handler: { action in
            _ = self.viewController!.navigationController?.popViewController(animated: true)
        }))
        self.viewController!.present(alert, animated: true, completion: nil)
    }
}
