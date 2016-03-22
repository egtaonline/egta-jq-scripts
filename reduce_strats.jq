.assignment = (.assignment | with_entries(.value = (reduce .value[] as $x ({}; .[$x] += 1))))
