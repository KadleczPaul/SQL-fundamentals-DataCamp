Jurnal de învățare SQL - DataCamp Intermediate
Aici îmi salvez propriile rezolvări la problemele de SQL pe care le-am făcut pentru a exersa.

1. Setul de date cu zboruri (Flights)
Problema 1: Analiza zborurilor și a întârzierilor

select airline, 
	count(flight_id) as total_zboruri,
	count(case when delay_minutes > 30 then flight_id END) as zbori_delay_majore, 
	(100 * count(case when delay_minutes > 30 then flight_id END)) / count(flight_id) as procentaj_intarzieri
 from flights
 group by airline having avg(fuel_efficiency) > 2.5;

Problema 2: Cel mai eficient zbor lung

select airline, flight_id, distance, fuel_efficiency
from flights
where distance > 3000
order by fuel_efficiency asc limit 1;

Problema 3: Categorisirea zborurilor (scurte vs. lungi) și medii

select airline, 
	count(case when distance < 1000 then flight_id END) as zboruri_scurte,
	count(case when distance >= 1000 then flight_id END) as zboruri_lungi, 
	avg(case when total_seats >= 200 then delay_minutes END) as medie_intarziere 
from flights 
group by airline 
having count(case when distance >= 1000 then flight_id END) > 0;

2. Setul de date cu platforma de streaming
Problema 1: Analiza pe utilizator (timp total vs timp pe filme de acțiune)

select user_id, 
	sum(watch_minutes), 
	sum(case when genre = 'Action' then watch_minutes END) as action_time, 
	round((100 * sum(case when genre = 'Action' then watch_minutes END)) / sum(watch_minutes),2) as medie_actiune
from viewing_history 
group by user_id;

Problema 2: Analiză pe genuri (filme vs seriale)

select genre, 
	count(view_id), 
	avg(CASE WHEN content_type = 'Movie' then rating END) as avg_movie, 
	avg(case when content_type = 'Series' then rating END) as avg_series 
from viewing_history 
group by genre 
having sum(watch_minutes) > 200;
