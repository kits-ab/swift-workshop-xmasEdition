//
//  StartViewModel.swift
//  workshop
//
//  Created by Emma Stålesjö on 2020-12-15.
//

import SwiftUI

extension StartView {
    class ViewModel: ObservableObject {
        @Published var xmas : String = "X-MAS Edition 🎅🏻🤶🏻🎄"
    }
}
