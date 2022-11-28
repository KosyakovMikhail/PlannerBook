//
//  TimeRangeTableViewCell.swift
//  PlannerBook
//

import UIKit

class TimeRangeTableViewCell: UITableViewCell {
    
    weak var delegate: TimeRangeTableViewCellDelegate?
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var timeRangeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("MainTableViewCell.init(coder: has not been implemented)")
    }
    
    private func setConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(timeRangeLabel)
        containerView.addSubview(separatorLineView)
        containerView.addSubview(stackView)

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        timeRangeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(38)
        }
        
        separatorLineView.snp.makeConstraints { make in
            make.centerY.equalTo(timeRangeLabel)
            make.leading.equalTo(timeRangeLabel.snp.trailing)
                .offset(2)
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(timeRangeLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setup(cellModel: TimeRangeTableViewCellModel) {
        timeRangeLabel.text = cellModel.timeRange
        
        stackView.arrangedSubviews.forEach { subview in
            subview.removeFromSuperview()
        }
        
        for todoItem in cellModel.todoItems {
            addTicketInStackView(for: todoItem)
        }
        
        layoutIfNeeded()
    }
    
    func addTicketInStackView(for todoItem: TaskTicketModel) {
        let todoItemTicket = TaskTicketView(model: todoItem)
        todoItemTicket.delegate = self
        stackView.addArrangedSubview(todoItemTicket)
    }
}

extension TimeRangeTableViewCell: TaskTicketDelegate {
    func ticketTapped(id: String) {
        delegate?.taskTapped(id: id)
    }
}
