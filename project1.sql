--Q1: How many matches were played in each season?
select season, count(*) as total_matches from matches group by season order by season;

-- Q2: Which team has won the most matches overall?
select winner, count(*) as won from matches where winner is not null group by winner order by won desc;

-- Q3: Who are the top 5 "Player of the Match" winners?
select player_of_match, count(*) as awards from matches group by player_of_match order by awards desc limit 5;

-- Q4: After winning the toss, do captains choose to bat or field more often?
select toss_decision, count(*) as times from matches group by toss_decision;
--finding: captain chose to field about 64.29% of the time.

-- Q5: Does winning the toss help win the match?
select round(avg( case when toss_winner = winner then 1 else 0 end ) * 100.0, 1) as toss_win_pct
from matches
where  winner is not null;

--Who won the final in each season?
select season, winner from matches where match_type = 'Final';
--finding MI and CSK won most titles, 5 each.

--Q7: How did the number of matches change from the previous season?
with total_match as (select season, count(*)as total_matches from matches group by season)
select season, total_matches, 
total_matches - lag(total_matches) over(order by season) as change from total_match;
--finding biggest jump of the year is 2022 and biggest drop of the year is 2014

--Q8: Which team won the most matches in each season?
with total_wins as (select season, winner ,count(winner) as wins from matches group by season, winner order by wins, season),
 ranked as  (select season, winner, wins, rank() over(partition by season order by wins desc) as rnk from total_wins)
select season, winner, wins from ranked where rnk = 1;
--finding: MI and CSK tied for most wins in 2015, 10 each.