import SwiftUI
import UIKit

struct HomeViewControllerWrapper: UIViewControllerRepresentable {
    @Binding var isUserLoggedIn: Bool

    func makeUIViewController(context: Context) -> HomeViewController {
        let homeVC = HomeViewController()
        homeVC.onLogout = {
            isUserLoggedIn = false
        }
        return homeVC
    }

    func updateUIViewController(_ uiViewController: HomeViewController, context: Context) {
        // 필요 시 업데이트
    }
}
