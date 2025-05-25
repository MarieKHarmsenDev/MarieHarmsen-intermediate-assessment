//
//  TextStyles.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI

struct Title1: View {
    var text: String
    var color: Color? = .orange

    var body: some View {
        Text(text)
            .font(.system(size: 48))
            .foregroundColor(color)
            .bold()
    }
}

struct Regular: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(size: 18))
    }
}

struct Small: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.system(size: 12))
    }
}
