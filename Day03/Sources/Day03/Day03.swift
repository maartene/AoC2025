import Shared

func maximumJoltageFrom(_ input: String) -> Int {
    let banks = input.split(separator: "\n")
        .map { stringToIntArray($0) }
    
    let maximumPerBank = banks.map {
        maximumJoltageFromBank($0)
    }
    
    return maximumPerBank.reduce(0, +)
}

func maximumJoltageFromBank(_ bank: [Int]) -> Int {
    var maximum = 0
    
    for leftIndex in 0 ..< bank.count - 1 {
        for rightIndex in leftIndex + 1 ..< bank.count {
            let batteryJoltageString = "\(bank[leftIndex])\(bank[rightIndex])"
            let batteryJoltage = Int(batteryJoltageString)!
            
            if batteryJoltage > maximum {
                maximum = batteryJoltage
            }
        }
    }
    return maximum
}

func stringToIntArray(_ string: any StringProtocol) -> [Int] {
    let stringArray = string.map { $0 }
        .map {
            String($0)
        }
    return stringArray.compactMap { Int($0) }
}
