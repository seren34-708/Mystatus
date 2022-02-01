import UIKit

class InputViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var test: UILabel!
    
    var todoList = [String]()
    var selectedText = String()
    let userDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        if let storedTodoList = userDefaults.array(forKey: "todoList") as? [String] {
                todoList.append(contentsOf: storedTodoList)
        }
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = self.storyboard!
//
////        selectedText = todoList[indexPath.row]
////        let next = storyboard.instantiateViewController(withIdentifier: "RecordTimeViewController") as! RecordTimeViewController
////        next.outputValue = selectedText
////        performSegue(withIdentifier: "RecordTimeViewController", sender: nil)
////        test.text = selectedText
////        self.present(next, animated: true)
////
//        test.text = todoList[indexPath.row]
//        guard let next = storyboard.instantiateViewController(identifier: "RecordTimeViewController") as? RecordTimeViewController else { return }
//        next.outputValue = todoList[indexPath.row]
//        self.performSegue(withIdentifier: "RecordTimeViewController", sender: nil)
//    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedText = todoList[indexPath.row]
//        test.text = selectedText
    }
    
//    RecordTimeViewControllerへ値渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        test.text = selectedText

        if segue.identifier == "RecordTimeViewController" {
            let next = segue.destination as? RecordTimeViewController
            next?.outputValue = selectedText
        }
    }
    

    //UITableViewDataSource　リストのカウント
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    //UITableViewDelegate　リストの表示
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // セルに表示する値を設定する
        cell.textLabel!.text = todoList[indexPath.row]
        return cell
    }
    
    //リストの追加
    @IBAction func addBtnAction(_ sender: Any){
        let alertController = UIAlertController(title: "ToDo追加", message: "ToDoを入力してください。", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField(configurationHandler: nil)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { (acrion: UIAlertAction) in
            //OKをタップした時の処理
            if let textField = alertController.textFields?.first {
                self.todoList.insert(textField.text!, at: 0)
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableView.RowAnimation.right)
                //ToDoを保存
                self.userDefaults.set(self.todoList, forKey: "todoList")
            }
        }
        alertController.addAction(okAction)
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(cancelButton)
        present(alertController, animated: true, completion: nil)
    }
    
    //リストの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            userDefaults.set(todoList, forKey: "todoList")
        }
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
