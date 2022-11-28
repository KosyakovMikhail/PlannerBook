//
//  TaskTicketView.swift
//  PlannerBook
//

import UIKit

final class TaskTicketView: UIView {
    
    weak var delegate: TaskTicketDelegate?
    
    private let taskId: String
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont(name: FontNames.mainBold, size: 20)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont(name: FontNames.main, size: 16)
        label.textAlignment = .left
        return label
    }()
    
    convenience init(model: TaskTicketModel) {
        self.init(taskId: model.id)
        titleLabel.text = model.title
        timeLabel.text = model.time
        containerView.backgroundColor = model.color.withAlphaComponent(0.4)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        containerView.addGestureRecognizer(tapGesture)
        
        setConstraints()
    }
    
    init(taskId: String) {
        self.taskId = taskId
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(timeLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.bottom.equalToSuperview().offset(-12)
        }
    }
    
    @objc func didTap() {
        delegate?.ticketTapped(id: taskId)
    }
}
