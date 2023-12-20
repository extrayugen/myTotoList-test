import UIKit
import Lottie

class AniViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LottieAnimationView(name: "Animation-todolist")
        
        // 애니메이션 뷰의 크기
        let animationSize = CGSize(width: view.bounds.width * 0.5, height: view.bounds.height * 0.5)
        animationView.frame = CGRect(x: 0, y: 0, width: animationSize.width, height: animationSize.height)
        
        // 화면 중앙에 애니메이션 뷰를 위치시킵니다.
        animationView.center = view.center

        animationView.contentMode = .scaleAspectFill
        view.addSubview(animationView)
        
        animationView.play { [weak self] (finished) in
            if finished {
                self?.showTodoListScreen()
            }
        }
    }
    
    func showTodoListScreen() {
        if let todoListViewController = storyboard?.instantiateViewController(withIdentifier: "TodoListViewController") as? TodoListViewController {
            // TodoListViewController로 화면 전환
            navigationController?.pushViewController(todoListViewController, animated: true)
        }
    }
}
