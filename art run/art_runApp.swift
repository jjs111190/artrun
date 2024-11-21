import SwiftUI
import Firebase

@main
struct art_runApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @State private var isUserLoggedIn: Bool = false // 로그인 상태 관리

    var body: some Scene {
        WindowGroup {
            if isUserLoggedIn {
                // HomeViewControllerWrapper에 isUserLoggedIn을 Binding<Bool>으로 전달
                HomeViewControllerWrapper(isUserLoggedIn: $isUserLoggedIn) // 홈 화면
            } else {
                // LoginViewControllerWrapper에 isUserLoggedIn을 Binding<Bool>으로 전달
                LoginViewControllerWrapper(isUserLoggedIn: $isUserLoggedIn) // 로그인 화면
            }
        }
    }
}

