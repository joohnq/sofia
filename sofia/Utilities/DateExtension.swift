import SwiftUI

extension Date {
    func dateFormat() -> String {
        return self.formatted(date: .abbreviated, time: .omitted)
    }
}
