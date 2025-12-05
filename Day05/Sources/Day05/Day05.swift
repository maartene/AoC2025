// The Swift Programming Language
// https://docs.swift.org/swift-book

func numberOfFreshIngredients(in input: String) -> Int {
    let ranges = [
        3...5,
        10...14,
        16...20,
        12...18,
    ]
    
    let ingredients =
    [
        1,
        5,
        8,
        11,
        17,
        32
    ]
    
    let freshIngredients = ingredients.filter { ingredient in
        ranges.contains(where: { $0.contains(ingredient) })
    }
    
    return freshIngredients.count
}
