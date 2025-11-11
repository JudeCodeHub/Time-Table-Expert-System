Intelligent Timetable Generator
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

Prolog

?- show_timetable.
🎬 Example Output
============================= TIMETABLE =============================
time		mon		tue		wed		thu		fri		
---------------------------------------------------------------------
830		cs3112		cs3121		cs3121		cs3113		cs3124		
930		cs3112		cs3122		cs3135		cs3113		cs3124		
1030		eu3101		cs3123		cs3114		eu3101		cs3111		
1130		eu3101		cs3123		cs3114		eu3101		cs3111		
1330		cs3123		cs3135		ssi		cs3122		-		
1430		-		-		ssi		-		-		
1530		-		-		-		-		-		
=====================================================================
true.
