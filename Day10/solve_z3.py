import sys
from z3 import *

def solve():
    # Read rules
    rules = []
    for line in sys.stdin:
        line = line.strip()
        if line == "---":
            break
        if line:
            rules.append(set(map(int, line.split(','))))
    
    # Read requirements
    requirements = list(map(int, sys.stdin.readline().strip().split(',')))
    
    # Solve with Z3
    solver = Optimize()
    buttons = [Int(f'b{i}') for i in range(len(rules))]
    
    for b in buttons:
        solver.add(b >= 0)
    
    for i in range(len(requirements)):
        solver.add(Sum([buttons[j] if i in rules[j] else 0 
                       for j in range(len(rules))]) == requirements[i])
    
    solver.minimize(Sum(buttons))
    
    if solver.check() == sat:
        model = solver.model()
        print(sum(model[b].as_long() for b in buttons))
    else:
        print(-1)

if __name__ == "__main__":
    solve()
