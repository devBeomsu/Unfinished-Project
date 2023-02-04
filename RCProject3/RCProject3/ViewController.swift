//
//  ViewController.swift
//  RCProject3
//
//  Created by Steve on 2022/11/06.
//

import UIKit

class ViewController: UIViewController {
    
    var countTimer: Timer?
    var counter: Int = 100
    
    var nextNum: Int = 1
    
    let firstRandomNumber = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"]
    let secondRandomNumber = ["26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50"]
    
    @IBOutlet var allButtons: [UIButton]!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var nextNumber: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func startGame() {
        
    }
    
    func restartGame() {
        
    }
    
    func changeNextNumber() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.nextNumber.text = "\(self.nextNum)"
            }
        }
    }
    
    func firstTile() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                for (_, button) in self.allButtons.enumerated() {
                    button.setTitle("\(String(describing: self.firstRandomNumber.randomElement()))", for: .normal)
                }
            }
        }
    }
    
    func checkSame(_ tile: String) {
        
    }
    
    @IBAction func startButton(_ sender: UIButton) {
        if (sender.titleLabel?.text == "1") {
            print("Game start")
            nextNum += 1
            changeNextNumber()
        } else {
            print("nil")
        }
    }

    @IBAction func restartButtonDidTap(_ sender: UIButton) {
        
    }
}

