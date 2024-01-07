//
//  SheduleCell.swift
//  Tracker
//
//  Created by Эмилия on 17.10.2023.
//

import UIKit

class SheduleCell: UITableViewCell {
//MARK: - Properties
    static let reuseIdentifier = "SheduleCell"
    
    weak var delegate: SheduleViewController?
    
    private var day: WeekDay?
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.blackDay
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.addTarget(
            self,
            action: #selector(didTapSwitcher),
            for: .valueChanged)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        return switcher
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Methods
    func configureCell(day: WeekDay, isSwitch: Bool) {
        self.day = day
        dayLabel.text = day.rawValue
        switcher.isOn = isSwitch
    }
    
//MARK: - Private methods
    private func setupCell() {
        addViews()
        layoutViews()
    }
    
    private func addViews() {
        contentView.addSubview(dayLabel)
        contentView.addSubview(switcher)
    }

}

//MARK: - Extension
@objc extension SheduleCell {

    private func layoutViews() {
        NSLayoutConstraint.activate([
            dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func didTapSwitcher() {
        guard let day = day else {return}
        delegate?.addDay(day, isOn: switcher.isOn)
    }
}
