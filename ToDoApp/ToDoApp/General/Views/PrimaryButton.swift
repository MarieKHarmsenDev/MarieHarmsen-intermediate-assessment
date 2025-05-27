//
//  PrimaryButton.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 27/05/2025.
//
import SwiftUI

struct PrimaryButton: View {
    var action: () -> Void
    var imageName: String
    var buttonText: String
    var isDisabled: Bool
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Image(systemName: imageName)
                Regular(text: buttonText)
                Spacer()
            }
            .padding()
            .background(isDisabled ? .gray : .accent)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .disabled(isDisabled)
        .padding(.horizontal, 16)
    }
}
