select 
  r.route_type,
  r.route_short_name,
  r.route_long_name,
  t.finished_at,
  t.trip_headsign
  from routes r
  left outer join trips t on (t.route_id = r.route_id)
  where 
    r.route_id = '1'
    and t.service_id = 'BUS22018-hbc28011-Weekday-02'
    and t.direction_id = 1
  order by r.route_id, t.finished_at

/*

 route_type | route_short_name | route_long_name | finished_at | trip_headsign 
------------+------------------+-----------------+-------------+---------------
          3 | 1                |                 | 05:33:00    | Dudley
          3 | 1                |                 | 05:53:00    | Dudley
          3 | 1                |                 | 06:13:00    | Dudley
          3 | 1                |                 | 06:29:00    | Dudley
          3 | 1                |                 | 06:50:00    | Dudley
          3 | 1                |                 | 07:06:00    | Dudley
          3 | 1                |                 | 07:18:00    | Dudley
          3 | 1                |                 | 07:28:00    | Dudley
        */
