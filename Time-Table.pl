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

% Staff Assignments

teaches(ms_y_kalyani, cs3121).
teaches(mr_s_thadchanamoorthy, cs3121).
teaches(ms_j_janani, cs3122).
teaches(ms_k_krishnaraj, cs3123).
teaches(ms_s_priyanka, cs3124).
teaches(mr_t_thanujan, cs3135).
teaches(mr_t_baskar, eu3101).

%Instructors and Demonstrators

instuctor(mr_w_sriwathsan, cs3111).
instuctor(mr_b_christo_paul, cs3112).
instuctor(mr_w_sriwathsan, cs3113).
instuctor(mr_b_christo_paul, cs3114).

demonstrator(ms_w_d_sewwandi, cs3111).
demonstrator(ms_w_d_sewwandi, cs3112).
demonstrator(mr_i_m_g_d_bandara, cs3113).
demonstrator(mr_i_m_g_d_bandara, cs3114).

% Time Slots

time_slot(Day, Time) :-
    member(Day, [monday, tuesday, wednesday, thursday, friday]),
    member(Time, [830,930,1030,1130,1330,1430,1530]).

% Lecturer Availability


% CS3121
lecturer_available(ms_y_kalyani, tuesday, 830).
lecturer_available(ms_y_kalyani, tuesday, 930).
lecturer_available(ms_y_kalyani, friday, 1030).
lecturer_available(ms_y_kalyani, friday, 1130).
lecturer_available(ms_y_kalyani, monday, 1030).
lecturer_available(ms_y_kalyani, wednesday, 830).

lecturer_available(mr_s_thadchanamoorthy, tuesday, 830).
lecturer_available(mr_s_thadchanamoorthy, tuesday, 930).
lecturer_available(mr_s_thadchanamoorthy, wednesday, 830).
lecturer_available(mr_s_thadchanamoorthy, friday, 930).

% CS3122
lecturer_available(ms_j_janani, thursday, 1330).
lecturer_available(ms_j_janani, thursday, 1430).
lecturer_available(ms_j_janani, monday, 830).
lecturer_available(ms_j_janani, monday, 930).
lecturer_available(ms_j_janani, tuesday, 930).

% CS3123
lecturer_available(ms_k_krishnaraj, monday, 1330).
lecturer_available(ms_k_krishnaraj, tuesday, 1030).
lecturer_available(ms_k_krishnaraj, tuesday, 1130).
lecturer_available(ms_k_krishnaraj, thursday, 830).
lecturer_available(ms_k_krishnaraj, thursday, 930).

% CS3124
lecturer_available(ms_s_priyanka, friday, 830).
lecturer_available(ms_s_priyanka, friday, 930).
lecturer_available(ms_s_priyanka, wednesday, 1030).
lecturer_available(ms_s_priyanka, wednesday, 1130).
lecturer_available(ms_s_priyanka, thursday, 930).

% CS3135
lecturer_available(mr_t_thanujan, tuesday, 1330).
lecturer_available(mr_t_thanujan, tuesday, 1430).
lecturer_available(mr_t_thanujan, wednesday, 930).

% EU3101
lecturer_available(mr_t_baskar, monday, 1030).
lecturer_available(mr_t_baskar, monday, 1130).
lecturer_available(mr_t_baskar, thursday, 1030).
lecturer_available(mr_t_baskar, thursday, 1130).
lecturer_available(mr_t_baskar, tuesday, 1330).
lecturer_available(mr_t_baskar, friday, 1030).

% Practical staff
lecturer_available(mr_w_sriwathsan, thursday, 830).
lecturer_available(mr_w_sriwathsan, thursday, 930).
lecturer_available(mr_w_sriwathsan, friday, 1030).
lecturer_available(mr_w_sriwathsan, friday, 1130).
lecturer_available(mr_w_sriwathsan, wednesday, 1430).
lecturer_available(mr_w_sriwathsan, tuesday, 1330).

