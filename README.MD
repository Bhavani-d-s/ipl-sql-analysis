# IPL Match Analysis with SQL

## About
I analysed every IPL match from 2008 to 2024 using SQL. I wanted to answer real questions like: how many matches were played in each season and how that changed from the previous year, which teams won the most, whether captains prefer to bat or field after winning the toss, whether winning the toss actually helps, and who won the final in each season.

## Dataset
- Source: [IPL Complete Dataset (2008–2024) on Kaggle](https://www.kaggle.com/datasets/patrickb1912/ipl-complete-dataset-20082020)
- File used: `matches.csv`, with 1,095 matches across 17 seasons
- Each row is one match: season, date, city, venue, match type (league, playoff or final), the two teams, toss winner and decision, match winner, result margin, and player of the match.

## Tools
- **PostgreSQL**: the database where the data is stored
- **DBeaver**: to import the CSV and write the SQL queries
- **GitHub**: to share the project

## Questions and findings

**Q1: How many matches were played in each season?**
The number of matches goes up and down across the 17 seasons. The highest was 2013, with 76 matches.

**Q2: Which team has won the most matches overall?**
Mumbai Indians won the most matches: 144.

**Q3: Who are the top 5 "Player of the Match" winners?**
AB de Villiers leads with 25 awards, followed by CH Gayle (22), RG Sharma (19), V Kohli (18) and DA Warner (18).

**Q4: After winning the toss, do captains choose to bat or field more often?**
Captains chose to field about 64% of the time.

**Q5: Does winning the toss help win the match?**
The toss winner won the match only 50.8% of the time, so winning the toss is basically a 50-50 chance.

**Q6: Who won the final in each season?**
Mumbai Indians and Chennai Super Kings have won the most titles, 5 each.

**Q7: How did the number of matches change from the previous season?**
The biggest jump was in 2022 (+14 matches), when two new teams joined the IPL. The biggest drop was in 2014 (-16 matches).

**Q8: Which team won the most matches in each season?**
In 2015, Mumbai Indians and Chennai Super Kings tied for the most wins, with 10 each.

## What I learned
- Loading real data is not always smooth. My first import failed because DBeaver guessed the column types from only 100 rows. I fixed it by treating "NA" as NULL, letting DBeaver read the whole file, and dropping the half-made table before importing again.
- Q8 was the hardest. I learned that a column made with a window function (like `rank`) can't be used in WHERE in the same query, so I used two CTEs: one to count wins, and one to rank teams inside each season.
- I used GROUP BY, CASE, ROUND, AVG, CTEs, and the window functions LAG and RANK with PARTITION BY.