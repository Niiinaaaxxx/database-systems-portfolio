# Question 1
Select carrier,flight, dest, air_time,month
From flights
Order By air_time DESC;
# The longest air time for all flights out of EWR is 666 mins 
# UA, and destination is HNL. 

# Question 2 
Select carrier,flight, dest, air_time
From flights
Order By air_time;
# The flight 4631 was the shortest air time for all flights, EV flew this flight and destination is BDL 

#Question 3
# Write a query to produce a list of flights including airline, flight number, destination airport and distance. 
# What was the longest distance flown by planes with between 20 and 60 seats? 
Select carrier, flight, dest, distance,seats
From flights 
Join planes on flights.tailnum =  planes.tailnum
Where seats Between 20 and 60
Order By distance DESC
;
# The logest distance is 1325

# Question 4
# How many different destinations did United Airlines flights fly to in April, 2013?
Select Count(Distinct dest)
From flights
Where carrier IN ("UA")
;
# 29 different destinations 

# Question 5
# Write a query to produce a list of flights including 
#flight date, carrier, flight number, destination, scheduled departure, actual departure, scheduled arrival, actual arrival, gain and gain/hour. 
Select 
	DATE_FORMAT(CONCAT(year, '-', month, '-', day), '%m/%d/%y') AS date,
	carrier, flight, dest, air_time,
	Time_format(CONCAT(sched_dep_time,"00"), '%T') AS sched_dep, 
	Time_format(CONCAT(dep_time,"00"), '%T') AS actual_dep, 
	Time_format(CONCAT(sched_arr_time,"00"), '%T') AS sched_arr, 
	Time_format(CONCAT(arr_time, "00"), '%T') AS actual_arr,
    (dep_delay - arr_delay) AS gain,
    (dep_delay - arr_delay) / (air_time ) AS gain_per_hour
From flights
#Where flight = 1182 and dest = "PHX"
ORDER BY gain DESC, flight
;

# Question 6 
Select 
	DATE_FORMAT(CONCAT(year, '-', month, '-', day), '%m/%d/%y') AS date,
	carrier, flight, dest, air_time,
	Time_format(CONCAT(sched_dep_time,"00"), '%T') AS sched_dep, 
	Time_format(CONCAT(dep_time,"00"), '%T') AS actual_dep, 
	Time_format(CONCAT(sched_arr_time,"00"), '%T') AS sched_arr, 
	Time_format(CONCAT(arr_time, "00"), '%T') AS actual_arr,
    (dep_delay - arr_delay) AS gain,
    (dep_delay - arr_delay) / (air_time ) AS gain_per_hour
From flights
#Where flight = 1182 and dest = "PHX"
ORDER BY gain_per_hour, flight
;
# Worst gain: flight 2083 with gain -148
# Worst gain/hour: flight 5667 with -1.9216 gain/hour 

# Question 7 
Select 
DATE_FORMAT(CONCAT(flights.year, '-', flights.month, '-', flights.day), '%m/%d/%y') AS date,
MAKETIME(FLOOR(flights.sched_dep_time / 100), MOD(flights.sched_dep_time, 100), 0) AS sched_dep,
flights.dep_delay,
weather.temp,
weather.wind_speed,
weather.wind_gust,
weather.precip,
weather.visib
From flights 
LEFT Join weather On flights.time_hour = weather.time_hour
Order by dep_delay DESC
;
