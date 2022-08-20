//
//  ExpenseList.swift
//  BudgetApp
//
//  Created by Alex Schnabl on 20.08.22.
//

import SwiftUI

struct Expense: Identifiable {
    var id = UUID()
    var date: String
    var locationName: String
    var amount: Double
}

struct ExpensRow: View {
    
    @Binding var expenses: [Expense]
    var expense: Expense
    
    var body: some View {
        HStack {
            Text("\(expense.date):\t\(expense.locationName)")
                .foregroundColor(.black)
            Spacer()
            Text(String(format:"- %.2f$", expense.amount))
                .foregroundColor(Color.red)
        }
    }
}

struct ExpensesView: View {
    
    @Binding var expenses: [Expense]
    
    var body: some View {
        VStack (spacing: 30) {
            Text("Expenses")
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .multilineTextAlignment(.leading)
                .padding(.leading, 20)
                .font(.system(size: 28, weight: .light))
                .foregroundColor(.black)
            
            List() {
                ForEach(expenses) { expense in
                    ExpensRow(expenses: $expenses, expense: expense)
                        .listRowBackground(Color.white)
                }.onDelete(perform: self.deleteRow)
                
            }
            .listStyle(PlainListStyle())
            .frame(height: 200)
            .background(.white)
        }
    }
    
    private func deleteRow(at indexSet: IndexSet) {
            self.expenses.remove(atOffsets: indexSet)
        }
    
}
