//
//  AddTaskTableViewCell.swift
//  PlannerBook
//
//  Created by Macos on 23.11.2022.
//

import UIKit

class AddTaskTableViewCell: UITableViewCell {
    
    let backgrounViewCell: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let nameCellLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cellNameArray = [["DATE", "TIME"], ["NAME", "DESCRIPTION"], [""]]
 
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setConstraints()
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented)")
    }
    
    func setConstraints() {
    
        self.addSubview(backgrounViewCell)
        backgrounViewCell.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(2)
        }
        
        self.addSubview(nameCellLabel)
        nameCellLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(backgrounViewCell.snp.left).inset(10)
        }
    }
}
