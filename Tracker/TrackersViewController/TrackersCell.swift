//
//  TrackersCell.swift
//  Tracker
//
//  Created by Эмилия on 12.10.2023.
//

import UIKit

protocol TrackersCellDelegate: AnyObject {
    func completedTracker(id: String)
    func uncompletedTracker(id: String)
}

final class TrackersCell: UICollectionViewCell {
//MARK: - Properties
    static let identifier = "TrackersCell"
    weak var delegate: TrackersCellDelegate?

//MARK: - Private properties
    private let isCompletedToday = false
    
    private let mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var emojiLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = Color.backgroundDay
        label.clipsToBounds = false
        label.layer.cornerRadius = 16
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var trackerNamelabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.whiteDay
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = Color.whiteDay
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var counterDayLabel: UILabel = {
        let label = UILabel()
//        label.text = "Изучать программирование"
        label.textColor = Color.blackDay
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "plus")
        button.setImage(image, for: .normal)
        button.tintColor = Color.whiteDay
        button.layer.cornerRadius = 16
        button.addTarget(
            self,
            action: #selector(didTapPlusButton),
            for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//MARK: - Methods
    func configureCell(with tracker: Tracker, isCompletedToday: Bool) {
        let color = tracker.color
        setupCell()
        
        mainView.backgroundColor = color
        plusButton.backgroundColor = color
        trackerNamelabel.text = tracker.name
        emojiLabel.text = tracker.emoji
        
        let wordDay = pluralizeDays(1)
        counterDayLabel.text = "\(wordDay)"
        
    }
    
    func pluralizeDays(_ count: Int) -> String {
        //доделать
        let count = 1
        return "\(count) дней"
    }
//MARK: - Private methods
    private func setupCell() {
        addViews()
        layoutViews()
    }
    
    private func addViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(emojiLabel)
        mainView.addSubview(trackerNamelabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(counterDayLabel)
        stackView.addArrangedSubview(plusButton)
    
    }
}

//MARK: - Extension
@objc extension TrackersCell {
    private func layoutViews() {
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 90),
            mainView.widthAnchor.constraint(equalToConstant: 167),
            
            stackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: mainView.bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            
            emojiLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
            emojiLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 12),
            
            trackerNamelabel.topAnchor.constraint(equalTo: emojiLabel.bottomAnchor, constant: 8),
            trackerNamelabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 12),
            trackerNamelabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -12),
            trackerNamelabel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 12),
            
            counterDayLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 12),
            counterDayLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 16),
            
            plusButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -12),
            plusButton.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 8),
            plusButton.heightAnchor.constraint(equalToConstant: 34),
            plusButton.widthAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func didTapPlusButton() {
        
    }
}
