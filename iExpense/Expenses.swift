
import Foundation

class Expenses: ObservableObject {
    @Published var items = [String:[ExpenseItem]]() {
        didSet {
            if let data = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(data, forKey: "Items")
            }
        }
    }
    
    init() {
//        let thing = [ExpenseItem].self
        
        if let data = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([String:[ExpenseItem]].self, from: data) {
                items = decodedItems
                return
            }
        }
        
        items = ["business": [], "personal": []]
    }
}
