//
//  TextStyles.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI

struct Title1: View {
    var text: String
    var color: Color? = .accent

    var body: some View {
        Text(text)
            .font(.title)
            .foregroundColor(color)
            .bold()
    }
}

struct Title2: View {
    var text: String
    var color: Color? = .accent

    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(color)
            .bold()
    }
}

struct Regular: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.body)
    }
}

struct Small: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.callout)
    }
}
