use ipl;
-- Count total players in dataset
SELECT COUNT(*) AS total_bowlers
FROM ipl.bowling_stats;
-- Find all unique teams
SELECT DISTINCT `Team`
FROM ipl.bowling_stats;
-- Lower average = better bowler
SELECT `Player Name`, `Team`, `AVG`
FROM ipl.bowling_stats
WHERE `MAT` >= 10
ORDER BY `AVG` ASC
LIMIT 10;
-- Low economy means fewer runs conceded
SELECT `Player Name`, `Team`, `ECO`
FROM ipl.bowling_stats
WHERE `OVR` >= 20
ORDER BY `ECO` ASC
LIMIT 10;
-- Strike rate = balls per wicket (lower is better)
SELECT `Player Name`, `Team`, `SR`
FROM ipl.bowling_stats
ORDER BY `SR` ASC
LIMIT 10;
-- Bowlers who win matches with big spells
SELECT `Player Name`, `Team`,
       (`4W` + `5W`) AS match_winning_spells
FROM ipl.bowling_stats
ORDER BY match_winning_spells DESC
LIMIT 10;
-- Team with strongest bowling attack
SELECT `Team`,
       SUM(`WKT`) AS total_wickets,
       AVG(`ECO`) AS team_avg_economy
FROM ipl.bowling_stats
GROUP BY `Team`
ORDER BY total_wickets DESC;
-- Highest wicket taker from every team
SELECT b1.`Team`, b1.`Player Name`, b1.`WKT`
FROM ipl.bowling_stats b1
WHERE b1.`WKT` = (
    SELECT MAX(b2.`WKT`)
    FROM ipl.bowling_stats b2
    WHERE b1.`Team` = b2.`Team`
);
-- Combines average + economy
-- Lower score = more reliable bowler
SELECT `Player Name`, `Team`,
       (`AVG` + `ECO`) AS consistency_score
FROM ipl.bowling_stats
ORDER BY consistency_score ASC
LIMIT 10;
-- Categorize bowlers based on style
SELECT `Player Name`, `Team`,
CASE
    WHEN `SR` < 14 THEN 'Aggressive Wicket Taker'
    WHEN `ECO` < 7 THEN 'Defensive Controller'
    ELSE 'Balanced Bowler'
END AS bowler_type
FROM ipl.bowling_stats;
-- Overall best performing bowlers
SELECT `Player Name`, `Team`,
       (`WKT`*5 + `4W`*10 + `5W`*20 - `ECO`*2) AS mvp_score
FROM ipl.bowling_stats
ORDER BY mvp_score DESC
LIMIT 10;
-- Measures match impact consistency
SELECT `Player Name`, `Team`,
       (`WKT` / `MAT`) AS wickets_per_match
FROM ipl.bowling_stats
WHERE `MAT` > 5
ORDER BY wickets_per_match DESC
LIMIT 10;
-- Typically bowlers good under pressure
SELECT `Player Name`, `Team`, `WKT`, `ECO`
FROM ipl.bowling_stats
WHERE `WKT` >= 15 AND `ECO` <= 8
ORDER BY `WKT` DESC;



