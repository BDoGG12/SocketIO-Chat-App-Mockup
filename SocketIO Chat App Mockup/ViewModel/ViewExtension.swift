//
//  ViewExtension.swift
//  SocketIO Chat App Mockup
//
//  Created by Ben Do on 2/18/21.
//

import SwiftUI


extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
