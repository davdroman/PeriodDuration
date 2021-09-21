import Foundation

/// `PnYnMnWnDTnHnMnS`
let validationRegex = #"^P(?:(\d*)Y)?(?:(\d*)M)?(?:(\d*)W)?(?:(\d*)D)?(?:T(?:(\d*)H)?(?:(\d*)M)?(?:(\d*)S)?)?$"#

extension Optional where Wrapped: Numeric {
    var isNilOrZero: Bool {
        self == nil || self == .zero
    }

    static func + (lhs: Self, rhs: Self) -> Self {
        switch (lhs, rhs) {
        case let (lhs?, rhs?):
            return lhs + rhs
        case let (lhs?, nil):
            return lhs
        case let (nil, rhs?):
            return rhs
        case (nil, nil):
            return nil
        }
    }

    func withSuffix(_ c: Character) -> String {
        self.map { "\($0)\(c)" } ?? ""
    }
}

extension String {
    func amounts(forComponents c: [Character]) -> [Character: Int] {
        let regexes = c.map { "[0-9]{1,}\($0)" }
        return regexes.reduce(into: [:]) { components, regex in
            guard var token = try? NSRegularExpression(pattern: regex)
                .matches(in: self, range: NSRange(self.startIndex..., in: self))
                .compactMap({ String(self[Range($0.range, in: self)!]) })
                .first
            else {
                return
            }

            let key = token.removeLast()
            let value = Int(token)
            components[key] = value
        }
    }
}
