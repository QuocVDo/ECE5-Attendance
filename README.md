# ECE5-Attendance
MATLAB GUI Application that can be used to scan in  students for attendance purposes. 

## How to Use
1. Download the Student Roster from the Google Drive as a .XLSX
* The column format must be in this order (First Name, Last Name,  PID, email, Scanned Barcode)
* This is modeled after the FA22 Roster.
---
2. Put the Student Roster into the same folder as all the other MATLAB files that you are running from
---
3. Run my script: RosterXLStoMAT.m
* Make sure to change the  xlsread()  parameter so it matches  the file  name
* i.e. xlsread('student_roster.xlsx', A2:E200)
* The second parameter tells MATLAB which rows/cols to read. 
* In the case where we have more than 200 students then change it to like A2:E250 for 250 students for example
---
4. The script will generate the classinfo.mat that the GUI script will expect, clean up the data, remove NaN values etc.
---
5. Run the  SignIn_GUI.m script
---
6. Either type the student's PID into the box or click into the box and then scan their ID card.
---
7. If the background turns green we are good. The script will now generate a file called Attendance_(todays date)
* this will hold the first and last names of the students that were signed in.
---
8. If the background turns red then we could not find their ID
* IF the student needs to be added, create a whole new row in the Student Roster with their info
* If the student just needs an ID to be added, CTRL + F for their name and then add their SSID into the column
* Don't forget to save the excel file
* Run the RosterXLStoMAT.m script again to regenerate the database.

---
## Important!
If you close and reopen the Sign in GUI then it will autogenerate another attendance list in this format: 
##### Attendance_10_9_2022_RANDOMNUMBER. 
It will say attendance, the date and then generate a random number so you don't overwrite the old file.

This is kind of a hacky solution but you only have a 0.1%  chance of colliding  with the old file and overwriting it so if this happens then GG lol you've 
erased the attendance data for the day.

###  SOLUTION: Don't close and reopen the GUI, just scan everyone in a single go

