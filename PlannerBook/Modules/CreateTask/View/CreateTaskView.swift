//
//  CreateTaskView.swift
//  PlannerBook
//

import Foundation
import UIKit

final class CreateTaskView: UIView {
    
    weak var delegate: CreateTaskDelegate?
    
    private let startDateTitle = "Время начала"
    private let finishDateTitle = "Время окончания"
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название задачи"
        label.textColor = .black
        label.font = UIFont(name: FontNames.mainBold, size: 22)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var titleInputTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.isEditable = true
        textView.backgroundColor = .systemGray3.withAlphaComponent(0.4)
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainer.lineFragmentPadding = 10.0
        textView.layer.cornerRadius = 12
        return textView
    }()
    
    private lazy var startDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = startDateTitle
        label.textColor = .black
        label.font = UIFont(name: FontNames.main, size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var startDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .systemGray3.withAlphaComponent(0.4)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var finishDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = finishDateTitle
        label.textColor = .black
        label.font = UIFont(name: FontNames.main, size: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var finishDateButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8.0
        button.backgroundColor = .systemGray3.withAlphaComponent(0.4)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Описание задачи"
        label.textColor = .black
        label.font = UIFont(name: FontNames.mainBold, size: 20)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionInputTextView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.isEditable = true
        textView.backgroundColor = .systemGray3.withAlphaComponent(0.4)
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainer.lineFragmentPadding = 10.0
        textView.layer.cornerRadius = 12
        return textView
    }()
    
    init(startDateString: String, finishDateString: String) {
        super.init(frame: .zero)
        backgroundColor = .white
        let endEditingTapGeture = UITapGestureRecognizer(
            target: self, action: #selector(viewTapped))
        containerView.addGestureRecognizer(endEditingTapGeture)
        startDateButton.setTitle(startDateString, for: .normal)
        finishDateButton.setTitle(finishDateString, for: .normal)
        startDateButton.addTarget(self, action: #selector(startDateButtonTapped), for: .touchUpInside)
        finishDateButton.addTarget(self, action: #selector(finishDateButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [titleLabel,
         titleInputTextView,
         startDateLabel,
         startDateButton,
         finishDateLabel,
         finishDateButton,
         descriptionLabel,
         descriptionInputTextView].forEach {
            containerView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        containerView.snp.makeConstraints { maker in
            maker.edges.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        titleInputTextView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(64)
        }
        
        startDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleInputTextView.snp.bottom).offset(22)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        startDateButton.snp.makeConstraints { make in
            make.centerY.equalTo(startDateLabel)
            make.leading.equalTo(startDateLabel.snp.trailing).offset(18)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.width.equalTo(150)
        }
        
        finishDateLabel.snp.makeConstraints { make in
            make.top.equalTo(startDateLabel.snp.bottom).offset(18)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        finishDateButton.snp.makeConstraints { make in
            make.centerY.equalTo(finishDateLabel)
            make.leading.equalTo(finishDateLabel.snp.trailing).offset(18)
            make.trailing.lessThanOrEqualToSuperview().offset(-16)
            make.width.equalTo(150)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(finishDateLabel.snp.bottom).offset(22)
            make.leading.trailing.equalTo(titleLabel)
        }
        
        descriptionInputTextView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(200)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func startDateButtonTapped() {
        delegate?.startDateTapped()
    }
    
    @objc private func finishDateButtonTapped() {
        delegate?.finishDateTapped()
    }
    
    @objc private func viewTapped() {
        endEditing(true)
    }
}

extension CreateTaskView: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        if textView === titleInputTextView {
            delegate?.titleChanged(text: textView.text)
        } else if textView === descriptionInputTextView {
            delegate?.descriptionChanged(text: textView.text)
        }
    }
}
