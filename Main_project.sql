REM   Script: Multiplex Management System
REM   All working added

REM   Script: Project_final 


REM   Main 


create table theatre_st(  
    city varchar2(20) not null,  
    state varchar2(20) not null,  
    constraint pk_city primary key(city)  
);

create table theatre_loc(  
    location varchar2(20) not null,  
    city varchar2(20) not null,  
    constraint pk_loc primary key(location),  
    constraint fk_city1 foreign key(city) references theatre_st on delete cascade  
);

create table theatre(  
    th_id number(3) constraint pk_thid primary key,  
    location varchar2(20) not null,  
    constraint fk_loc1 foreign key(location) references theatre_loc on delete cascade  
      
);

create table screen_name(  
    screen_id number(2) not null,  
    screen_name varchar2(3) not null,  
    constraint pk_scid primary key(screen_id)  
);

create table screen(  
    screen_id number(2) not null,  
    th_id number(3) not null,  
    silver_seats number(2) not null,  
    gold_seats number(2) not null,  
    constraint pk_sc_thid primary key (screen_id, th_id),  
    constraint fk_thid foreign key (th_id) references theatre ON DELETE CASCADE,  
    constraint fk_sid foreign key(screen_id) references screen_name on delete cascade  
);

create table employee_jsal(  
   th_id number(3) not null,   
   job varchar2(30) not null,  
   sal number(7,2) not null,  
   comm number(7,2) null,  
   constraint pk_thid_job primary key(th_id,job),  
   constraint fk_thid1 foreign key(th_id) references theatre on delete cascade  
);

create table employee(  
    eid integer not null,  
    ename varchar2(40) null,  
    email varchar2(40) null,  
    job varchar2(30) null,  
    hiredate date,  
    th_id number(3) not null,  
    constraint pk_eid_thid primary key (eid,th_id),  
    constraint fk_thid1_job1 foreign key (th_id,job) references employee_jsal ON DELETE CASCADE  
);

create table employee_num(  
   eid integer not null,  
   th_id number(3) not null,  
   phone_num varchar2(20) null,  
   constraint pk_eid_thid_no primary key (eid,th_id,phone_num),  
   constraint fk_eid_thid foreign key (eid,th_id) references employee ON DELETE CASCADE  
);

create table projectionist(  
    pid integer not null,  
    th_id number(3) not null,  
    shift varchar2(40) not null,  
      
    constraint pk_pid_thid primary key (pid,th_id),  
    constraint fk_pid_thid foreign key (pid,th_id) references employee ON DELETE CASCADE  
);

create table projection_room(  
    screen_id number(2) not null,  
    th_id number(3) not null,  
    server varchar2(30) not null,  
    constraint pk_sc1_thid1 primary key(screen_id,th_id),  
    constraint fk_sid_thid foreign key(screen_id,th_id) references screen on delete cascade  
);

create table projection_type(  
    screen_id number(2) not null,  
    th_id number(3) not null,  
    type varchar2(20) not null,  
    constraint pk_sc_thid_ty primary key(screen_id,th_id,type),  
    constraint fk_sid1_thid1 foreign key(screen_id,th_id) references projection_room on delete cascade  
  
);

create table movie(  
    mov_name varchar2(100) not null,  
    release_dt date not null,  
    duration varchar2(10) null,  
    constraint pk_movn primary key(mov_name)  
);

create table movie_genre(  
    mov_name varchar2(100) not null,  
    genre varchar2(50) not null,  
    constraint pk_movid_g primary key(mov_name,genre),  
    constraint fk_movid foreign key(mov_name) references movie on delete cascade  
);

create table movie_lang(  
   mov_name varchar2(100) not null,  
   language varchar2(50) null,  
   constraint pk_movid_l primary key(mov_name,language),  
   constraint fk_movid1 foreign key(mov_name) references movie on delete cascade  
);

