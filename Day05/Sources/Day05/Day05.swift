import Algorithms

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
    let ranges = getRangesAndIngredientsFrom(input).ranges
    let combinedRanges = combineRanges(Set(ranges))
    
    let rangeCounts = combinedRanges.map { $0.count }
    
    return rangeCounts.reduce(0, +)
}

func combineRanges(range1: ClosedRange<Int>, range2: ClosedRange<Int>) -> (newRange: Set<ClosedRange<Int>>, rangesToRemove: Set<ClosedRange<Int>>) {
    
    if range2.contains(range1.upperBound) && range2.contains(range1.lowerBound) {
        return ([range2], [range1])
    }
    
    if range1.contains(range2.upperBound) && range1.contains(range2.lowerBound) {
        return ([range1], [range2])
    }
    
    if range1.contains(range2.lowerBound) &&
        range1.contains(range2.upperBound) == false {
        return ([range1.lowerBound...range2.upperBound], [range1, range2])
    }
    
    if range2.contains(range1.lowerBound) &&
        range2.contains(range1.upperBound) == false {
        return ([range2.lowerBound...range1.upperBound], [range1, range2])
    }
    
    return ([range1, range2], [])
}

func combineRanges(_ ranges: Set<ClosedRange<Int>>) -> Set<ClosedRange<Int>> {
    var canCombine = true
    var ranges = ranges
    
    while canCombine {
        print(ranges.count)
        canCombine = false
        
        for combination in ranges.combinations(ofCount: 2) {
            let result = combineRanges(range1: combination[0], range2: combination[1])
            
            for rangeToRemove in result.rangesToRemove {
                ranges.remove(rangeToRemove)
                canCombine = true
            }
            
            for rangeToInsert in result.newRange {
                ranges.insert(rangeToInsert)
            }
        }
        
    }
    
    return ranges
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
