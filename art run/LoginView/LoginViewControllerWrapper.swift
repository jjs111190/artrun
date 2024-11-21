import SwiftUI

// LoginViewController를 SwiftUI에서 사용할 수 있도록 감싸는 Wrapper
struct LoginViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isUserLoggedIn: Bool // Binding<Bool>으로 변경

    func makeUIViewController(context: Context) -> LoginViewController {
        let loginVC = LoginViewController()
        // isUserLoggedIn을 loginVC에 전달하거나 로그인 상태에 따라 동작 변경 가능
        loginVC.onLoginSuccess = {
            // 로그인 성공 후 상태 업데이트
            self.isUserLoggedIn = true
        }
        return loginVC
    }

    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
        // 필요에 따라 UI 업데이트 처리
    }
}
