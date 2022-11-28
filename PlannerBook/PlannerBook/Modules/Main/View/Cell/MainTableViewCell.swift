//
//  MainTableViewCell.swift
//  PlannerBook
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    static let cellIdentifier: String = "MainTableViewCell"
    
    private let testTaskNameLabel = "Попить водички"
    private let testTaskTimeLabel = "12:00"
    
    private let taskNameLabelFontName = "Avenir Next Demi Bold"
    private let taskTimeLabelFontName = "Avenir Next"
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var taskNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = testTaskNameLabel
        label.textColor = .black
        label.font = UIFont(name: taskNameLabelFontName, size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var taskTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = testTaskTimeLabel
        label.textColor = .black
        label.font = UIFont(name: taskTimeLabelFontName, size: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainTableViewCell.init(coder: has not been implemented)")
    }
    
    func setConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
        stackView.addArrangedSubview(taskNameLabel)
        stackView.addArrangedSubview(taskTimeLabel)
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
}
