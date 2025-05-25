//
//  LoadingView.swift
//  ToDoApp
//
//  Created by Marie Harmsen on 25/05/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .padding()
            
            Regular(text: "loading.Loading".localized)
        }
    }
}

#Preview {
    LoadingView()
}
