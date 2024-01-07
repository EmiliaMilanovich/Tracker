//
//  Tracker.swift
//  Tracker
//
//  Created by Эмилия on 10.10.2023.
//

import UIKit

//сущность для хранения информации про трекер (для «Привычки» или «Нерегулярного события»). У него есть уникальный идентификатор (id), название, цвет, эмоджи и распиcание. Структуру данных для хранения расписания выберите на своё усмотрение;

struct Tracker: Hashable {
    let id: UUID = UUID()
    let name: String
    let color: UIColor
    let emoji: String
    let shedule: Set<WeekDay>
}

