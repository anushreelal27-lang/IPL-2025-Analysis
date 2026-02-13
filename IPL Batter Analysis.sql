use ipl;
-- Total players
SELECT COUNT(*) AS total_players
FROM ipl_batting_analytics;

-- Teams present
SELECT DISTINCT `Team`
FROM ipl_batting_analytics;

-- Top run scorers
SELECT `Player Name`, `Team`, `Runs`
FROM ipl_batting_analytics
ORDER BY `Runs` DESC
LIMIT 10;
-- Most consistent batsmen
SELECT `Player Name`, `Team`, `AVG`
FROM ipl_batting_analytics
WHERE `Matches` >= 10
ORDER BY `AVG` DESC
LIMIT 10;

-- Strike rate hitters
SELECT `Player Name`, `Team`, `SR`
FROM ipl_batting_analytics
WHERE `BF` >= 100
ORDER BY `SR` DESC
LIMIT 10;

-- Anchor players
SELECT `Player Name`, `Team`, `AVG`, `SR`
FROM ipl_batting_analytics
WHERE `AVG` > 35 AND `SR` BETWEEN 120 AND 140
ORDER BY `AVG` DESC;

-- Boundary kings
SELECT `Player Name`, `Team`,
       (`4s`*4 + `6s`*6) AS boundary_runs
FROM ipl_batting_analytics
ORDER BY boundary_runs DESC
LIMIT 10;

-- Match winners
SELECT `Player Name`, `Team`,
       (`100s`*2 + `50s`) AS impact_score
FROM ipl_batting_analytics
ORDER BY impact_score DESC
LIMIT 10;
-- Best batting team
SELECT `Team`,
       SUM(`Runs`) AS team_runs,
       AVG(`SR`) AS avg_strike_rate
FROM ipl_batting_analytics
GROUP BY `Team`
ORDER BY team_runs DESC;

-- Best batsman per team
SELECT b1.`Team`, b1.`Player Name`, b1.`Runs`
FROM ipl_batting_analytics b1
WHERE b1.`Runs` = (
    SELECT MAX(b2.`Runs`)
    FROM ipl_batting_analytics b2
    WHERE b1.`Team` = b2.`Team`
);
-- Batting role classification
SELECT `Player Name`, `Team`,
CASE
    WHEN `SR` > 150 THEN 'Finisher'
    WHEN `AVG` > 40 THEN 'Anchor'
    WHEN `SR` BETWEEN 130 AND 150 THEN 'Balanced Batter'
    ELSE 'Support Batter'
END AS batting_role
FROM ipl_batting_analytics;

-- MVP score
SELECT `Player Name`, `Team`,
       (`Runs` + `100s`*50 + `50s`*20 + `6s`*2 + `SR`/5) AS mvp_score
FROM ipl_batting_analytics
ORDER BY mvp_score DESC
LIMIT 10;

-- Runs per match
SELECT `Player Name`, `Team`,
       (`Runs`/`Matches`) AS runs_per_match
FROM ipl_batting_analytics
WHERE `Matches` > 5
ORDER BY runs_per_match DESC
LIMIT 10;



