import UIKit
import Lottie

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    var todos = [Todo]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Data Initialization
        
        // Todo 데이터 초기화 (테스트 데이터 추가)
        todos.append(Todo(title: "첫 번째 할일", isCompleted: false))
        todos.append(Todo(title: "두 번째 할일", isCompleted: true))
        
        // MARK: UITableView Configuration
        
        // UITableView 설정
        tableView.dataSource = self
        tableView.delegate = self
    }
    // MARK: - UITableView Data Source Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath)
        
        // MARK: - Todo Cell Configuration
        
        // Todo의 완료 여부에 따라 체크마크 표시 및 텍스트 스타일 변경
        let todo = todos[indexPath.row]
        if todo.isCompleted {
            cell.accessoryType = .checkmark
            cell.textLabel?.attributedText = NSAttributedString(
                string: todo.title,
                attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue]
            )
        } else {
            cell.accessoryType = .none
            cell.textLabel?.attributedText = NSAttributedString(
                string: todo.title,
                attributes: [:]
            )
        }
        
        return cell
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Todo를 선택했을 때의 동작 구현 (완료/미완료 토글)
        todos[indexPath.row].isCompleted.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 사용자가 삭제 동작을 수행했을 때
            
            // MARK: - Todo Deletion
            
            todos.remove(at: indexPath.row) // 해당 항목을 배열에서 제거
            tableView.deleteRows(at: [indexPath], with: .fade) // TableView에서 해당 행 삭제
        }
    }
    
    // MARK: - Action Methods
    
    // Todo 추가 버튼 액션 메서드
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "할 일 추가", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "할 일 입력"
        }
        
        let addAction = UIAlertAction(title: "추가", style: .default) { [weak self] _ in
            if let textField = alertController.textFields?.first, let title = textField.text {
                
                // MARK: - Todo Addition
                
                // 입력된 Todo를 배열에 추가
                let newTodo = Todo(title: title, isCompleted: false)
                self?.todos.append(newTodo)
                self?.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
