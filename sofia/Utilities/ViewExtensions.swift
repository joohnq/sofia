//
//  View.swift
//  sofia
//
//  Created by Henrique on 06/03/25.
//
import SwiftUI

extension View {
    @ViewBuilder
    func navigationLink(value: any Hashable, hideChevron: Bool = false)
        -> some View
    {
        overlay {
            NavigationLink(value: value) {}
                .opacity(hideChevron ? 0 : 1)
        }
    }
}
