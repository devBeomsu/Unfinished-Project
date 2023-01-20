//
//  GameViewController.swift
//  AvoidingPoop
//
//  Created by Steve on 2022/11/07.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    @IBOutlet weak var character: UIImageView!
    @IBOutlet weak var land: UIView!
    
    @IBOutlet weak var gameOverView: UIView!
    
//    let rankManager = RankManager.shared
    let width = UIScreen.main.bounds.width
    let height = UIScreen.main.bounds.height
    var poopLimit = 100
    var image = 1
    var mode: Int!
    var score = 0
    var poops = 0
    var dead = false
    
    // MARK: - 상태바 가림
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(draggingView))
        character.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let emitterLayer = CAEmitterLayer()
            emitterLayer.emitterPosition = CGPoint(x: 200, y: -100)
            let cell = CAEmitterCell()
            cell.birthRate = 20
            cell.lifetime = 500
            cell.velocity = 100
            cell.velocityRange = 50
            cell.emissionRange = CGFloat.pi * 1

            cell.scale = 0.1
            cell.yAcceleration = 100

            cell.contents = UIImage(named: "poop")!.cgImage
            emitterLayer.emitterCells = [cell]

            self.view.layer.addSublayer(emitterLayer)
        }
    }
    
    // MARK: - 캐릭터 드래그 제스쳐 추가
    @objc
    func draggingView(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        let draggedView = sender.view!
        draggedView.center = point
    }
    
    func setPoopDirection(_ down: Bool) {
        DispatchQueue.global(qos: .userInteractive).async {
            while self.dead == false {
                
            }
        }
    }
    
    func rainyPoop() {
        
    }
    
    func startGame() {
        
    }
    
    // MARK: - 점수 변경 함수
    func changeScore() {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.scoreLabel.text = "\(self.score)"
            }
        }
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        
    }
}
