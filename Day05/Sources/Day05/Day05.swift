// The Swift Programming Language
// https://docs.swift.org/swift-book

func numberOfFreshIngredients(in input: String) -> Int {
    let parsedInput = getRangesAndIngredientsFrom(input)
    let ingredients = parsedInput.ingredients
    let ranges = parsedInput.ranges
    
    let freshIngredients = ingredients.filter { ingredient in
        ranges.contains(where: { $0.contains(ingredient) })
    }
    
    return freshIngredients.count
}

func numberOfFreshIngredientIDs(in input: String) -> Int {
    14
}

private func getRangesAndIngredientsFrom(_ input: String) -> (ranges: [ClosedRange<Int>], ingredients: [Int]) {
    let lines = input.split(separator: "\n")
    
    var ranges = [ClosedRange<Int>]()
    var ingredients = [Int]()
    
    for line in lines {
        let splits = line.split(separator: "-")
        switch splits.count {
        case 2:
            if let lowerBound = Int(splits[0]), let upperBound = Int(splits[1]) {
                ranges.append(lowerBound...upperBound)
            }
        default:
            if let ingredient = Int(splits[0]) {
                ingredients.append(ingredient)
            }
        }
    }
    
    return (ranges, ingredients)
}
