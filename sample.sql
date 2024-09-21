select USER_COUNTRY, count(distinct USER_ID) as EVENTS_COUNT from EVENTS
group by USER_COUNTRY
order by count(distinct USER_ID) desc
