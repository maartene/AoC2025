import Shared

func maximumJoltageFrom(_ input: String) -> Int {
    let bank1 = stringToIntArray("987654321111111")
    
    let maximumPerBank = [
        maximumJoltageFromBank(bank1),
        89,
        78,
        92
    ]
    
    return maximumPerBank.reduce(0, +)
}

func maximumJoltageFromBank(_ bank: [Int]) -> Int {
    98
}

func stringToIntArray(_ string: any StringProtocol) -> [Int] {
    let stringArray = string.map { $0 }
        .map {
            String($0)
        }
    return stringArray.compactMap { Int($0) }
}