create table movie_share(  
   mov_name varchar2(100) not null,  
   budget varchar2(30) not null,  
   mov_share varchar2(10) null,  
   constraint pk_movid_bd primary key(mov_name,budget),  
   constraint fk_movid2 foreign key(mov_name) references movie on delete cascade  
);

create table shows(  
    mov_name varchar2(40) not null,  
    sdatetime date not null,  
    runtime varchar2(30) null,  
    screen_id number(2) not null,  
    th_id number(3) not null,  
    constraint pk_sdt_sid_tid primary key (sdatetime, screen_id, th_id),  
    constraint fk_sid2_thid2 foreign key (screen_id, th_id) references screen ON DELETE CASCADE  
);

create table silver_price(  
   th_id number(3) not null,  
   screen_id number(2) not null,  
   sdatetime date not null,  
   price number(4) not null,  
   constraint pk_thid2_sid2_sdt2 primary key(th_id,screen_id,sdatetime),  
   constraint fk_sdt3_sid3_thid3 foreign key(sdatetime, screen_id, th_id) references shows ON DELETE CASCADE  
);

create table gold_price(  
   th_id number(3) not null,  
   screen_id number(2) not null,  
   sdatetime date not null,  
   price number(4) not null,  
   constraint pk_thid_sid_sdt primary key(th_id,screen_id,sdatetime),  
   constraint fk_sdt1_sid1_thid1 foreign key(sdatetime, screen_id, th_id) references shows ON DELETE CASCADE  
);

create table silver_seat(  
    silver_seatnum varchar2(5) not null,  
    screen_id number(2) not null,  
    th_id number(3) not null,  
    sdatetime date not null,  
    avail number(1) not null,  
    constraint pk_ssno_sid_thid_sdt primary key (silver_seatnum, screen_id, th_id, sdatetime),  
    constraint fk_sdt_sid1_thid1 foreign key (th_id,screen_id,sdatetime) references silver_price ON DELETE CASCADE   
);

create table gold_seat(  
    gold_seatnum varchar2(5) not null,  
    screen_id number(2) not null,  
    th_id number(3) not null,  
    sdatetime date not null,  
    avail number(1) not null,  
    constraint pk_gsno_sid_thid_sdt primary key (gold_seatnum, screen_id, th_id, sdatetime),  
    constraint fk_sdt_sid2_thid2 foreign key (th_id,screen_id,sdatetime) references gold_price ON DELETE CASCADE   
);

create table customer(  
    cid int not null,  
    cname varchar2(40) null,  
    phone_num varchar2(20) null,  
    email varchar2(40) null,  
    payment_method varchar2(40) not null,  
    th_id number(3) not null,  
    constraint pk_cid primary key(cid),  
    constraint fk_thid2 foreign key(th_id) references theatre ON DELETE CASCADE  
);

create table silverticket(  
    ticket_id number(7) not null,  
    nprice number(4) not null,  
    bk_dt_time date,  
    bk_type varchar2(10) not null,  
    sdatetime date not null,  
    screen_id number(2) not null,  
    th_id number(3) not null,  
    silver_seatnum varchar2(5) not null,  
    cid int not null,  
    constraint pk_stid_thid primary key (ticket_id,th_id),  
    constraint fk_ssno1_sid1_thid1_sdt1 foreign key (silver_seatnum, screen_id, th_id, sdatetime) references silver_seat ON DELETE CASCADE  
);

create table goldticket(  
    ticket_id number(7) not null,  
    nprice number(4) not null,  
    bk_dt_time date,  
    bk_type varchar2(10) not null,  
    sdatetime date not null,  
    screen_id number(2) not null,  
    th_id number(3) not null,  
    gold_seatnum varchar2(5) not null,  
    cid int not null,  
    constraint pk_gtid_thid primary key (ticket_id,th_id),  
    constraint fk_gsno2_sid2_thid2_sdt2 foreign key (gold_seatnum, screen_id, th_id, sdatetime) references gold_seat ON DELETE CASCADE  
);

