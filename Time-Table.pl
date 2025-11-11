% Dynamic Predicate
:- dynamic schedule/3.

% Course Data
course(cs3121, 'Logic Programming and Expert System', theory).
course(cs3111, 'Practical work on CS3121', practical).
course(cs3122, 'Advanced Database Management Systems', theory).
course(cs3112, 'Practical work on CS3122', practical).
course(cs3123, 'Systems & Network Administration', theory).
course(cs3113, 'Practical work on CS3123', practical).
course(cs3124, 'Data Security', theory).
course(cs3114, 'Practical work on CS3124', practical).
course(cs3135, 'Theory of Computing', theory).
course(eu3101, 'Foundation of Management', theory).
course(ssi, 'Staff-Student interaction', meeting). % 'ssi' is the short ID

% Required Hours per Course

required_hours(cs3121, 3).
required_hours(cs3111, 2).
required_hours(cs3122, 2).
required_hours(cs3112, 2).
required_hours(cs3123, 3).
required_hours(cs3113, 2).
required_hours(cs3124, 2).
required_hours(cs3114, 2).
required_hours(cs3135, 2).
required_hours(eu3101, 4).

required_hours(ssi, 2).
