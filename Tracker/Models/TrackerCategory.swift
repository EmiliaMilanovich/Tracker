//
//  TrackerCategory.swift
//  Tracker
//
//  Created by Эмилия on 10.10.2023.
//

import Foundation

//сущность для хранения трекеров по категориям. Она имеет заголовок и содержит массив трекеров, относящихся к этой категории

struct TrackerCategory {
    let title: String
    let trackers: [Tracker]
}
