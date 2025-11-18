#!/bin/bash

#This script attempts to provide a very quick hourly conversion for seeing available times in other
#major regions around the world. Useful for calculating meeting times - rather than the exact current time
#simply enter the desired hour in base 12 to convert, and it outputs that hour around the globe.
#Limitations: AM/PM are unknown as they are not provided so some sense of where places are located is needed
#Also daylight savings time is difficult to calculate, though a rough translation is provided - some regions may fail 
#during the transition, but 90+% of the time it should be correct.


time=0
thismonth=0

wherearewe=$(date +%z)
hereweare=${wherearewe:1:2}
eastwest=${wherearewe:0:1} #get +/- to determine if eastern or western hemisphere based on GMT

#clear a zero if required
if [ "${hereweare:0:1}" == "0" ]; then
	hereweare=${hereweare:1:1}
fi

#request input
echo "Please enter the hour (base 12) to convert"
read localtime

#convert to GMT standard
if [ "$eastwest" == "+" ]; then
time=$((localtime-$hereweare));
else
time=$((localtime+$hereweare));
fi

#ensure it is based 12 value - not negative and not too high
if [ "$time" -lt "0" ]; then
time=$((time+12));
elif [ "$time" -gt "12" ]; then
time=$((time-12));
fi
echo "Your time in GMT: "$time

#values based on daylight savings time
Europe=$((time+2))
UK=$((time+1))
USEast=$((time-4))
USWest=$((time-7))
Sydney=$((time+10))
AsiaCST=$((time+8))
NewDehli=$((time+5))
Dubai=$((time+4))
Riyadh=$((time+3))

#standard time check - kinda fudged - based on week number
thisweek=$(date +%U)

if [ "$thisweek" -ge "40" ] || [ "$thisweek" -le "14" ]; then
	Sydney=$((Sydney+1))
fi
if [ "$thisweek" -ge "44" ] || [ "$thisweek" -le "11" ]; then
	USEast=$((USEast-1))
	USWest=$((USWest-1))
fi
if [ "$thisweek" -ge "43" ] || [ "$thisweek" -le "13" ]; then
	Europe=$((Europe-1))
	UK=$((UK-1))
fi

#the messy bit, AU, US, UK, and EU daylight savings don't line up with one another, so there is some spill over to deal with
if [ "$wherearewe" == "+01" ] || [ "$wherearewe" == "+02" ] || [ "$wherearewe" == "+00" ]; then
	if [ "$thisweek" -ge "40" ] && [ "$thisweek" -lt "43" ] || [ "$thisweek" -e "13" ]; then
		Sydney=$((Sydney-1))
	fi
fi
if [ "$wherearewe" == "-04" ] || [ "$wherearewe" == "-07" ]; then
	if [ "$thisweek" -ge "40" ] && [ "$thisweek" -lt "44" ] || [ "$thisweek" -ge "11" ] && [ "$thisweek" -le "14" ]; then
		Sydney=$((Sydney-1))
	fi
    if [ "$thisweek" -e "43" ] || [ "$thisweek" -lt "13" ] && [ "$thisweek" -ge "13" ]; then
        Europe=$((Europe+1))
	    UK=$((UK+1))
    fi
fi



#change negative or too large values to base 12

if [ "$Europe" -lt "0" ]; then
	Europe=$((Europe+12));
fi

if [ "$UK" -lt "0" ]; then
	UK=$((UK+12));
fi

if [ "$USEast" -lt "0" ]; then
	USEast=$((USEast+12));
fi

if [ "$USWest" -lt "0" ]; then
	USWest=$((USWest+12));
fi
if [ "$USWest" -lt "0" ]; then
	USWest=$((USWest+12));
fi

if [ "$Sydney" -gt "12" ]; then
	Sydney=$((Sydney-12));
fi

if [ "$AsiaCST" -gt "12" ]; then
	AsiaCST=$((AsiaCST-12));
fi

if [ "$NewDehli" -lt "0" ]; then
	NewDehli=$((NewDehli+12));
elif [ "$NewDehli" -gt "12" ]; then
	NewDehli=$((NewDehli-12));
fi

#output
printf "Europe: "$Europe"\nUK: "$UK"\nUSEast: "$USEast"\nUSWest: "$USWest"\nSydney: "$Sydney"\nAsiaCST: "$AsiaCST"\nNewDehli: "$NewDehli":30\nDuabi: "$Dubai"\nRiyadh: "$Riyadh"\n\n*Note that AM and PM can differ by region so bare in mind that say 1 o'clock in China will be the opposite in say New York depending on the time of year.\n"
