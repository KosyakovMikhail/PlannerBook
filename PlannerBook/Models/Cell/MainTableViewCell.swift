//
//  MainTableViewCell.swift
//  PlannerBook
//
//  Created by Macos on 22.11.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    var backgrounViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 10
        return view
    }()
    
    let taskName: UILabel = {
        let label = UILabel()
        label.text = "Попить водички"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next Demi Bold", size: 20)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 4
        return label
    }()
    
    let taskTime: UILabel = {
        let label = UILabel()
        label.text = "12:00"
        label.textColor = .black
        label.font = UIFont(name: "Avenir Next", size: 14)
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 4
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.taskTime.layer.masksToBounds = true
        self.taskName.layer.masksToBounds = true
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented)")
    }
    
    func setConstraints() {
        
        let stackView = UIStackView()
        stackView.addArrangedSubview(taskName)
        stackView.addArrangedSubview(taskTime)
        stackView.axis = .vertical
        stackView.spacing = -4
        stackView.distribution = .fillEqually
        
        self.addSubview(backgrounViewCell)
        backgrounViewCell.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(2)
        }
        
        self.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(backgrounViewCell.snp.left).inset(10)
        }
        
    }
    
}
