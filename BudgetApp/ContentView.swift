//
//  ContentView.swift
//  BudgetApp
//
//  Created by Alex Schnabl on 19.08.22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var bduget = 0.00
    @State private var spent = 0.00
    @State private var expenses = [Expense]()
    
    @State private var presentAlert = false
    @State private var amountToAdd: String?
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                Text(String(format:"%.2f$", bduget - spent))
                    .padding(.top, 30)
                    .padding(.bottom, 30)
                    .font(.system(size: 64, weight: .medium))
                    .foregroundColor(
                        bduget - spent < 0 ? .red : .black)
                
                ExpensesView(expenses: $expenses)
                
                Spacer()
                
                VStack  {
                    Spacer()
                    StatView(number: $bduget, name: "Budget")
                    StatView(number: $spent, name: "Spent")
                }
                
                Spacer()
                
                VStack {
                    ActionButton(name: "Add Money",
                                 target: self.addMoney,
                                 color: Color.green)
                    
                    HStack {
                        ActionButton(name: "Add Expense",
                                     target: self.addExpenseRow,
                                     color: Color.red)
                        
                        ActionButton(name: "Quick Add",
                                     target: self.addExpenseRow,
                                     color: Color.red)
                    }
                    
                    DeleteButton(name: "Reset",
                                 target: self.resetData,
                                 color: Color.gray)
                }.padding()
                Spacer()
            }
        }
    }
    
    public func addMoney() {
        
        alertTF(title: "Add Money", message: "Add Money to Budget!",
                textFields: [alertTextField(hintText: "Money", keyboardType: .decimalPad)],
                primaryTitle: "Add", secondaryTitle: "Cancle") { inputs in
            
            let num = inputs[0] == "" ? 0.0 : Double(inputs[0].replacingOccurrences(of: ",", with: "."))
            
            self.bduget += num!
            
        } secondaryAction:  {
            print("Cancle")
        }
    }
    
    public func addExpenseRow() {
        
        alertTF(title: "Add Expense", message: "Enter Expense Data!",
                textFields: [alertTextField(hintText: "Name"),
                             alertTextField(hintText: "Cost", keyboardType: .decimalPad)],
                primaryTitle: "Add", secondaryTitle: "Cancle") { inputs in
            
            let name = inputs[0] == "" ? "Unknown" : inputs[0]
            let num = inputs[1]  == "" ? 0.0 : Double(inputs[1].replacingOccurrences(of: ",", with: "."))
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "dd/MM/YY"
            let dateString = df.string(from: date)
            
            self.spent += num!
            self.expenses.append(
                Expense(date: dateString, locationName: name, amount: num!)
            )
        } secondaryAction:  {
            print("Cancle")
        }
    }
    
    public func resetData() {
        self.bduget = 0
        self.spent = 0
        self.expenses.removeAll()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct StatView: View {
    
    @Binding var number: Double
    var name: String
    
    var body: some View {
        HStack (alignment: .lastTextBaseline){
            Text(String(format:"%.2f$", number))
                .frame(maxWidth: .infinity, alignment: .trailing)
                .font(.system(size: 46, weight: .medium))
                .foregroundColor(.black)
            Text(name)
                .frame(width: 60, alignment: .trailing)
                .foregroundColor(.black)
            Spacer()
        }
    }
}