lecturer_available(ms_w_d_sewwandi, monday, 830).
lecturer_available(ms_w_d_sewwandi, monday, 930).
lecturer_available(ms_w_d_sewwandi, friday, 1030).
lecturer_available(ms_w_d_sewwandi, friday, 1130).
lecturer_available(ms_w_d_sewwandi, thursday, 1330).
lecturer_available(ms_w_d_sewwandi, tuesday, 930).

lecturer_available(mr_b_christo_paul, monday, 830).
lecturer_available(mr_b_christo_paul, monday, 930).
lecturer_available(mr_b_christo_paul, wednesday, 1030).
lecturer_available(mr_b_christo_paul, wednesday, 1130).
lecturer_available(mr_b_christo_paul, thursday, 1430).
lecturer_available(mr_b_christo_paul, tuesday, 930).

lecturer_available(mr_i_m_g_d_bandara, thursday, 830).
lecturer_available(mr_i_m_g_d_bandara, thursday, 930).
lecturer_available(mr_i_m_g_d_bandara, wednesday, 1030).
lecturer_available(mr_i_m_g_d_bandara, wednesday, 1130).
lecturer_available(mr_i_m_g_d_bandara, wednesday, 1430).

% Relations

related_theory(cs3111, cs3121).
related_theory(cs3112, cs3122).
related_theory(cs3113, cs3123).
related_theory(cs3114, cs3124).

% Slot availability

available_slot(Course, D, T) :-
    course(Course, _, theory),
    teaches(L, Course),
    lecturer_available(L, D, T).

available_slot(Course, D, T) :-
    course(Course, _, practical),
    instuctor(I, Course),
    demonstrator(Demo, Course),
    lecturer_available(I, D, T),
    lecturer_available(Demo, D, T).


available_slot(ssi, wednesday, 1330).
available_slot(ssi, wednesday, 1430).

% Scheduling
schedule_course(C) :-
    required_hours(C, H),
    findall((D,T), available_slot(C,D,T), Slots),
    sort(Slots, SUnique), 
    assign_slots(C, SUnique, H). 

assign_slots(_, _, 0). 
assign_slots(C, [(D,T)|R], H) :-
    H > 0,
    \+ schedule(_, D, T), 
    !,                     
    assertz(schedule(C, D, T)),
    H1 is H - 1,
    assign_slots(C, R, H1).
assign_slots(C, [_|R], H) :- 
    H > 0,
    assign_slots(C, R, H). 


    % Generate whole timetable

cleanup :- retractall(schedule(_,_,_)).


course_constraint(C, L) :-
    course(C, _, _),
    findall((D,T), available_slot(C,D,T), Slots),
    sort(Slots, SUnique),
    length(SUnique, L).


generate_timetable :-
    cleanup,
    get_scheduled_order(CoursesToSchedule),
    forall(member(C, CoursesToSchedule), schedule_course(C)).

get_scheduled_order(SortedCourses) :-
    findall(SlotCount-Course, course_constraint(Course, SlotCount), ConstraintPairs),
    keysort(ConstraintPairs, SortedPairs),
    pairs_values(SortedPairs, SortedCourses).


% Display as table
show_timetable :-
    Days = [monday,tuesday,wednesday,thursday,friday],
    
    Headers = [time, mon, tue, wed, thu, fri], 
    
    Times = [830,930,1030,1130,1330,1430,1530],
    
    nl, write('============================= TIMETABLE ================================================'), nl,
    
    forall(member(H, Headers), (format('~w\t\t',[H]))),
    nl,
    
    write('-----------------------------------------------------------------------------------------'), nl,
    
    forall(member(T, Times),
           (format('~w\t\t', [T]), % Print the time, e.g., "830"
            
            % Loop through original day atoms (monday, tuesday, etc.) for lookup
            forall(member(D, Days), 
                   ( (schedule(C,D,T), !, format('~w\t\t',[C]))
                   ; write('-\t\t'))),
            nl)),
    write('========================================================================================='), nl.
