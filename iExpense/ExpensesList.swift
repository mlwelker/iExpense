
import SwiftUI

struct ExpensesList: View {
    @ObservedObject var expenses: Expenses
    
    @State var expenseType: ExpenseType
    
    var body: some View {
        ForEach(expenses.items[expenseType.rawValue]!.filter { $0.type.lowercased() == expenseType.rawValue}) { item in
            HStack {
                VStack {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                }
                
                Spacer()
                
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .font(item.amount > 10 ? .system(.body, weight: .bold) : .none )
                    .foregroundColor(item.amount > 100 ? .red : .black)
            }
            .accessibilityElement()
            .accessibilityLabel("\(item.name), \(item.amount.formatted(.currency(code: "USD")))")
            .accessibilityHint(item.type)
        }
        .onDelete(perform: removeItems)
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items[expenseType.rawValue]!.remove(atOffsets: offsets)
    }
    
    enum ExpenseType: String {
        case personal = "personal"
        case business = "business"
    }
}

struct ExpensesList_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesList(expenses: Expenses(), expenseType: .personal)
    }
}
