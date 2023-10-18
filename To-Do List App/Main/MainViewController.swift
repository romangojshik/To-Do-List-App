//
//  MainViewController.swift
//  To-Do List App
//
//  Created by Roman on 10/16/23.
//

import UIKit

struct Constants {
    struct TaskName {
        static let task1 = "Wake up at 6 am"
        static let task2 = "Done exercises"
        static let task3 = "Had breakfast"
        
    }
    struct AlertViewText {
        static let addNewTask = "Add New Task"
        static let enterTaskName = "Enter task name"
        static let create = "Create"
        static let cancel = "Cancel"
    }
}

class MainViewController: UIViewController {
    // MARK: - Subview Properties
    
    private lazy var contentView = ContentView()
    
    // MARK: - Private Properties
    
    private var viewModels = [ContentViewModel]()
    private var nameNewTask = "" {
        willSet {
            addNewTask(name: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commonInit()
        makeViewModel()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        view.backgroundColor = .white
        setupSubviews()
        addSubviews()
        makeConstraints()
    }
    
    private func setupSubviews() {
        // contentView
        contentView.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(contentView)
    }
    
    private func makeConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func makeViewModel() {
        viewModels = [
            ContentViewModel(id: 0, name: Constants.TaskName.task1, isComplete: false),
            ContentViewModel(id: 1, name: Constants.TaskName.task2, isComplete: false),
            ContentViewModel(id: 2, name: Constants.TaskName.task3, isComplete: false),
        ]
        contentView.setupContentView(contentViewModels: viewModels)
    }
    
    private func addNewTask(name: String) {
        let randomNumber = arc4random()
        
        viewModels.append(ContentViewModel(id: Int(randomNumber), name: name, isComplete: false))
        contentView.reloadView(contentViewModels: viewModels)
    }
    
    private func showAlertScreen() {
        let alertController = UIAlertController(title: Constants.AlertViewText.addNewTask, message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField) -> Void in
            textField.placeholder = Constants.AlertViewText.enterTaskName
        }
        let saveAction = UIAlertAction(title: Constants.AlertViewText.create, style: .default, handler: { alert -> Void in
            guard let firstTextField = alertController.textFields?[0] else { return }
            guard let text = firstTextField.text else { return }
            self.nameNewTask = text
        })
        let cancelAction = UIAlertAction(
            title: Constants.AlertViewText.cancel,
            style: .default,
            handler: { (action : UIAlertAction) -> Void in }
        )
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - ContentViewProtocol

extension MainViewController: ContentViewProtocol {
    func creatNewTask() {
        showAlertScreen()
    }
    
    func deleteTask(id: Int) {
        let filteredViewModels = viewModels.filter{ $0.id != id }
        viewModels = filteredViewModels
        contentView.reloadView(contentViewModels: filteredViewModels)
    }
    
    func completeTask(id: Int, isComplete: Bool) {
        let filteredViewModels = viewModels.first(where: {$0.id == id})
        filteredViewModels?.isComplete = isComplete
    }
}