create table box_office(  
    mov_name varchar2(40) not null,  
    sdatetime date not null,  
    screen_id number(2) not null,  
    th_id number(3) not null,  
      
    constraint pk_thid_sdt_mov1 primary key(mov_name,sdatetime,th_id),  
    constraint fk_sdt_thid3_sid foreign key(sdatetime, screen_id, th_id) references shows ON DELETE CASCADE  
);

create table website(  
    mov_name varchar2(40) not null,  
    sdatetime date not null,  
    screen_id number(2) not null,  
    th_id number(3) not null,  
     
    constraint pk_thid1_sdt11_mov1 primary key(mov_name,sdatetime,th_id),  
    constraint fk_thid1_sdt1_sid foreign key (sdatetime, screen_id, th_id) references shows ON DELETE CASCADE  
);

insert into theatre_st values('Vadodara','Gujarat');

insert into theatre_st values('Ahemdabad','Gujarat');

insert into theatre_loc values('Akota','Vadodara');

insert into theatre_loc values('Sarkhej','Ahemdabad');

insert into theatre values(100,'Akota');

insert into theatre values(101,'Sarkhej');

insert into screen_name values(10,'1A');

insert into screen_name values(11,'2B');

insert into screen_name values(12,'3C');

insert into screen values(10,100,7,10);

insert into screen values(11,100,8,11);

insert into screen values(12,100,5,9);

insert into screen values(10,101,10,15);

insert into screen values(11,101,7,10);

insert into screen values(12,101,9,15);

insert into employee_jsal values(100,'Manager',10000,1000);

insert into employee_jsal values(100,'Accountant',9000,null);

insert into employee_jsal values(100,'Projectionist',7000,null);

insert into employee_jsal values(100,'Clerk',5000,null);

insert into employee_jsal values(101,'Manager',9000,500);

insert into employee_jsal values(101,'Accountant',8000,null);

insert into employee_jsal values(101,'Projectionist',5000,null);

insert into employee_jsal values(101,'Clerk',3000,null);

insert into employee values(100000,'Kashish','kash@mail.com','Accountant','7-Jan-2017',100);

insert into employee values(100100,'Chatur','ch2@mail.com','Manager','17-May-2017',100);

insert into employee values(100101,'Daniel','daniel@mail.com','Projectionist','11-April-2019',100);

insert into employee values(100000,'Seema','sem@mail.com','Clerk','21-July-2015',101);

insert into employee values(100100,'Arman','am@mail.com','Accountant','5-October-2017',101);

insert into employee values(100101,'Sachi','sachi@mail.com','Manager','15-September-2018',101);

insert into employee values(100003,'Anand','anand@mail.com','Projectionist','2-August-2019',101);

insert into employee_num values(100000,100,'2834701781');

insert into employee_num values(100000,100,'8737086712');

insert into employee_num values(100100,100,'2821839733');

insert into employee_num values(100101,100,'2173616354');

insert into employee_num values(100000,101,'9773073686');

insert into employee_num values(100100,101,'9829870135');

insert into employee_num values(100100,101,'81273867878');

insert into employee_num values(100101,101,'9207476539');

insert into employee_num values(100101,101,'9876363550');

insert into projectionist values(100101,100,'First shift');

insert into projectionist values(100003,101,'Third shift');

insert into projection_room values(10,100,'Doremi');

insert into projection_room values(11,100,'Dolby');

insert into projection_room values(12,100,'Doremi');

insert into projection_room values(10,101,'Doremi');

insert into projection_room values(11,101,'Doremi');

insert into projection_room values(12,101,'Dolby');

insert into projection_type values(10,100,'2D');

insert into projection_type values(10,100,'3D');

insert into projection_type values(11,100,'2D');

insert into projection_type values(12,100,'2D');

insert into projection_type values(10,101,'2D');

insert into projection_type values(10,101,'3D');

insert into projection_type values(11,101,'2D');

insert into projection_type values(11,101,'3D');

insert into projection_type values(12,101,'2D');

insert into movie values('Tu Jhuthi Main Makkar','3-Feb-2023','2:00:00');

