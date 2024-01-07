//
//  CreateHabitViewController.swift
//  Tracker
//
//  Created by Эмилия on 12.10.2023.
//

import UIKit

final class CreateHabitViewController: UIViewController {

//MARK: - Private properties
     private var createHabitLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
        label.textColor = Color.blackDay
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    private var nameHabitTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите название трекера"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.textColor = Color.blackDay
        textField.backgroundColor = Color.backgroundDay
        textField.layer.masksToBounds = true
        textField.layer.cornerRadius = 16
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var menuStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.backgroundColor = Color.backgroundDay
        stackView.layer.masksToBounds = true
        stackView.layer.cornerRadius = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var categoryButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "chevron")
        button.setTitle("Категория", for: .normal)
        button.setTitleColor(Color.blackDay, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        button.setImage(image, for: .normal)
        //СКОРЕЕ ВСЕГО НЕПРАВИЛЬНО
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -430)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(
            self,
            action: #selector(didTapCategoryButton),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let separatorLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Color.gray
        return label
    }()
    
    private let scheduleButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "chevron")
        button.setTitle("Расписание", for: .normal)
        button.setTitleColor(Color.blackDay, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -400)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(
            self,
            action: #selector(didTapSheludeButton),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var cancelButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = Color.red.cgColor
        button.setTitle("Отменить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(Color.red, for: .normal)
        button.addTarget(
            self,
            action: #selector(didTapCancelButton),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    private var createButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.backgroundColor = Color.gray
        button.setTitle("Создать", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(Color.whiteDay, for: .normal)
        button.addTarget(
            self,
            action: #selector(didTapCreateButton),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var shedule: Set<WeekDay> = []
    private var category: String = "Default Category"
    private var color: UIColor = .cyan
    private var emoji: String = "☺️"
    
    
//MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            configure()
        }

        
//MARK: - Private methods
    private func configure() {
        view.backgroundColor = Color.whiteDay
        addViews()
        layoutViews()
    }
    
    func setShedule(_ shedule: Set<WeekDay>) {
        self.shedule = shedule
    }
    
    private func addViews() {
        view.addSubview(createHabitLabel)
        view.addSubview(nameHabitTextField)
        view.addSubview(menuStackView)
        menuStackView.addArrangedSubview(categoryButton)
        menuStackView.addArrangedSubview(separatorLabel)
        menuStackView.addArrangedSubview(scheduleButton)
        view.addSubview(cancelButton)
        view.addSubview(createButton)
    }
}

//MARK: - Extension
@objc extension CreateHabitViewController {
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            createHabitLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            createHabitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameHabitTextField.heightAnchor.constraint(equalToConstant: 75),
            nameHabitTextField.topAnchor.constraint(equalTo: createHabitLabel.bottomAnchor, constant: 38),
            nameHabitTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameHabitTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            menuStackView.topAnchor.constraint(equalTo: nameHabitTextField.bottomAnchor, constant: 24),
            menuStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            menuStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            categoryButton.heightAnchor.constraint(equalToConstant: 75),
            
            separatorLabel.topAnchor.constraint(equalTo: categoryButton.bottomAnchor),
            separatorLabel.heightAnchor.constraint(equalToConstant: 0.5),
            separatorLabel.centerXAnchor.constraint(equalTo: menuStackView.centerXAnchor),
//            separatorLabel.leadingAnchor.constraint(equalTo: menuStackView.leadingAnchor, constant: 16),
//            separatorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            scheduleButton.topAnchor.constraint(equalTo: separatorLabel.bottomAnchor),
            scheduleButton.heightAnchor.constraint(equalToConstant: 75),
            
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            cancelButton.widthAnchor.constraint(equalToConstant: 166),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            createButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 8),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func didTapCategoryButton() {
        
    }
    
    private func didTapSheludeButton() {
        let sheduleViewController = SheduleViewController()
        sheduleViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: sheduleViewController)
        present(navigationController, animated: true)
    }
    
    private func didTapCancelButton() {
        
    }
    
    private func didTapCreateButton() {
        if shedule != [], let name = nameHabitTextField.text {
            let tracker = Tracker(
                name: name,
                color: color,
                emoji: emoji,
                shedule: shedule
            )
        
            StorageManager.shared.addTrackers(tracker: tracker, category: category)
        }
        
        dismiss(animated: true)
    }
}
