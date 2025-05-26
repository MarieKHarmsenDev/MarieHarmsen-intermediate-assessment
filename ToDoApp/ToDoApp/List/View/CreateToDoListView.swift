//
//  CreateToDoListView.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 26/05/2025.
//
import SwiftUI
import SwiftData

struct CreateToDoListView: View {
    @State private var titleText = ""
    @State private var descriptionText = ""
    @Environment(\.dismiss) private var dismiss
    private var viewModel: ToDoViewModel
    
    init(viewModel: ToDoViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Title2(text: "createListView.pageTitle".localized)
                Spacer()
                Button("createListView.close".localized) {
                    dismiss()
                }
            }

            TextField("createListView.title".localized, text: $titleText)
                .textFieldStyle(.roundedBorder)
                .frame(height: 44)
            
            TextField("createListView.description".localized, text: $descriptionText)
                .textFieldStyle(.roundedBorder)
                .frame(height: 44)
            
            Spacer()

            Button("createListView.save".localized) {
                viewModel.addItem(titleText: titleText, descriptionText: descriptionText)
                dismiss()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(.accent)
            .cornerRadius(8)
            .disabled(titleText.isEmpty || descriptionText.isEmpty)
        }
        .padding()
    }
}
