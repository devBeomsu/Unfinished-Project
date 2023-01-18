import UIKit
import AudioToolbox

enum TimerStatus {
    case start
    case pause
    case end
}

class TimePickerViewController: UIViewController {
    
    @IBOutlet weak var dryerStatus: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var duration = 60
    var timerStatus: TimerStatus = .end
    var timer: DispatchSourceTimer?
    var currentSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureToggleButton()
    }
    
    func setTimerInfoViewVisible(isHidden: Bool) {
        self.timeLabel.isHidden = isHidden
        self.progressView.isHidden = isHidden
    }
    
    func configureToggleButton() {
        self.startButton.setTitle("시작", for: .normal)
        self.startButton.setTitle("일시정지", for: .selected)
    }
    
    func startTimer() {
        
        if self.timer == nil {
            self.timer = DispatchSource.makeTimerSource(flags: [], queue: .main)
            self.timer?.schedule(deadline: .now(), repeating: 1)
            self.timer?.setEventHandler(handler: { [weak self] in
                guard let self = self else { return }
                self.currentSeconds -= 1
                let hour = self.currentSeconds / 3600
                let minutes = (self.currentSeconds % 3600) / 60
                let seconds = (self.currentSeconds % 3600) % 60
                self.timeLabel.text = String(format: "%02d:%02d:%02d", hour, minutes, seconds)
                self.progressView.progress = Float(self.currentSeconds) / Float(self.duration)
                UIView.animate(withDuration: 0.5, delay: 0, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi / 80)
                })
                UIView.animate(withDuration: 0.5, delay: 0.5, animations: {
                    self.imageView.transform = CGAffineTransform(rotationAngle: .pi / -80)
                })
                
                if self.currentSeconds == 0 {
                    self.stopTimer()
                    AudioServicesPlaySystemSound(1005)
                    self.imageView.image = UIImage(named: "Pause")
                    self.dryerStatus.text = "사용 가능!😊"
                } else if self.currentSeconds > 0 {
                    self.imageView.image = UIImage(named: "Running")
                    self.dryerStatus.text = "사용 중!😎"
                    self.dryerStatus.backgroundColor = .orange
                }
            
                if self.timerStatus == .end {
                    self.dryerStatus.backgroundColor = UIColor(named: "Status")
                }
                
            })
            self.timer?.resume()
        }
    }
    
    func stopTimer() {
        if self.timerStatus == .pause {
            self.timer?.resume()
        }
        self.timerStatus = .end
        self.cancelButton.isEnabled = false
        UIView.animate(withDuration: 0.5, animations: {
            self.timeLabel.alpha = 0
            self.progressView.alpha = 0
            self.timePicker.alpha = 1
            self.imageView.transform = .identity
        })
        self.startButton.isSelected = false
        self.timer?.cancel()
        self.timer = nil
    }
    
    @IBAction func tapCancelButton(_ sender: UIButton) {
        
        switch self.timerStatus {
        case .start, .pause:
            self.stopTimer()
            self.dryerStatus.text = "사용 가능!😊"
            self.dryerStatus.backgroundColor = UIColor(named: "Status")
            self.imageView.image = UIImage(named: "Pause")
            
        default:
            break
        }
        
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        
        self.duration = Int(self.timePicker.countDownDuration)
        switch self.timerStatus {
        case .end:
            self.currentSeconds = self.duration
            self.timerStatus = .start
            UIView.animate(withDuration: 0.5, animations: {
                self.timeLabel.alpha = 1
                self.progressView.alpha = 1
                self.timePicker.alpha = 0
            })
            self.startButton.isSelected = true
            self.cancelButton.isEnabled = true
            self.startTimer()
            
        case .start:
            self.timerStatus = .pause
            self.startButton.isSelected = false
            self.timer?.suspend()
            
        case .pause:
            self.timerStatus = .start
            self.startButton.isSelected = true
            self.timer?.resume()
        }
    }
    
    @IBAction func selectDryer(_ sender: UISegmentedControl) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        let generator2 = UIImpactFeedbackGenerator(style: .medium)
        generator2.impactOccurred()
    }
    
}
