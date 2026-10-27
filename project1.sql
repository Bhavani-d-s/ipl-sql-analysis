--Q1: How many matches were played in each season?
SELECT
    season,
    COUNT(*) AS total_matches
FROM
    matches
GROUP BY
    season
ORDER BY
    season;
-- Finding: The number of matches goes up and down across seasons. The highest was 2013, with 76 matches.

-- Q2: Which team has won the most matches overall?
SELECT
    winner,
    COUNT(*) AS matches_won
FROM
    matches
WHERE
    winner IS NOT NULL
GROUP BY
    winner
ORDER BY
    matches_won DESC;
-- Finding: Mumbai Indians won the most matches overall: 144.

-- Q3: Who are the top 5 "Player of the Match" winners?
SELECT
    player_of_match,
    COUNT(*) AS awards
FROM
    matches
GROUP BY
    player_of_match
ORDER BY
    awards DESC
LIMIT 5;
-- Finding: AB de Villiers leads with 25 awards, followed by CH Gayle (22), RG Sharma (19), V Kohli (18) and DA Warner (18).


-- Q4: After winning the toss, do captains choose to bat or field more often?
SELECT
    toss_decision,
    COUNT(*) AS times
FROM
    matches
GROUP BY
    toss_decision;
--finding: captain chose to field about 64.29% of the time.

-- Q5: Does winning the toss help win the match?
SELECT
    ROUND(AVG( CASE WHEN toss_winner = winner THEN 1 ELSE 0 END ) * 100.0, 1) AS toss_win_pct
FROM
    matches
WHERE
    winner IS NOT NULL;

--Q6: Who won the final in each season?
SELECT
    season,
    winner
FROM
    matches
WHERE
    match_type = 'Final'
ORDER BY 
    season;
--finding MI and CSK won most titles, 5 each.

--Q7: How did the number of matches change from the previous season?
-- Q7: How did the number of matches change from the previous season?
WITH season_matches AS (
    SELECT
        season,
        COUNT(*) AS total_matches
    FROM
        matches
    GROUP BY
        season
)
SELECT
    season,
    total_matches,
    total_matches - LAG(total_matches) OVER (ORDER BY season) AS change_from_last_season
FROM
    season_matches
ORDER BY
    season;
-- Finding: The biggest jump was in 2022 (+14 matches, when two new teams joined). The biggest drop was in 2014 (-16 matches).
--finding biggest jump of the year is 2022 and biggest drop of the year is 2014

--Q8: Which team won the most matches in each season?
WITH season_wins AS (
    SELECT
        season,
        winner,
        COUNT(winner) AS wins
    FROM
        matches
    GROUP BY
        season,
        winner
),
 ranked AS (
    SELECT
        season,
        winner,
        wins,
        RANK() OVER(PARTITION BY season ORDER BY wins DESC) AS with_rank
    FROM
        season_wins
)
SELECT
    season,
    winner,
    wins
FROM
    ranked
WHERE
    with_rank = 1
ORDER BY
    season;
--finding: MI and CSK tied for most wins in 2015, 10 each.