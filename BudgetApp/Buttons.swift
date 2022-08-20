//
//  Buttons.swift
//  BudgetApp
//
//  Created by Alex Schnabl on 20.08.22.
//

import SwiftUI

struct ActionButton: View {
    
    var name: String
    var target: () -> Void
    var color: Color
    
    var body: some View {
        Button(name, action: { target() } )
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 50, maxHeight: 50)
            .background(color)
            .cornerRadius(10)
    }
}

struct DeleteButton: View {
    @State private var isPresentingConfirm: Bool = false
    var name: String
    var target: () -> Void
    var color: Color
    
    var body: some View {
        Button(name, action: { isPresentingConfirm = true } )
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 50, maxHeight: 50)
            .background(color)
            .cornerRadius(10)
        
            .confirmationDialog("Are you sure?",
                                isPresented: $isPresentingConfirm) {
                Button("Reset",
                       role: .destructive)
                { target() }
            } message: {
                Text("This will reset your Budget and Expenses.")
            }
    }
}