insert into movie values('Brahmastra:Part One-Shiva','9-September-2022','2:30:00');

insert into movie_genre values('Tu Jhuthi Main Makkar','Romance');

insert into movie_genre values('Tu Jhuthi Main Makkar','Comedy');

insert into movie_genre values('Brahmastra:Part One-Shiva','Fantasy');

insert into movie_genre values('Brahmastra:Part One-Shiva','Action');

insert into movie_genre values('Brahmastra:Part One-Shiva','Drama');

insert into movie_lang values('Tu Jhuthi Main Makkar','Hindi');

insert into movie_lang values('Brahmastra:Part One-Shiva','Hindi');

insert into movie_lang values('Brahmastra:Part One-Shiva','Tamil');

insert into movie_share values('Tu Jhuthi Main Makkar','100 crore','30%');

insert into movie_share values('Brahmastra:Part One-Shiva','400 crore','40%');

create or replace trigger t3 after insert or update on shows for each row  
begin  
   insert into box_office values(:new.mov_name,:new.sdatetime,:new.screen_id,:new.th_id);  
end;  
/

create or replace trigger t4 after insert or update on shows for each row  
begin     
   insert into website values(:new.mov_name,:new.sdatetime,:new.screen_id,:new.th_id);  
end;  
/

insert into shows values('Tu Jhuthi Main Makkar', to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), '2.5 hrs', 10, 100);

insert into shows values('Brahmastra:Part One-Shiva', to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), '3 hrs', 11, 100);

insert into silver_price values(100,10,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),50);

insert into gold_price values(100,10,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),100);

insert into silver_price values(100,11,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),70);

insert into gold_price values(100,11,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),150);

