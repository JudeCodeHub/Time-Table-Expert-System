Intelligent Timetable Generator
<img src="https://img.shields.io/badge/Made%20with-Prolog-blue.svg" alt="Made with Prolog">

A simple expert system built in Prolog that automatically generates a conflict-free university course timetable.

This project was built by team think4ce.

🚀 How to Run
Prerequisites
You need SWI-Prolog (or any other Prolog interpreter) installed.

1. Load the Program
Start Prolog and load the file:

Prolog

?- consult('time.pl').
2. Generate the Timetable
Run the main predicate. This will solve the schedule and save it in memory.

Prolog

?- generate_timetable.
% true.
3. Show the Timetable
Run the display predicate to print the final, clean table.

