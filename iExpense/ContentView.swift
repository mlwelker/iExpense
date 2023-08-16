
import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ExpensesList(expenses: expenses, expenseType: .personal)
                } header: {
                    Text("personal")
                }
                
                Section {
                    ExpensesList(expenses: expenses, expenseType: .business)
                } header: {
                    Text("business")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// remove(at:) vs. remove(atOffsets:)