insert into silver_seat values('A1', 10, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A2', 10, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A3', 10, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A4', 10, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A5', 10, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A6', 10, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A7', 10, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B1', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B2', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B3', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B4', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B5', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B6', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B7', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B8', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A1', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A2', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A3', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A4', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A5', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A6', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into silver_seat values('A7', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B1', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B2', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B3', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B4', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B5', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B6', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B7', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B8', 11, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into customer values(1,'Akash', '6047773422','ak12@mail.com','MasterCard', 100);

insert into customer values(2, 'Alok', '1273621422','alok_42@mail.com','Cash', 101);

insert into customer values(3,'Sahana', '1747773422','sp@mail.com','MasterCard', 100);

create or replace trigger t1  
    after insert on silverticket for each row  
begin  
    update silver_seat set avail=0 where sdatetime=:new.sdatetime and screen_id=:new.screen_id and th_id=:new.th_id and silver_seatnum=:new.silver_seatnum;  
   end;  
/

create or replace trigger t2  
    after insert on goldticket for each row  
begin  
    update gold_seat set avail=0 where sdatetime=:new.sdatetime and screen_id=:new.screen_id and th_id=:new.th_id and gold_seatnum=:new.gold_seatnum;  
   end;  
/

create trigger t5 before insert on silverticket for each row  
declare  
t_count number:=0;  
begin  
select count(1) into t_count from silverticket where silver_seatnum=:new.silver_seatnum and sdatetime=:new.sdatetime and th_id=:new.th_id and screen_id=:new.screen_id;  
if t_count>0  
then  
raise_application_error(-20202,'Silver seatnum '||:new.silver_seatnum||' already booked');  
end if;  
end;  
/

create trigger t6 before insert on goldticket for each row  
declare  
g_count number:=0;  
begin  
select count(1) into g_count from goldticket where gold_seatnum=:new.gold_seatnum and sdatetime=:new.sdatetime and th_id=:new.th_id and screen_id=:new.screen_id;  
if g_count>0  
then  
raise_application_error(-20202,'Gold seatnum '||:new.gold_seatnum||' already booked');  
end if;  
end;  
/

create trigger t7 before insert on silver_seat for each row  
declare  
g_count number:=0;  
n screen.silver_seats%type;  
begin  
select silver_seats into n from screen where th_id=:new.th_id and screen_id=:new.screen_id;  
select count(*) into g_count from silver_seat where sdatetime=:new.sdatetime and th_id=:new.th_id and screen_id=:new.screen_id;  
if g_count>=n  
then  
raise_application_error(-20202,'Maximum Silver seats capacity exceeded.');  
end if;  
end;  
/

create trigger t8 before insert on gold_seat for each row  
declare  
g_count number:=0;  
n screen.gold_seats%type;  
begin  
select gold_seats into n from screen where th_id=:new.th_id and screen_id=:new.screen_id;  
select count(*) into g_count from gold_seat where sdatetime=:new.sdatetime and th_id=:new.th_id and screen_id=:new.screen_id;  
if g_count>=n  
then  
raise_application_error(-20202,'Maximum gold seats capacity exceeded.');  
end if;  
end;  
/

create trigger t9 before insert on silverticket for each row  
declare  
g_count number:=0;  
begin  
select count(1) into g_count from goldticket where ticket_id=:new.ticket_id and sdatetime=:new.sdatetime and th_id=:new.th_id and screen_id=:new.screen_id;  
if g_count>0  
then  
raise_application_error(-20202,'Silver ticket id ane gold ticket id cannot be same for a movie show');  
end if;  
end;  
/

create trigger t10 before insert on goldticket for each row  
declare  
g_count number:=0;  
begin  
select count(1) into g_count from silverticket where ticket_id=:new.ticket_id and sdatetime=:new.sdatetime and th_id=:new.th_id and screen_id=:new.screen_id;  
if g_count>0  
then  
raise_application_error(-20202,'Silver ticket id ane gold ticket id cannot be same for a movie show');  
end if;  
end;  
/

create procedure p1(thid in shows.th_id%type,mov in shows.mov_name%type)  
    is   
    sdatetime shows.sdatetime%type;  
    cursor c1 is select to_char(sdatetime,'dd-mon-yyyy hh:mi:ss am') as sdatetime from shows where mov_name=mov and th_id=thid;   
    r1 c1%rowtype;  
    type t1 is table of r1%type;  
l1 t1;  
begin  
    open c1;  
    fetch c1 bulk collect into l1;  
    close c1;  
    dbms_output.put_line('Show date and time for movie '||mov||' are');  
for i in 1..l1.count   
    loop  
    dbms_output.put_line(l1(i).sdatetime);  
end loop;  
end;  
/

declare   
    m shows.mov_name%type;  
    th shows.th_id%type;  
    sdt1 shows.sdatetime%type;   
begin  
    m:='Tu Jhuthi Main Makkar';  
    th:=100;  
p1(th,m);  
end;  
/

create function f1(thid in shows.th_id%type,sdt in shows.sdatetime%type,mov in shows.mov_name%type) return number  
    is sid number(2);  
begin  
select screen_id into sid from shows where sdatetime=sdt and th_id=thid and mov_name=mov;  
return sid;  
end;  
/

create procedure p2(thid in silver_seat.th_id%type,sdt in silver_seat.sdatetime%type,sid in silver_seat.screen_id%type)  
is   
    cursor c1 is select * from silver_seat where sdatetime=sdt and th_id=thid and screen_id=sid;   
    r1 c1%rowtype;  
    type t1 is table of r1%type;  
    l1 t1;  
    p silver_price.price%type;  
begin  
    select price into p from silver_price where sdatetime=sdt and th_id=thid and screen_id=sid;  
    open c1;  
    fetch c1 bulk collect into l1;  
    close c1;  
   dbms_output.put_line('Screen Id: '||sid);  
   dbms_output.put_line('Silver Seats details');  
   dbms_output.put_line('Price: '||p);  
  
for i in 1..l1.count   
    loop  
    dbms_output.put_line('Seat number: '||l1(i).silver_seatnum||' Screen: '||l1(i).screen_id||' Theatre: '||l1(i).th_id||' Status: '||l1(i).avail);  
end loop;  
end;  
/

create procedure p3(thid in gold_seat.th_id%type,sdt in gold_seat.sdatetime%type,sid in gold_seat.screen_id%type)  
is   
    cursor c1 is select * from gold_seat where sdatetime=sdt and th_id=thid and screen_id=sid;   
    r1 c1%rowtype;  
    type t1 is table of r1%type;  
    l1 t1;  
    p gold_price.price%type;  
begin  
    select price into p from gold_price where sdatetime=sdt and th_id=thid and screen_id=sid;  
    open c1;  
    fetch c1 bulk collect into l1;  
    close c1;  
   dbms_output.put_line('Screen Id: '||sid);  
   dbms_output.put_line('Gold Seats details');  
   dbms_output.put_line('Price: '||p);  
  
for i in 1..l1.count   
    loop  
    dbms_output.put_line('Seat number: '||l1(i).gold_seatnum||' Screen: '||l1(i).screen_id||' Theatre: '||l1(i).th_id||' Status: '||l1(i).avail);  
end loop;  
end;  
/

declare   
    m shows.mov_name%type;  
    th shows.th_id%type;  
    sdt1 shows.sdatetime%type;   
    scid shows.screen_id%type;  
begin  
    m:='Tu Jhuthi Main Makkar';  
    th:=100;  
    sdt1:=to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm');  
scid:=f1(th,sdt1,m);  
p2(th,sdt1,scid);  
dbms_output.put_line('-------------');  
p3(th,sdt1,scid);  
end;  
/

insert into silverticket values(1,50,sysdate,'online',to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), 10, 100,'A1',2);

insert into goldticket values(2,50,sysdate,'online',to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), 10, 100,'B1',2);

