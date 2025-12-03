import Shared
import Foundation

func maximumJoltageFrom(_ input: String, maxDigits: Int = 2) -> Int {
    let banks = input.split(separator: "\n")
        .map { stringToIntArray($0) }
    
    let maximumPerBank = banks.map {
        cachedmaximumJoltageFromBank($0, maxDigits: maxDigits)
    }
    
    return maximumPerBank.reduce(0, +)
}

struct JoltageInput: Hashable {
    let bank: [Int]
    let currentMaximum: Int
    let startIndex: Int
    let maxDigits: Int
    let digitsCount: Int
}

func cachedmaximumJoltageFromBank(_ bank: [Int], maxDigits: Int) -> Int {
    var cache: [String: Int] = [:]

    return part2(bank: bank, digits: maxDigits, cache: &cache)
}

extension Array where Element == Int {
    func toInt() -> Int {
        reduce(0) { $0 * 10 + $1 }
    }
}

func part2(bank: [Int], digits: Int, cache: inout [String: Int]) -> Int {
    if let result = cache["\(bank)-\(digits)"] {
        return result
    }
    
    guard bank.count > 0 else {
        return 0
    }
    
    if bank.count == digits {
        return bank.toInt()
    }
    
//        # Take this digit
//        # For the 12th digit, we need 10 ^ (12 - 1)
    let a = bank[0] * pow(10, digits - 1) + part2(bank: Array(bank.dropFirst()), digits: digits - 1, cache: &cache)
        
    let b = part2(bank: Array(bank.dropFirst()), digits: digits, cache: &cache)
    
        
    
    // Return the greater value
    let result = max(a, b)
    cache["\(bank)-\(digits)"] = result
    return result
}

func stringToIntArray(_ string: any StringProtocol) -> [Int] {
    let stringArray = string.map { $0 }
        .map {
            String($0)
        }
    return stringArray.compactMap { Int($0) }
}

func pow(_ base: Int, _ exponent: Int) -> Int {
    guard exponent >= 0 else {
        return 0
    }
    
    var result = 1
    for _ in 0 ..< exponent {
        result *= base
    }
    return result
}
