select 
  max(r.route_type) route_type,
  max(r.route_short_name) short_name,
  max(r.route_long_name) long_name,
  max(t.direction_id) direction_id,
  count(r.route_id) trips,
  array_to_string(array_agg(distinct t.trip_headsign), ';')
  from routes r
  left outer join trips t on (t.route_id = r.route_id)
  where 
    t.service_id in (select active_services(adjusted_date(now())))
  group by r.route_id, t.direction_id
  order by r.route_id

/*
 route_type | short_name |                   long_name                   | direction_id | trips |                                        array_to_string                                         
------------+------------+-----------------------------------------------+--------------+-------+------------------------------------------------------------------------------------------------
          3 | 1          |                                               |            0 |    67 | Harvard
          3 | 1          |                                               |            1 |    67 | Dudley
          3 | 10         |                                               |            0 |    23 | City Point;City Point via South Bay Center
          3 | 10         |                                               |            1 |    24 | Copley;Copley via South Bay Center
          3 | 100        |                                               |            0 |    19 | Elm St;Roosevelt Cir via Fellsway
          3 | 100        |                                               |            1 |    20 | Wellington
          3 | 101        |                                               |            0 |    17 | Malden;Stevens Square
          3 | 101        |                                               |            1 |    17 | Sullivan
          3 | 104        |                                               |            0 |    21 | Malden
          3 | 104        |                                               |            1 |    21 | Sullivan
          3 | 105        |                                               |            0 |    11 | Malden
          3 | 105        |                                               |            1 |    11 | Sullivan
          3 | 106        |                                               |            0 |    20 | Lebanon Loop
          3 | 106        |                                               |            1 |    19 | Malden;Wellington
          3 | 108        |                                               |            0 |    11 | Linden Square
          3 | 108        |                                               |            1 |    11 | Wellington
          3 | 109        |                                               |            0 |    21 | Linden Square
          3 | 109        |                                               |            1 |    22 | Sullivan
*/