select silver_seatnum,screen_id,th_id,to_char(sdatetime,'dd-mon-yyyy hh:mi:ss pm') as sdatetime,avail from silver_seat where screen_id=10;

select gold_seatnum,screen_id,th_id,to_char(sdatetime,'dd-mon-yyyy hh:mi:ss pm') as sdatetime,avail from gold_seat where screen_id=10;

select * from silverticket;

select * from goldticket;

insert into shows values('Tu Jhuthi Main Makkar', to_date('21-Apr-2023 9:00:00 am','dd-mon-yyyy hh:mi:ss pm'), '2.5 hrs', 10, 101);

select mov_name,to_char(sdatetime,'dd-mon-yyyy hh:mi:ss pm'),runtime,screen_id,th_id from shows;

select mov_name,to_char(sdatetime,'dd-mon-yyyy hh:mi:ss pm'),runtime,screen_id,th_id from shows;

select mov_name,to_char(sdatetime,'dd-mon-yyyy hh:mi:ss pm'),screen_id,th_id from box_office;

select mov_name,to_char(sdatetime,'dd-mon-yyyy hh:mi:ss pm'),screen_id,th_id from website;

insert into silverticket values(1,50,sysdate,'online',to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), 10, 100,'A1',2);

insert into goldticket values(2,100,sysdate,'online',to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), 10, 100,'B1',2);

insert into silver_seat values('A8', 10, 100, to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B9', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B10', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into gold_seat values('B10', 10, 100,to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'),1);

insert into goldticket values(3,100,sysdate,'online',to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), 10, 100,'B2',3);

insert into silverticket values(3,100,sysdate,'online',to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), 10, 100,'A2',1);

insert into goldticket values(1,100,sysdate,'online',to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm'), 10, 100,'B3',3);

declare   
    m shows.mov_name%type;  
    th shows.th_id%type;  
    sdt1 shows.sdatetime%type;   
    scid shows.screen_id%type;  
begin  
    m:='Tu Jhuthi Main Makkar';  
    th:=100;  
    sdt1:=to_date('20-Apr-2023 12:00:00 pm','dd-mon-yyyy hh:mi:ss pm');  
scid:=f1(th,sdt1,m);  
dbms_output.put_line(scid);  
end;  
/

