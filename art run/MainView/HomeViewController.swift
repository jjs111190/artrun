import UIKit

class HomeViewController: UIViewController {
    var onLogout: (() -> Void)? // 로그아웃 이벤트 처리

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 로그아웃 버튼 추가
        let logoutButton = UIButton(type: .system)
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        logoutButton.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        view.addSubview(logoutButton)
    }

    @objc func handleLogout() {
        onLogout?() // 로그아웃 이벤트 발생
    }
    
}
