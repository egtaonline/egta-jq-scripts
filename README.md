JQ-Scripts
==========

This repository contains a couple of useful `jq` scripts for working with egta's json formats. Since they can't have their own documentation, the documentation is located in this readme.

expand_strats.jq
----------------

Takes compressed game specifications in the form:
```
{
    "assignment": {
        "role": {
            "strategy": count
        }
    },
    "configuration": {
        ...
    }
}
```
And converts to the standard egta specification:
```
{
    "assignment": {
        "role": [
            "strategy",
            ....
        ]
    },
    "configuration": {
        ...
    }
}
```

reduce_strats.jq
----------------

The opposite of `expand_strats.jq`.
Takes the standard format and converts it to the compressed form.

social_welfare.jq
-----------------

Computes the social wellfare of an observation.
If you want to compute the average social welfare of several runs, something like the following would work:
```
cat *observation*.json | jq -f social_welfare.jq | jq -s 'add / length'
```

merge_payoffs.jq
----------------

Merges the payoffs of an array of observations into one observation with the mean payoffs.
All other information is discarded.
```
cat *observation*.json | jq -s -f merge_payoffs.jq
```

Note: the latest version of jq that this used couldn't reduce over a stream of data structures, so all of the data is inherently held in memory at the same time.
This is not as efficient as something similar written in python, c, etc.

role_strat_payoffs.jq
---------------------

Averages payoffs in an observation file by role and strategy.
The result is an object mapping role to strategy to payoff.
```
< observation.json jq -f role_strat_payoffs.jq
# {
#     "role": {
#         "strategy": payoff
#     }
# }
```
