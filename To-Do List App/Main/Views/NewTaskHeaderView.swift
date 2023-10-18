//
//  NewTaskTableHeaderView.swift
//  To-Do List App
//
//  Created by Roman on 10/18/23.
//

import SnapKit

class NewTaskHeaderView: UIView {
    // MARK: - Public Properties
    
    static let identifier = "ContentTableViewCell"
    var addButtonAction: (() -> ())?
    
    // MARK: - Subview Properties
    
    private lazy var horizontalStackView = UIStackView()
    
    private lazy var containerTitleLabel = UIView()
    
    private lazy var titleLabel = UILabel()
    
    private lazy var containerAddButton = UIView()
    
    private lazy var addButton = UIButton()
    
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
    
    public func setupCell(contentViewModel: ContentViewModel) {
        titleLabel.text = contentViewModel.name
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        setupSubviews()
        addSubviews()
        makeConstraints()
        backgroundColor = .lightGray
    }
    
    private func setupSubviews() {
        // horizontalStackView
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 15
        
        // titleLabel
        titleLabel.text = "Add a new task"
        
        // checkButton
        addButton.setImage(UIImage(named: "add"), for: .normal)
        addButton.imageView?.contentMode = .scaleAspectFit
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    private func addSubviews() {
        containerTitleLabel.addSubview(titleLabel)
        containerAddButton.addSubview(addButton)
        horizontalStackView.addArrangedSubview(containerTitleLabel)
        horizontalStackView.addArrangedSubview(containerAddButton)
        addSubview(horizontalStackView)
    }
    
    private func makeConstraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        containerTitleLabel.snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        containerAddButton.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.width.equalTo(50)
        }
        
        addButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
    }
    
    @objc private func addButtonTapped() {
        addButtonAction?()
    }
}

