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

func combineRanges(_ ranges: Set<ClosedRange<Int>>) -> Set<ClosedRange<Int>> {
    guard ranges.isEmpty == false else {
        return []
    }

    // Sort by lower bound
    let sortedRanges = ranges.sorted { $0.lowerBound < $1.lowerBound }
    var mergedRanges: [ClosedRange<Int>] = []
    var currentRange = sortedRanges[0]

    for range in sortedRanges.dropFirst() {
        // merge if overlapping or touching
        if range.lowerBound <= currentRange.upperBound {
            currentRange = currentRange.lowerBound...max(currentRange.upperBound, range.upperBound)
        } else {
            mergedRanges.append(currentRange)
            currentRange = range
        }
    }
    mergedRanges.append(currentRange)

    return Set(mergedRanges)
}

private func getRangesAndIngredientsFrom(_ input: String) -> (
    ranges: [ClosedRange<Int>], ingredients: [Int]
) {
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
