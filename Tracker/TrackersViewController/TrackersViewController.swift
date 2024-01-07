//
//  TrackersViewController.swift
//  Tracker
//
//  Created by Эмилия on 08.10.2023.
//

import UIKit

final class TrackersViewController: UIViewController {
    
//MARK: - Private properties
    
    //все созданные категории
    private var categories: [TrackerCategory] = []
    
    //видимые(отфильтрованные) категории на экране
    private var visibleCategories: [TrackerCategory] = []

    //трекеры, которые были «выполнены» в выбранную дату
    private var completedTrackers: [TrackerRecord] = []
//
//    var currentDate: Date =
    
    private let storageManager = StorageManager.shared
    
    
    private var addNewTrackerButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(named: "plus")!,
            target: self,
            action: #selector(addNewTracker))
        button.tintColor = Color.blackDay
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var trackerLabel: UILabel = {
        let label = UILabel()
        label.text = "Трекеры"
        label.font = .boldSystemFont(ofSize: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.layer.cornerRadius = 8
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.addTarget(
            self,
            action: #selector(dateChanged),
            for: .valueChanged)
        return datePicker
    }()
    
    private var searchTextField: UISearchTextField = {
        let textField = UISearchTextField()
        textField.placeholder = "Поиск"
        textField.tintColor = Color.colorSearchField
        textField.textColor = Color.gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var stubView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var stubImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "error1"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var stubLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var collectionViewTrackers: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TrackersCell.self, forCellWithReuseIdentifier: TrackersCell.identifier)
        return collectionView
    }()
    
//MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categories = storageManager.getCategories()
//        reloadData()
        collectionViewTrackers.reloadData()
        print(categories)
        checkEmptyCategories()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = storageManager.getCategories()
        reloadData()
        configure()
        checkEmptyCategories()
    }
    
//MARK: - Private methods
    private func checkEmptyCategories() {
        if !categories[0].trackers.isEmpty {
            stubView.isHidden = true
            collectionViewTrackers.isHidden = false
            collectionViewTrackers.reloadData()
        } else {
            stubView.isHidden = false
            collectionViewTrackers.isHidden = true
        }
    }
    private func configure() {
        view.backgroundColor = Color.whiteDay
        reloadData()
        addViews()
        layoutViews()
//        searchTextField.delegate =
        collectionViewTrackers.delegate = self
        collectionViewTrackers.dataSource = self
        
    }
    
    private func addViews() {
        view.addSubview(addNewTrackerButton)
        view.addSubview(trackerLabel)
        view.addSubview(datePicker)
        view.addSubview(searchTextField)
        view.addSubview(stubView)
        stubView.addSubview(stubLabel)
        stubView.addSubview(stubImage)
        view.addSubview(collectionViewTrackers)
    }
    
    private func reloadData() {
//        visibleCategories = storageManager.categories
    }
    
    private func updateDateLabelTitle(with _: Date) {
        
    }
    
    private func reloadVisibleCategories() {
//        let calendar = Calendar.current
//        let filterWeekday = calendar.component(.weekday, from: datePicker.text)
//        let filterText = (searchTextField.text ?? "").lowercased()
//
//        visibleCategories = categories.compactMap { category in
//            let trackers = category.trackers.filter { tracker in
//                let textCondition = filterText.isEmpty || tracker.name.lowercased().contains(filterText)
//                let dateCondition = tracker.shedule.contains { weekDay in
//                    weekDay.numberValue == filterWeekday
//                } == true
//                return textCondition && dateCondition
//            }
//
//            if trackers.isEmpty {
//                return nil
//            }
//
//            return TrackerCategory(
//                title: category.title,
//                trackers: trackers)
//        }
//
        collectionViewTrackers.reloadData()
        reloadStub()
    }
    
    private func reloadStub() {
        stubView.isHidden = !visibleCategories.isEmpty
    }
    
}

//MARK: - Extension
@objc extension TrackersViewController {
    
    private func addNewTracker() {
        let createNewTrackerViewController = CreateNewTrackerViewController()
        present(createNewTrackerViewController, animated: true)
    }
    
    private func dateChanged() {
        updateDateLabelTitle(with: datePicker.date)
        reloadVisibleCategories()
    }
    
    private func layoutViews() {
        NSLayoutConstraint.activate([
            addNewTrackerButton.widthAnchor.constraint(equalToConstant: 42),
            addNewTrackerButton.heightAnchor.constraint(equalToConstant: 42),
            addNewTrackerButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            addNewTrackerButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            
            trackerLabel.topAnchor.constraint(equalTo: addNewTrackerButton.bottomAnchor, constant: 1),
            trackerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            datePicker.heightAnchor.constraint(equalToConstant: 34),
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 1),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            searchTextField.heightAnchor.constraint(equalToConstant: 36),
            searchTextField.topAnchor.constraint(equalTo: trackerLabel.bottomAnchor, constant: 7),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionViewTrackers.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 24),
            collectionViewTrackers.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionViewTrackers.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionViewTrackers.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            stubView.topAnchor.constraint(equalTo: view.topAnchor),
            stubView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stubView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stubView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stubImage.heightAnchor.constraint(equalToConstant: 80),
            stubImage.widthAnchor.constraint(equalToConstant: 80),
            stubImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 402),
            stubImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.topAnchor.constraint(equalTo: stubImage.bottomAnchor, constant: 8),
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

//MARK: - UITextFieldDelegate
extension TrackersViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchTextField.textColor = Color.blackDay
        }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension TrackersViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let trackers = categories[section].trackers
        return trackers.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackersCell.identifier, for: indexPath) as? TrackersCell else {
            return UICollectionViewCell()
        }
        
        cell.prepareForReuse()
        //заполняем ячейку данными
        //ДОДЕЛАТЬ
        cell.configureCell(with: categories[indexPath.section].trackers[indexPath.row], isCompletedToday: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //ДОДЕЛАТЬ хедер
        return UICollectionReusableView()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    //самим задать размеры ячеек
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //Берём ширину коллекции и делим на два, чтобы на каждой строке помещалось ровно по две ячейки
            return CGSize(width: collectionView.bounds.width / 2, height: 148)
        }
    
    
    //Чтобы задать отступы от краёв коллекции, воспользуемся методом делегата
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    //отвечает за вертикальные отступы
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat()
    }
    
    //отвечает за горизонтальные отступы между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat()
    }
}
