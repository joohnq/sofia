//
//  DateExtension.swift
//  sofia
//
//  Created by Henrique on 06/03/25.
//
import SwiftUI

extension Date {
    func dateFormat() -> String {
        return self.formatted(date: .abbreviated, time: .omitted)
    }
}
