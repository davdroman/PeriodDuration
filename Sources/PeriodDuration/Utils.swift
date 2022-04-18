import Foundation

/// `PnYnMnWnDTnHnMnS`
let validationRegex = #"^P(?:(\d*)Y)?(?:(\d*)M)?(?:(\d*)W)?(?:(\d*)D)?(?:T(?:(\d*)H)?(?:(\d*)M)?(?:(\d*)S)?)?$"#

extension Numeric {
    var nilIfZero: Self? {
        self == .zero ? nil : self
    }

    func withSuffix(_ c: Character) -> String {
        if self == .zero {
            return ""
        } else {
            return "\(self)\(c)"
        }
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

#if !os(Linux)
let formatter: DateComponentsFormatter = {
    var formatter = DateComponentsFormatter()
    var calendar = Calendar(identifier: .iso8601)
    calendar.timeZone = TimeZone(secondsFromGMT: 0)!
    formatter.calendar = calendar
    return formatter
}()
#endif
