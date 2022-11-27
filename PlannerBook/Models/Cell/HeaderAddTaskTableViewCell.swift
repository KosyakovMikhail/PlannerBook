//
//  HeaderAddTaskTableViewCell.swift
//  PlannerBook
//
//  Created by Macos on 23.11.2022.
//

import UIKit

class HeaderAddTaskTableViewCell: UITableViewHeaderFooterView {
    
    let headerNameArray = ["NAME AND DESCRIPTION", "DATE AND TIME", "COLOR"]
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Avenir Next SEMI BOLD", size: 14)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        headerLabel.textColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        
        self.contentView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented)")
    }
    
    func headerConfigure(section: Int) {
        headerLabel.text = headerNameArray[section]
    }
    
    func setConstraints() {
    
        self.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(25)
            make.bottom.equalToSuperview()
        }
    }
}
