@Engine("duckdb");

@Ground(Dish);
Dish(..r) :- 
    `('https://github.com/GhosanandaW/worldpopulation/blob/main/WDICountry_manipulated.csv')`(..r);
