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
            .padding(.vertical)

            TextField("createListView.title".localized, text: $titleText)
                .textFieldStyle(.roundedBorder)
                .frame(height: 44)
            
            TextField("createListView.description".localized, text: $descriptionText)
                .textFieldStyle(.roundedBorder)
                .frame(height: 44)
            
            Spacer()
            
            let successAction = {
                dismiss()
                viewModel.addItem(titleText: titleText, descriptionText: descriptionText)
            }
            
            PrimaryButton(action: successAction, imageName: "plus.circle.fill", buttonText: "createListView.save".localized, isDisabled: titleText.isEmpty || descriptionText.isEmpty)
        }
        .padding()
    }
}
