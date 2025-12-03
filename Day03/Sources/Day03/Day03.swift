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
    let bank1 = bank
    
    var largestBatteryIndex = 0
    for i in 0 ..< bank.count {
        if bank[i] > bank[largestBatteryIndex] {
            largestBatteryIndex = i
        }
    }
    
    var bank2 = bank1
    bank2.remove(at: largestBatteryIndex)
    
    var secondLargestBatteryIndex = 0
    for i in 0 ..< bank2.count {
        if bank2[i] > bank2[secondLargestBatteryIndex] {
            secondLargestBatteryIndex = i
        }
    }
    
    let batteryJoltageString: String
    if largestBatteryIndex > secondLargestBatteryIndex {
        batteryJoltageString = "\(bank2[secondLargestBatteryIndex])\(bank1[largestBatteryIndex])"
    } else {
        batteryJoltageString = "\(bank1[largestBatteryIndex])\(bank2[secondLargestBatteryIndex])"
    }
    
    return Int(batteryJoltageString)!
}

func stringToIntArray(_ string: any StringProtocol) -> [Int] {
    let stringArray = string.map { $0 }
        .map {
            String($0)
        }
    return stringArray.compactMap { Int($0) }
}
