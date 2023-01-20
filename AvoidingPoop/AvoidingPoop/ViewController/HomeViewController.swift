//
//  HomeViewController.swift
//  AvoidingPoop
//
//  Created by Steve on 2022/11/09.
//

import UIKit

class HomeViewController: UIViewController {
    
    var mode = 0
    
    @IBOutlet weak var modeLabel: UILabel!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        guard let gameVC = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        gameVC.mode = self.mode
        gameVC.modalPresentationStyle = .fullScreen
        present(gameVC, animated: true)
    }
    
    @IBAction func leftModeButtonDidTap(_ sender: UIButton) {
        switch mode {
        case 1:
            mode = 0
            modeLabel.text = "쉬움"
        case 2:
            mode = 1
            modeLabel.text = "중간"
        default:
            break
        }
    }
    
    @IBAction func rightModeButtonDidTap(_ sender: UIButton) {
        switch mode {
        case 0:
            mode = 1
            modeLabel.text = "중간"
        case 1:
            mode = 2
            modeLabel.text = "어려움"
        default:
            break
        }
    }
}
