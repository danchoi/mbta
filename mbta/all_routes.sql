select 
  max(r.route_type),
  max(r.route_short_name),
  max(r.route_long_name),
  count(r.route_id),
  array_to_string(array_agg(distinct t.trip_headsign), ';')
  from routes r
  left outer join trips t on (t.route_id = r.route_id)
  where 
    t.service_id = 'BUS22018-hbc28011-Weekday-02'
    and t.direction_id = 1
  group by r.route_id
  order by r.route_id

/*

 max | max | max | count |                           array_to_string                           
-----+-----+-----+-------+---------------------------------------------------------------------
   3 | 1   |     |   109 | Dudley
   3 | 10  |     |    42 | Copley;Copley via South Bay Center;Dudley
   3 | 11  |     |    73 | Downtown
   3 | 15  |     |   104 | Dudley;Dudley via Fields Corner;Ruggles
   3 | 16  |     |    54 | Andrew;Andrew via South Bay Center;UMass;UMass via South Bay Center
   3 | 17  |     |    43 | Andrew
   3 | 18  |     |    16 | Andrew
   3 | 19  |     |    32 | Kenmore;Louis Pasteur Ave;Ruggles
   3 | 22  |     |    95 | Ruggles
   3 | 23  |     |   122 | Dudley;Ruggles
   3 | 28  |     |     4 | Dudley;Ruggles
   3 | 43  |     |    49 | Park & Tremont St
   3 | 44  |     |    56 | Ruggles
   3 | 45  |     |    63 | Malcolm X Blvd;Ruggles
   3 | 47  |     |    49 | Broadway
   3 | 5   |     |     7 | McCormack
   3 | 504 |     |     1 | Downtown (Express)
   3 | 55  |     |    32 | Copley;Park St via Copley
   3 | 553 |     |     1 | Downtown via Copley (Express)
   3 | 57  |     |    18 | Kenmore;Union Square Allston
   3 | 57A |     |     1 | Kenmore
   3 | 60  |     |     4 | Brookline Village;Kenmore
   3 | 65  |     |     3 | Kenmore
   3 | 66  |     |   100 | Dudley via Allston
   3 | 7   |     |   104 | Congress & Atlantic;Otis & Summer
   3 | 8   |     |    41 | Kenmore;Kenmore via South Bay Center
   3 | 9   |     |    99 | Copley;Kenmore via Boston Latin
(27 rows)

*/
