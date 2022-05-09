//
//  Date.swift
//  Task7UICollectionView
//
//  Created by Tymofii (Work) on 08.10.2021.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
