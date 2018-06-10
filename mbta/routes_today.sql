select 
  r.route_type,
  r.route_short_name,
  r.route_long_name,
  t.service_id,
  t.finished_at,
  t.trip_headsign
  from routes r
  left outer join trips t on (t.route_id = r.route_id)
  where 
    t.service_id in (select active_services(adjusted_date(now())))
    
  order by r.route_id, t.finished_at

/*

         
 route_type | route_short_name |                route_long_name                |              service_id               | finished_at |                  trip_headsign                  
------------+------------------+-----------------------------------------------+---------------------------------------+-------------+-------------------------------------------------
          3 | 1                |                                               | BUS22018-hbc28017-Sunday-02           | 06:22:00    | Harvard
          3 | 1                |                                               | BUS22018-hbc28017-Sunday-02           | 06:35:00    | Dudley
          3 | 1                |                                               | BUS22018-hbc28017-Sunday-02           | 06:47:00    | Harvard
          3 | 1                |                                               | BUS22018-hbc28017-Sunday-02           | 06:55:00    | Dudley
          3 | 1                |                                               | BUS22018-hbc28017-Sunday-02           | 07:09:00    | Harvard
          3 | 1                |                                               | BUS22018-hbc28017-Sunday-02           | 07:15:00    | Dudley
          3 | 1                |                                               | BUS22018-hbc28017-Sunday-02           | 07:32:00    | Harvard
          3 | 1                |                                               | BUS22018-hbc28017-Sunday-02           | 07:35:00    | Dudley

        */
