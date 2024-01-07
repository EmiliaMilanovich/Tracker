//
//  StorageManager.swift
//  Tracker
//
//  Created by Эмилия on 06.11.2023.
//

import Foundation

final class StorageManager {
    static let shared: StorageManager = StorageManager()
    
    private let keyCategory: String = "Categories"
    private let nameDefaultCategory: String = "Default Category"
    private var defaults = UserDefaults.standard.dictionaryRepresentation()
    
    private init() {
        startDefaults()
    }
    
    func startDefaults() {
        var temp: [String] = []
        temp = defaults[keyCategory] as? [String] ?? []
        temp.append(nameDefaultCategory)
        defaults[keyCategory] = temp
    }
    
    func addCategory(_ category: String) {
        var temp: [String] = []
        temp = defaults[keyCategory] as? [String] ?? []
        temp.append(category)
        temp = Array(Set(temp)) // TODO: smth else
        defaults[keyCategory] = temp
    }
    
    func getCategories() -> [TrackerCategory] {
        var clearData: [TrackerCategory] = []
        let temp = defaults[keyCategory] as? [String] ?? []
        
        for category in temp {
            let categoryData = TrackerCategory(title: category, trackers: getTrackers(category: category))
            clearData.append(categoryData)
        }
        
        return clearData
    }
    
    func addTrackers(trackers: [Tracker], category: String) {
        var temp: [Tracker] = []
        temp = defaults[category] as? [Tracker] ?? []
        temp.append(contentsOf: trackers)
        temp = Array(Set(temp)) // TODO: smth else
        defaults[category] = temp
    }
    
    func addTrackers(tracker: Tracker, category: String) {
        var temp: [Tracker] = []
        temp = defaults[category] as? [Tracker] ?? []
        temp.append(tracker)
        temp = Array(Set(temp)) // TODO: smth else
        defaults[category] = temp
    }
    
    func getTrackers(category: String) -> [Tracker] {
        defaults[category] as? [Tracker] ?? []
    }
}
