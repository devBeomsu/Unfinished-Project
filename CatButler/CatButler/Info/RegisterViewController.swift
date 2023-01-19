import UIKit

class RegisterViewController: UIViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    // MARK: - Properties
    var name: String = ""
    var nickname: String = ""
    var email: String = ""
    var pw: String = ""
    
    var userInfo: ((UserInfo) -> Void)?
    
    // 유효성 검사를 위한 프로퍼티
    var isValidName = false {
        didSet { // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    var isValidNickname = false {
        didSet { // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    var isValidEmail = false {
        didSet { // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    var isValidPw = false {
        didSet { // 프로퍼티 옵저버
            self.validateUserInfo()
        }
    }
    
    // Text Fields
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var nicknameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var pwTextField: UITextField!
    
    var textFields: [UITextField] {
        [nameTextField, nicknameTextField, emailTextField, pwTextField]
    }
    
    // Button
    @IBOutlet weak var signUpButton: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextField()
        
        // Bug Fix
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // MARK: - Actions
    @objc
    func textFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        
        switch sender {
        case nameTextField:
            self.isValidName = text.count > 2
            self.name = text
            
        case nicknameTextField:
            self.isValidNickname = text.count > 2
            self.nickname = text
            
        case emailTextField:
            self.isValidEmail = text.isValidEmail()
            self.email = text
            
        case pwTextField:
            self.isValidPw = text.isValidPw()
            self.pw = text
            
        default:
            fatalError("Missing Text Field...")
        }
    }

    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        // 뒤로가기
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonDidTap(_ sender: UIButton) {
        // 뒤로가기
        self.navigationController?.popViewController(animated: true)
        
        let userInfo = UserInfo(
            name: self.name,
            nickname: self.nickname,
            email: self.email,
            pw: self.pw)
        
        self.userInfo?(userInfo)
    }
    
    
    
    // MARK: - Helpers
    private func setUpTextField() {
        
        textFields.forEach { tf in
            tf.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        }
    }
    
    private func validateUserInfo() {
        
        if isValidName && isValidNickname && isValidEmail && isValidPw {
            self.signUpButton.isEnabled = true
            UIView.animate(withDuration: 0.33) {
                self.signUpButton.backgroundColor = UIColor.butlerButton
            }
        } else {
            self.signUpButton.isEnabled = false
            UIView.animate(withDuration: 0.33) {
                self.signUpButton.backgroundColor = UIColor.disabledButton
            }
        }
        
    }
}
    

// 정규표현식
extension String {

    // @ 2글자
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: self)
    }

    // 대문자, 소문자, 특수문자, 숫자 8자 이상일 때 -> True
    func isValidPw() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)

        return passwordValidation.evaluate(with: self)
    }
    
}
