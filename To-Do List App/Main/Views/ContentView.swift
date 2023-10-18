//
//  ContentView.swift
//  To-Do List App
//
//  Created by Roman on 10/16/23.
//

import SnapKit

// MARK: - ContentViewProtocol
protocol ContentViewProtocol: AnyObject {
    func creatNewTask()
    func deleteTask(id: Int)
    func completeTask(id: Int, isComplete: Bool)
}

public final class ContentView: UIView {
    // MARK: - Public Properties
    
    weak var delegate: ContentViewProtocol?
    
    // MARK: - Subview Properties
    
    private lazy var newTaskHeaderView = NewTaskHeaderView()
    
    private lazy var tableView = UITableView()
    
    // MARK: - Private Properties
    
    private var viewModels: [ContentViewModel] = []
    
    // MARK: - UIView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func setupContentView(contentViewModels: [ContentViewModel]) {
        viewModels = contentViewModels
    }
    
    public func reloadView(contentViewModels: [ContentViewModel]) {
        viewModels = contentViewModels
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        addSubviews()
        makeConstraints()
        setupSubviews()
    }
    
    private func setupSubviews() {
        // tableView
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.register(
            ContentTableViewCell.self,
            forCellReuseIdentifier: ContentTableViewCell.identifier
        )
        
        // newTaskTableHeaderView
        newTaskHeaderView.addButtonAction = {
            self.delegate?.creatNewTask()
        }
    }
    
    private func addSubviews() {
        addSubview(newTaskHeaderView)
        addSubview(tableView)
    }
    
    private func makeConstraints() {
        newTaskHeaderView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(newTaskHeaderView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension ContentView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ContentTableViewCell.identifier, for: indexPath as IndexPath
        ) as? ContentTableViewCell else {
            fatalError("Error")
        }
        
        cell.selectionStyle = .none
        cell.setupCell(contentViewModel: viewModels[indexPath.row])
        
        let id = viewModels[indexPath.row].id
        cell.checkButtonAction = { [weak self] isComplete in
            guard let self = self else { return }
            self.delegate?.completeTask(id: id, isComplete: isComplete)
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    public func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath)
    {
        if (editingStyle == .delete) {
            let id = viewModels[indexPath.row].id
            delegate?.deleteTask(id: id)
        }
    }
}

