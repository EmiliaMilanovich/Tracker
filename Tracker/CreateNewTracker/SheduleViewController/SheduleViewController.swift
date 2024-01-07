//
//  SheduleViewController.swift
//  Tracker
//
//  Created by Эмилия on 16.10.2023.
//

import UIKit

final class SheduleViewController: UIViewController {

    weak var delegate: CreateHabitViewController?
    
    //MARK: - Private properties
    private var weekDayAvailable: Set<WeekDay> = []
    
    private var sheduleLabel: UILabel = {
        let label = UILabel()
        label.text = "Расписание"
        label.textColor = Color.blackDay
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
     
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = Color.backgroundDay
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 16
        tableView.separatorStyle = .singleLine
        tableView.isScrollEnabled = false
        tableView.register(SheduleCell.self, forCellReuseIdentifier: "SheduleCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var completedButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Color.blackDay
        button.layer.cornerRadius = 16
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(Color.whiteDay, for: .normal)
        button.addTarget(
            self,
            action: #selector(didCompletedButton),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.whiteDay
        configure()
    }
    
    func addDay(_ day: WeekDay, isOn: Bool) {
        if isOn {
            weekDayAvailable.insert(day)
        } else {
            weekDayAvailable.remove(day)
        }
    }
    
    
//MARK: - Private methods
    private func configure() {
        addViews()
        layoutViews()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func addViews() {
        view.addSubview(sheduleLabel)
        view.addSubview(tableView)
        view.addSubview(completedButton)
    }
    
    
}
    
//MARK: - Extension
@objc extension SheduleViewController {
    private func layoutViews() {
        NSLayoutConstraint.activate([
            sheduleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sheduleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            tableView.topAnchor.constraint(equalTo: sheduleLabel.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: completedButton.topAnchor, constant: 47),
            completedButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            completedButton.heightAnchor.constraint(equalToConstant: 60),
            completedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            completedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)

        ])
    }
    
    private func didCompletedButton() {
        delegate?.setShedule(weekDayAvailable)
        dismiss(animated: true)
    }
}
//MARK: - UITableViewDataSource
extension SheduleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeekDay.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SheduleCell", for: indexPath) as? SheduleCell
        else { fatalError("Ячейка не создана") }
    
        let day = WeekDay.allCases[indexPath.row]
        
        //TODO: Сделать обновление переключателя
        let isSwitch = false
        
        cell.configureCell(day: day, isSwitch: isSwitch)
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate
extension SheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        75
    }
}
