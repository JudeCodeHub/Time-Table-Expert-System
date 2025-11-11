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
