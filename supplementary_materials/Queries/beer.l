@Engine("duckdb");

@Ground(Beer);
Beer(..r) :- 
    `('https://github.com/plotly/datasets/blob/master/beers.csv?raw=true')`(..r);

BeersInState(state) += 1 :- Beer(state:);
BeersInCity(state, city) += 1 :- Beer(state:, city:);

ArgMax5(x) = ArgMaxK(x, 5);
BestCityForBeer(state:, city:,
                city_beers: BeersInCity(state, city),
                state_beers: BeersInState(state)) :-
    state in ArgMax5{s -> BeersInState(s)},
    city = ArgMax{c -> BeersInCity(state, c)};