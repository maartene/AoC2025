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

func maximumJoltageForBank(_ bank: [Int], maxDigits: Int) -> Int {
    var cache: [Input: Int] = [:]
    return cachedMaximumJoltageFor(bank: bank, digits: maxDigits, cache: &cache)
}

struct Input: Hashable {
    let bank: [Int]
    let digits: Int
}

func cachedMaximumJoltageFor(bank: [Int], digits: Int, cache: inout [Input: Int]) -> Int {
    if let result = cache[Input(bank: bank, digits: digits)] {
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
    cache[Input(bank: bank, digits: digits)] = result
    return result
}

extension Array where Element == Int {
    func toInt() -> Int {
        reduce(0) { $0 * 10 + $1 }
    }
}
