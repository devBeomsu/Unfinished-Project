import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    var email = String()
    var pw = String()
    var userInfo: UserInfo?
    
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func emailTextFieldEditingChanged(_ sender: UITextField) {
        // 옵셔널
        let text = sender.text ?? ""
        
        self.loginButton.backgroundColor = text.isValidEmail() ? .butlerButton : .disabledButton
        
        self.email = text
    }
    
    @IBAction func pwTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        self.loginButton.backgroundColor = text.count > 2 ? .butlerButton : .disabledButton
        
        self.pw = text
    }
    
    @IBAction func loginButtonDidTap(_ sender: UIButton) {
        // 회원가입 정보를 전달 받아서 정보와 Text Field의 데이터가 일치하면 로그인
        guard let userInfo = self.userInfo else { return }
        if userInfo.email == self.email && userInfo.pw == self.pw {
            let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } else {
            
        }
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 화면전환
        // 1. 스토리보드 생성
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 2. 뷰컨트롤러 생성
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        
        // 3. 화면전환 메서드를 이용해서 화면을 전환
//        self.present(registerViewController, animated: true, completion: nil)
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
        // ARC -> 강한참조 / 약한참조 -> ARC 낮춰줌
        registerViewController.userInfo = { [weak self] (userInfo) in
            self?.userInfo = userInfo
        }
    }
}
