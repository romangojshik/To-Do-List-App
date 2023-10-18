//
//  ContentTableViewCell.swift
//  To-Do List App
//
//  Created by Roman on 10/16/23.
//

import SnapKit

final class ContentTableViewCell: UITableViewCell {
    // MARK: - Public Properties
    
    static let identifier = "ContentTableViewCell"
    var checkButtonAction: ((Bool) -> ())?
    
    // MARK: - Subview Properties
    
    private lazy var horizontalStackView = UIStackView()
    
    private lazy var containerTitleLabel = UIView()
    
    private lazy var titleLabel = UILabel()
    
    private lazy var containerCheckButton = UIView()
    
    private lazy var checkButton = UIButton()
    
    // MARK: - Private Properties
    
    private var isComplete = false
    
    // MARK: - UIView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    public required init?(coder: NSCoder) { nil }
    
    // MARK: - Public Methods
    
    public func setupCell(contentViewModel: ContentViewModel) {
        titleLabel.text = contentViewModel.name
        isComplete = contentViewModel.isComplete
        configureCheckButton(isComplete: isComplete)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        setupSubviews()
        addSubviews()
        makeConstraints()
    }
    
    private func setupSubviews() {
        // horizontalStackView
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.spacing = 15
        
        // checkButton
        checkButton.setImage(UIImage(named: "notCompleted"), for: .normal)
        checkButton.imageView?.contentMode = .scaleAspectFit
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    
    private func addSubviews() {
        containerTitleLabel.addSubview(titleLabel)
        containerCheckButton.addSubview(checkButton)
        horizontalStackView.addArrangedSubview(containerTitleLabel)
        horizontalStackView.addArrangedSubview(containerCheckButton)
        contentView.addSubview(horizontalStackView)
    }
    
    private func makeConstraints() {
        horizontalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(15)
        }
        
        containerCheckButton.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
        
        checkButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureCheckButton(isComplete: Bool) {
        if isComplete {
            checkButton.setImage(UIImage(named: "completed"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: "notCompleted"), for: .normal)
        }
    }
    
    @objc private func checkButtonTapped() {
        if isComplete == false {
            isComplete = true
        } else {
            isComplete = false
        }
        configureCheckButton(isComplete: isComplete)
        checkButtonAction?(isComplete)
    }
}
