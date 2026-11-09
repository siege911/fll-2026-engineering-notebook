-- 2026-11-09 · fix for 2026-11-08-mission-times-trifold.sql: the Nov 8 Teamwork moment had help = '[]'; the page expects NULL when no one helped someone (help tally reads [giver, receiver]).
UPDATE moments SET help = NULL WHERE date = '2026-11-08' AND source = 'update' AND help = '[]';
