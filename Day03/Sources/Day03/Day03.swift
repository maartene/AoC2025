import Shared
import Foundation

func maximumJoltageFrom(_ input: String, maxDigits: Int = 2) -> Int {
    let banks = input.split(separator: "\n")
        .map { stringToIntArray($0) }
    
    let maximumPerBank = banks.map {
        maximumJoltageForBank($0, maxDigits: maxDigits)
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

func maximumJoltageForBank(_ bank: [Int], maxDigits: Int) -> Int {
    var cache: [String: Int] = [:]

    return cachedMaximumJoltageFor(bank: bank, digits: maxDigits, cache: &cache)
}

extension Array where Element == Int {
    func toInt() -> Int {
        reduce(0) { $0 * 10 + $1 }
    }
}

func cachedMaximumJoltageFor(bank: [Int], digits: Int, cache: inout [String: Int]) -> Int {
    if let result = cache["\(bank)-\(digits)"] {
        return result
    }
    
    guard bank.count > 0 else {
        return 0
    }
    
    if bank.count == digits {
        return bank.toInt()
    }
    
    let a = bank[0] * pow(10, digits - 1) + cachedMaximumJoltageFor(bank: Array(bank.dropFirst()), digits: digits - 1, cache: &cache)
        
    let b = cachedMaximumJoltageFor(bank: Array(bank.dropFirst()), digits: digits, cache: &cache)
    
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
