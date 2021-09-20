# HourConversion
This is a BASH script that helps give an hourly conversion in different time zones around the world. It's based on the local date and timezone of the local system and should automatially adjust baesd on the system date and time. 

This script works completely offline with some simple math and the date function in Linux/POSIX systems with the BASH terminal. Daylight savings time is also factored in using the week number for when they shoudl take place as that is also available from the date command, though note it's assumed the time one is trying to convert is to take place the same week of the calculation.

What this is useful for is to allow for quick calculation of when to schedule a meeting. Say for example you want to schedule a meeting in Asia but you live in Europe - just enter the local time for your timezone, and the output will give you the hour.

It is designed to be fast, and as such omits some details - like AM or PM - so be mindful of the geography to work out a time might be too early or too late. For example 6 PM in Asia will show up as 3 in the output for PST (US West), but that is 3 AM, not PM. 

*Installation*<br>
For those not familiar with BASH you can simply copy or clone the script and run it from a local directory - i.e. ./timeconverter.sh. BASH is the Bourne Again Shell and requires that shell to be installed, though changing the initial #!/bin/<shell of choice> may also work. In Windows, this should work if users have WSL (Windows Subsystem for Linux) running with BASH. 

The script should as a minimum need execution rights to run so if you are the local user that would be chmod 500 timeconverter.sh. 
  
To add this as a user PATH so that one may invoke it anytime simply copy the script to the /usr/local/bin or /home/(user)/.local/bin directory in Linux (distro dependent). 

A sample of how it works is here:<br>
<div align='center'><img width='540px' src='https://1.bp.blogspot.com/-BwbpwsGdKzE/X7ibgH2IrBI/AAAAAAAAAFk/lCMKZpzAujYLG8ZtWgciRcHfYghM1HoJACLcBGAsYHQ/w586-h413/timeconverter.gif'></div>
