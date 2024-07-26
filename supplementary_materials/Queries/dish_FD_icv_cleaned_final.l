# initialization
@Engine("duckdb");

@Ground(Dish);
Dish(..r) :- 
    `('https://github.com/GhosanandaW/CS513/blob/main/supplementary_materials/datasets/cleaned%20datasets/dish_cleaned_dataset_final.csv?raw=true')`(..r);

DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:) :- 
  Dish(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:);

DishSchema2(id2:, name2:, menus_appeared2:, times_appeared2:, first_appeared2:, last_appeared2:, lowest_price2:, highest_price2:) :-
    Dish(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    id2 = id,
    name2 = name,
    menus_appeared2 = menus_appeared,
    times_appeared2 = times_appeared,
    first_appeared2 = first_appeared,
    last_appeared2 = last_appeared,
    lowest_price2 = lowest_price,
    highest_price2 = highest_price;

#check total row, profiling and sanity check
#Total row 423397
#Completed sanity check
totalRowCount(count? +=1) distinct:- 
    Dish();

#check total row, profiling and sanity check
#Total row 423397
#Completed sanity check
totalRowCountDishSchema2(count? +=1) distinct:- 
    DishSchema2();

##############################################################################################
#PK check

# confirm that PK (id) should not be negative nor zero
PKNotNegative(id:) :- Dish(id:), id<=0;

# Test if PK(id) is unique
SchemaId(id:, count? +=1 ) distinct :-
    DishSchema(id:),
    DishSchema2(id2:),
    id  = id2;
IcvUniqueId(id:,count:) :- SchemaId(id:, count:), count>1;

##############################################################################################
#FD Check: id-> name, description, menus_appeared, times_appeared, first_appeared, last_appeared, lowest_price, highest price holds

# confirm that PK (id) should not be negative nor zero
PKNotNegative(id:) :- Dish(id:), id<=0;

# test if FD: id-> name, description, menus_appeared, times_appeared, first_appeared, last_appeared, lowest_price, highest price holds
IcvUniqueTuple(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    DishSchema2(id2:, name2:, menus_appeared2:, times_appeared2:, first_appeared2:, last_appeared2:, lowest_price2:, highest_price2:),
    id  = id2,
    name = name2,
    menus_appeared  = menus_appeared2,
    times_appeared = times_appeared2,
    first_appeared = first_appeared2,
    last_appeared  = last_appeared2,
    lowest_price   = lowest_price2,
    highest_price  = highest_price2;

# test if FD: id-> name, description, menus_appeared, times_appeared, first_appeared, last_appeared, lowest_price, highest price holds, find which tuples might refer to the same entity and needs to be merged
IcvDifferentIDSameTuple(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    DishSchema2(id2:, name2:, menus_appeared2:, times_appeared2:, first_appeared2:, last_appeared2:, lowest_price2:, highest_price2:),
    id  != id2,
    name = name2,
    menus_appeared  = menus_appeared2,
    times_appeared = times_appeared2,
    first_appeared = first_appeared2,
    last_appeared  = last_appeared2,
    lowest_price   = lowest_price2,
    highest_price  = highest_price2;

CountIcvDifferentIDSameTuple(count? +=1) distinct:- IcvDifferentIDSameTuple();
IcvDifferentIDSameTupleID(id:) distinct:- IcvDifferentIDSameTuple(id:);


##############################################################################################
#Conditional FD check


# check for dish that violates menus_appeared<=times_appeared
# issue detected with 8274 violation
IcvMenusAndTimesCheck(id:, name:, menus_appeared:, times_appeared:) :- 
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    menus_appeared>times_appeared;

CountIcvMenusAndTimesCheck(count? +=1) distinct:- IcvMenusAndTimesCheck();

# check for dish that violates menus_appeared>0
# issue detected with 2271 count
IcvMenusZeroOrNegativeCheck(id:, name:, menus_appeared:) :- 
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    menus_appeared<=0;
CountIcvMenusZeroOrNegativeCheck(count? +=1) distinct:- IcvMenusZeroOrNegativeCheck();

# check for dish that violates times_appeared>0
# issue detected with 9269 count
IcvTimesAppearedZeroOrNegativeCheck(id:, name:,times_appeared:) :- 
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    times_appeared<=0;
CountIcvTimesAppearedZeroOrNegativeCheck(count? +=1) distinct:- IcvTimesAppearedZeroOrNegativeCheck();



# check for dish that violates first_appeared<=last_appeared
# issue detected with 6 violation
IcvFirstAppearedandLastAppearedCheck(id:, name:, first_appeared:, last_appeared:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    first_appeared>last_appeared;
CountIcvFirstAppearedandLastAppearedCheck(count? +=1) distinct:- IcvFirstAppearedandLastAppearedCheck();

# check for dish that violates first_appeared<= current year (2024)
# issue detected with 11 violations 
IcvFirstAppearedMoreThanCurrentYearCheck(id:, name:, first_appeared:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    first_appeared>2024;
CountIcvFirstAppearedMoreThanCurrentYearCheck(count? +=1) distinct:- IcvFirstAppearedMoreThanCurrentYearCheck();

# check for dish that violates last_appeared<= current year (2024)
# issue detected with 179 violations
IcvlastAppearedMoreThanCurrentYearCheck(id:, name:, last_appeared:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    last_appeared>2024;
CountIcvlastAppearedMoreThanCurrentYearCheck(count? +=1) distinct:- IcvlastAppearedMoreThanCurrentYearCheck();


# check for dish that violates lowest>0
# issue detected with 222566 violations
IcvLowestPriceEmptyCheck(id:, name:, lowest_price:, highest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    lowest_price<=0;
CountIcvLowestPriceEmptyCheck(count? +=1) distinct:- IcvLowestPriceEmptyCheck();

# check for dish that violates highest>0
# issue detected with 218014 violations
IcvHighestPriceEmptyCheck(id:, name:, lowest_price:, highest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    highest_price<=0;
CountIcvHighestPriceEmptyCheck(count? +=1) distinct:- IcvHighestPriceEmptyCheck();

# check for dish that violates lowest!=null
# issue detected with NO violations
IcvLowestPriceNullCheck(id:, name:, lowest_price:, highest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    lowest_price==null;
CountIcvLowestPriceNullCheck(count? +=1) distinct:- IcvLowestPriceNullCheck();

# check for dish that violates highest!=null
# issue detected with None violations
IcvHighestPriceNullCheck(id:, name:, lowest_price:, highest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    highest_price==null;
CountIcvHighestPriceNullCheck(count? +=1) distinct:- IcvHighestPriceNullCheck();

# check for dish that violates lowest_price<=highest_price
# issue NOT DETECTED (lowest price can be highest price too if there is only 1 price forever)
IcvLowestPriceandHighestPriceCheck(id:, name:, lowest_price:, highest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    lowest_price>highest_price;
CountIcvLowestPriceandHighestPriceCheck(count? +=1) distinct:- IcvLowestPriceandHighestPriceCheck();

# check for dish that violates lowest_price>0
# issue detected with 222566 violations
IcvLowestPriceCheck(id:, name:, lowest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    lowest_price<=0;
CountIcvLowestPriceCheck(count? +=1) distinct:- IcvLowestPriceCheck();

# check for dish that violates highest>0
# issue detected with 222566 violations
IcvHighestPriceCheck(id:, name:, highest_price:) :-
    DishSchema(id:, name:, menus_appeared:, times_appeared:, first_appeared:, last_appeared:, lowest_price:, highest_price:),
    lowest_price<=0;
CountIcvHighestPriceCheck(count? +=1) distinct:- IcvHighestPriceCheck();
