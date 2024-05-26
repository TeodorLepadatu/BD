/*  ------------------------------------------------------Lab1----------------------------
select * from employees;
desc employees;
select job_id, last_name from employees;

select job_id from jobs;
--returneaza 19 joburi (unice)
--job id e cheie primara

select distinct job_id from employees;
--toate joburile sunt ocupate de angajati

select department_id from departments
where department_id is not null;

select last_name || ',' || first_name "Nume si prenume"
from employees;

select last_name, department_id from employees where employee_id = 104;
--var 1 folosind operatori clsici
select last_name, salary 
from employees
where salary < 3000 or salary > 10000;

--var 2 folosind between/not between
select last_name, salary 
from employees
where salary not between 3000 and 10000;
--not between nu afiseaza capetele intervalului
--between afiseaza capetele intervalului

select last_name, salary 
from employees
where salary between 3000 and 10000;

select last_name, job_id, hire_date
from employees
where hire_date between '20-feb-87' and '01-may-89'
order by hire_date;

--descrescator: order by hire_date desc;

--sotare dupa alias:
select last_name, job_id, hire_date "Data"
from employees
where hire_date between '20-feb-87' and '01-may-89'
order by "Data";

select last_name, department_id
from employees
where department_id in (10,30)
order by last_name,department_id;


select last_name "Angajat", department_id, salary "SALARIU LUNAR"
from employees
where department_id in (10,30) and salary>1500
order by last_name;

--sysdate

select sysdate
from employees; --107 randuri afisate
--de ce?? afiseaza un nr de randuri egal cu nr de angajati (e o functie ca un for)

select sysdate
from dual;

desc dual;

select 1+20
from dual;

to_char converteste in char ........

select to_char(sysdate, 'DD/MM/YYYY')
from dual;

select last_name
from employees
where lower(last_name) like ('__a%');

select last_name, department_id
from employees
where upper(last_name) like ('%L%L%') and department_id = 30 or manager_id = 102;

select last_name, job_id, salary
from employees
where (upper(job_id) like '%CLERK%' or 
      upper(job_id) like '%REP') and 
      salary not in (1000,2000,3000);
      
select last_name, job_id, manager_id
from employees
where manager_id is null;   --merge si is not null */

--Lab2--

/*select rtrim('XinfoXxXaabc', 'bacX')
from dual;
select tanh(0.5)
from dual;
select '07-03-2024'+3 from dual; --expr data +/- number, eroare
select to_date('07-03-2024', 'DD-MM-YYYY') + 3 from dual;
select to_char(to_date('07-03-2024','DD-MM-YYYY')+3, 'DD-MM-YYYY') DATA
from dual;
select round(sysdate - to_date('08/08/2004', 'DD/MM/YYYY')) from dual;
select user from dual;

/*NVL(EXPR1, EXPR2) - tipurile de date trebuie sa fie compatbile
                  - sau expr2 sa se converteasca automat la expr1*/
select nvl(1,'a')
from dual; --tipuri de date incompatibile => nu se poate face conversie implicita 

--cum rezolvAM PROBLEMA?
--facem conv explicita
select nvl(to_char(1),'a')
from dual; --avem tipuri compatibile

SELECT concat(CONCAT(first_name, ' '),last_name) || ' castiga ' || salary || ' dar doreste ' || salary*3 "Salariu ideal"
FROM employees; --ex1

--2

--like
select initcap(first_name), upper(last_name), length(last_name) "Lungime nume"
from employees
where lower(last_name) like 'j%' or lower(last_name) like 'm%' or lower(last_name) like '__a%'
order by -3;

--susbstr
select initcap(first_name), upper(last_name), length(last_name) "Lungime nume"
from employees
where substr(lower(last_name),1,1)='j' or lower(last_name) like 'm%' or substr(lower(last_name),3,1)='a'
order by -3;

--4
select employee_id "COD", last_name "NUME", length(last_name) "LUNGIME",
instr(upper(last_name),'A') "POS"
from employees
where upper(last_name) like ('%A%') and upper(last_name) like ('%E%');

select employee_id "COD", last_name "NUME", length(last_name) "LUNGIME",
instr(upper(last_name),'A') "POS"
from employees
where substr(lower(last_name),-1)='a';

--5
select *
from employees
where mod(round(sysdate - hire_date),7)=0;

--6
SELECT employee_id, last_name, salary,
round(salary + 0.15 * salary, 2) "Salariu Nou",
round((salary + 0.15 * salary) / 100, 2) "Numar sute"
FROM employees
WHERE mod(salary, 1000)!=0;

--7
SELECT last_name AS "Nume angajat" , RPAD(to_char(hire_date),20,'X') "Data
angajarii"
FROM employees
WHERE commission_pct is not null;

--8
SELECT to_char (syadate+10 , 'MONTH DD YYYY HH24:MI:SS') "Data"
FROM DUAL;

--10a
select(to_char(sysdate +12/24, 'DD/MM HH24:MI:SS')) "Data"
from dual;
--b
5/60/24
1/288 */

--Lab 4--
NVL(expr1, expr2) - daca expr 1 e nul, returneaza expr2
tipurile cele doua expr trebuie sa fie compatibile
sau expr2 sa se converteasca automat la expr1
--13
select last_name, NVL(to_char(comission_pct), 'Fara comision') "COMISION"
from employees;
--SOLUTIA? facem conversie explicitia

--sau

select last_name, DECODE(comission_pct, NULL, 'Fara comision', comission_pct) "COMISION"
from employees;

select last_name,
    case when comission_pct is null then 'Fara comision'
    else to_char(comission_pct) 
    end "COMISION"
from employees;

--14

--orice operatie cu null da null
select last_name, salary, commission_pct
from employees
where (salary + to_number(commission_pct)*salary) > 10000
    or salary>10000;
    
--altfel
select last_name, salary, commission_pct
from employees
where (salary + NVL(commission_pct,0)*salary) > 10000;

--JOIN
--join scris in where
select employee_id, department_name
from employees e, departments d      --prod cartezian
where e.department_id = d.department_id;
--106 angajati
--inner join - returneaza randurile pt care conditia de join este indeplinita
--avem un angajat fara departament - nu il afiseaza

--utilizand on:
select employee_id, department_name
from employees e join departments d on (e.department_id = d.department_id);

--utilizand using
select employee_id, department_name
from employees join departments using (department_id); -->106 angajati din totalul de 107, deoarece un angajat nu are departament (adica are null pe coloana department_id din employees)
--cum ii afisam si pe acestia?
--dorim sa afisam si angajati care nu au departament
--utilizam simbolul (+) in partea deficitara de informatie

--afisam si angajatii fara departament
select employee_id, department_name
from employees e, departments d
where e.department_id = d.department_id (+);

--afisam angajatii care au departament, dar si departamentele fara angajati
select employee_id, department_name
from employees e, departments d
where e.department_id (+) = d.department_id;

--17
select j.job_id, job_title, department_id
from jobs j, employees e
where department_id=30
    and (j.job_id = e.job_id);

--18
select last_name, department_name, d.location_id
from employees e, departments d, locations l
where e.department_id=d.department_id and d.location_id = l.location_id and commission_pct is not null;


----------------------------------------------------------LABORATOR 3---------------------------------------------------------------------

--de vazut ce e la laboratorul la care am lipsit

--FULL OUTER JOIN--

--afisam angajati care lucreaza in departamente
--plus departamente care nu au angajati
--plus angajatii care nu au departamente
select employee_id, last_name, department_id, department_name
from employees e full join departments d on (e.department_id=d.department_id);
--sau
--union
select employee_id, last_name, d.department_id, department_name
from employees e right join departments d on (e.department_id=d.department_id)
union --afiseaza elem comune si necomune o sg data

select employee_id, last_name, d.department_id, department_name
from employees e left join departments d on (e.department_id=d.department_id);
--daca nu pun id, imi afiseaza mai putin ca am angajati cu acelasi nume

--discutie op pe multimi
desc employees;
desc departments;

select last_name
from employees
union all
select department_name
from departments;

--exemplu de ceva?
select employee_id, last_name
from employees
union
select department_id, department_name
from departments;

-- 6. Se cer codurile departamentelor al c?ror nume con?ine ?irul “re” sau în care
--lucreaz? angaja?i având codul job-ului “SA_REP”.--

select department_id
from departments
where lower(department_name) like '%re%'
union
select department_id
from employees
where job_id='SA_REP';

--var 2
select department_id
from employees e join departments d on (e.department_id = d.department_id)
where lower(department_name) like '%re%' or upper(job_id)='SA_REP';

--8. S? se ob?in? codurile departamentelor în care nu lucreaza nimeni (nu este introdus
--nici un salariat în tabelul employees). Se cer doua solutii.

select department_id
from departments
minus
select department_id
from employees;

--v2
select department_id
from employees right join departments using (department_id)
where department_id is null;

--------------------------------------------------------------LABORATOR 4-----------------------------------------------------------------------

create table EMP_TLE as select * from employees;
create table DEPT_TLE as select * from departments;

desc EMP_TLE;
desc EMP_TLE;

select * from emp_TLE;
select * from dept_TLE;
--se obs ca se copiaza struct tabelelor, datele, tipurile, constrangerile de not null dar nu se copiaza constrangeri de PK, FK, check, unique
--comenzi LDD si LCD

--LDD = limbajul de definire a datelor
--create, alter, drop, truncatee -> executa un commit implicit

--LMD = limbajul de manipulare a datelor
--select, insert, update, delete, merge
--nu executa commit

--LCD = limbajul de control al datelor
--commit, rollback, savepoint

--rollback anuleaza comenzi de la ultima autentificare sau de la ultimul commit
--commit salveaza comenzi 
alter table emp_tle 
add constraint pk_emp_tle primary key(employee_id);

alter table dept_tle 
add constraint pk_dept_tle primary key(department_id);

alter table emp_tle
add constraint fk_emp_dept_tle foreign key(department_id)
references dept_tle;

alter table emp_tle
add constraint fk_emp_emp_tle foreign key(manager_id)
references emp_tle(employee_id); --nu e ok ceva

alter table dept_tle
add constraint fk_dept_emp_tle foreign key(manager_id)
references emp_tle(employee_id);

desc dept_tle;
--insert implicit (nu sunt specificate coloanele)
insert into dept_tle
values (300,'Programare');

insert into dept_tle (department_id, department_name) --insert explicit, restul de coloane sunt null
values (300,'Programare');

insert into dept_tle (department_id, department_name, location_id)
values (300,'Programare', null); --se incalca constrangerea de unicitate a PK

insert into dept_tle (department_id, department_name, location_id)
values (301,'Programare', null); --merge

insert into dept_pnu (department_name, location_id)
values ('Programare', null); --nu poate pune null la PK

select * from dept_tle;

desc emp_tle;
insert into emp_tle
values (250,null,'nume250','email250',null,sysdate,'IT_PROG',null,null,null,300);

INSERT INTO emp_tle (hire_date, job_id, employee_id, last_name, email, department_id)
VALUES (sysdate, 'sa_man', 278, 'nume_278', 'email_278', 300);

INSERT INTO emp_tle
VALUES (252, NULL, 'nume252', 'email252', NULL, SYSDATE, 
       'IT_PROG', NULL, NULL, NULL, 310); --nu exista departamentul 310/nu exista PK 310 in tebelul dept
       
INSERT INTO emp_tle
VALUES (251, NULL, 'nume251', 'email251', NULL, to_date('03-10-2023', 'dd-mm-yyyy'), 
       'IT_PROG', NULL, NULL, NULL, 300);
       
commit;
rollback;
select *from emp_tle;

INSERT INTO emp_tle (hire_date, job_id, employee_id, last_name, email, department_id)
VALUES (sysdate, 'sa_man', 278, 'nume_278', 'email_278', 300);

INSERT INTO emp_tle (employee_id, first_name, last_name, email, hire_date, job_id, salary)
VALUES(&cod, '&&prenume', '&&nume', substr('&prenume',1,1) || substr('&nume',1,7), 
       sysdate, 'it_prog', &sal);
       
creaTE TABLE emp0_tle AS SELECT * FROM employees;

DELETE FROM emp0_tle;

SELECT * FROM emp1_tle; 

CREATE TABLE emp2_tle AS SELECT * FROM employees;

DELETE FROM emp2_tle;

CREATE TABLE emp3_tle AS SELECT * FROM employees;

DELETE FROM emp3_tle;

INSERT ALL
   WHEN salary < 5000 THEN
      INTO emp1_tle					
   WHEN salary > = 5000 AND salary <= 10000 THEN
      INTO emp2_tle
   ELSE 
      INTO emp3_tle
SELECT * FROM employees;  

inserT FIRST
    WHEN department_id = 80 THEN
        INTO emp0_tle
    WHEN salary < 5000 THEN
        INTO emp1_tle
    WHEN salary > = 5000 AND salary <= 10000 THEN
        INTO emp2_tle
    ELSE 
        INTO emp3_tle
SELECT * FROM employees;

updaTE emp_pnu
SET salary = salary * 1.05;

SELECT * FROM emp_tle;

ROLLBACK;

--14
update dept_tle
set manager_id = (select employee_id
from emp_tle
where lower(last_name || first_name) = 'grantdouglas')
where department_id=20;

update emp_tle
set salary = salary + 1000
where lower(last_name || first_name) = 'grantdouglas';

update emp_tle
set department_id = (select department_id
                    from dept_tle
                    where manager_id=(
                            select employee_id
                            from emp_tle
                            where lower(last_name||first_name) = 'grantdouglas'))
where lower(last_name||first_name) = 'grantdouglas';

--15
delete from dept_tle; --child record found (pk in dept e fk in emp => nu putem sterge)

--16 
select department_id
from employees e right join departments d on (e.department_id = d.department_id)
where employee_id is null;

delete from dept_tle
where department_id in (
    select d.department_id
    from employees e right join departments d on (e.department_id=d.department_id)
    where employee_id is null
);
select * from employees;
select * from jobs;
select * from departments;

---------------------------------------------LABORATOR 5--------------------------------------------


-- LABORATOR 5 - SAPTAMANA 8

-- Limbajul de definire a datelor (LDD) 

--COMENZI CARE FAC PARTE DIN LDD:

CREATE, ALTER, DROP, TRUNCATE, RENAME

--Ce comanda LCD se executa dupa instructiunile de tip LDD?

_____

-- Crearea tabelelor (vezi notiunile in laborator 5)


-- EXERCITII 


1. S? se creeze tabelul ANGAJATI_pnu 
(pnu se alcatuie?te din prima liter? din prenume ?i primele dou? din numele studentului) 
corespunz?tor schemei rela?ionale:

ANGAJATI_pnu(cod_ang number(4), nume varchar2(20), prenume varchar2(20), email char(15), 
             data_ang date, job varchar2(10), cod_sef number(4), salariu number(8, 2), 
             cod_dep number(2)
            );
  
a) cu precizarea cheilor primare la nivel de coloan? 
si a constrangerilor NOT NULL pentru coloanele nume ?i salariu;          

CREATE TABLE angajati_tle
      ( cod_ang number(4) constraint pkey_ang primary key,
        nume varchar2(20)constraint nume_ang not null,
        prenume varchar2(20),
        email char(15) unique,
        data_ang date default sysdate,
        job varchar2(10),
        cod_sef number(4),
        salariu number(8,2) constraint sal_not_null not null,
        cod_dep number(2)
       );
 
SELECT * FROM angajati_tle;
DESC angajati_tle;


b) cu precizarea cheii primare la nivel de tabel 
si a constrângerilor NOT NULL pentru coloanele nume ?i salariu.

DROP TABLE angajati_tle;

CREATE TABLE angajati_tle
      ( cod_ang number(4),
        nume varchar2(20) constraint nume_ang not null,
        prenume varchar2(20),
        email char(15)unique,
        data_ang date default sysdate,
        job varchar2(10),
        cod_sef number(4),
        salariu number(8, 2) constraint salariu_ang not null,
        cod_dep number(2),
        constraint pkey_ang primary key(cod_ang) --constrangere la nivel de tabel
       );
 



-- Rezolvati urmatoarele exercitii:


2. Ad?uga?i urm?toarele înregistr?ri în tabelul ANGAJATI_pnu:

-- Analizati tabelul din Laborator 5

-- 1
-- metoda explicita (se precizeaza coloanele)
INSERT INTO angajati_tle(cod_ang, nume, prenume, data_ang, job, salariu, cod_dep)
VALUES(100, 'nume1', 'prenume1', null, 'Director', 20000, 10);

SELECT * FROM angajati_tle;

DE CE A FOST PRECIZATA COLOANA data_ang si nu a fost precizata coloana cod_sef?
R: pt ca vrem sa inseram null si nu valoarea implicita


-- 2           
-- metoda implicita de inserare (nu se precizeaza coloanele)
INSERT INTO angajati_tle
VALUES(101, 'nume2', 'prenume2', 'nume2', to_date('02-02-2004','dd-mm-yyyy'), 
       'Inginer', 100, 10000, 10);
   
-- 3          
INSERT INTO angajati_tle
VALUES(102, 'nume3', 'prenume3', 'nume3', to_date('05-06-2000','dd-mm-yyyy'), 
       'Analist', 101, 5000, 20);

-- 4             
INSERT INTO angajati_tle(cod_ang, nume, prenume, data_ang, job, cod_sef, salariu, cod_dep)
VALUES(103, 'nume4', 'prenume4', null, 'Inginer', 100, 9000, 20);

-- 5       
INSERT INTO angajati_tle
VALUES(104, 'nume5', 'prenume5', 'nume5', null, 'Analist', 101, 3000, 30);

-- salvam inregistrarile
COMMIT;

SELECT * FROM angajati_tle;


2. Modificarea (structurii) tabelelor (vezi notiunile din laborator - pagina 3)

-- EXERCITII

3. Introduceti coloana comision in tabelul ANGAJATI. 
Coloana va avea tipul de date NUMBER(4,2).

DESC angajati_pnu;

ALTER TABLE angajati_tle
ADD comision number(4,2);

SELECT * FROM angajati_tle;


4. Este posibil? modificarea tipului coloanei salariu în NUMBER(6,2) – 6 cifre si 2 zecimale?

SELECT * FROM angajati_pnu;
DESC angajati_pnu;

ALTER TABLE angajati_tle
MODIFY (salariu number(6,2));


5. Seta?i o valoare DEFAULT pentru coloana salariu.

SELECT * FROM angajati_pnu;
DESC angajati_pnu;

ALTER TABLE angajati_tle
MODIFY (salariu number(8,2) default 100); 
                 -- atentie la tipul de date si dimensiunea coloanei


6. Modifica?i tipul coloanei comision în NUMBER(2, 2) 
?i al coloanei salariu la NUMBER(10,2), în cadrul aceleia?i instruc?iuni.

DESC angajati_pnu;

SELECT * FROM angajati_pnu;

ALTER TABLE angajati_tle
MODIFY (comision number(2,2),
        salariu number(10,2)
        );

De ce au fost permise cele doua modificari de mai sus?

R: 



7. Actualizati valoarea coloanei comision, setând-o la valoarea 0.1 
pentru salaria?ii al c?ror job începe cu litera A. (UPDATE)

UPDATE angajati_tle
SET comision = 0.1
WHERE upper(job) LIKE 'A%';


SELECT * FROM angajati_pnu;

Comanda anterioara executa commit implicit?
R: nu ca updateul e lmd


8. Modifica?i tipul de date al coloanei email în VARCHAR2.

DESC angajati_tle;

ALTER TABLE angajati_tle
MODIFY (email varchar2(15)); -- cititi observatiile din Laborator 5 - pagina 3


9. Ad?uga?i coloana nr_telefon în tabelul ANGAJATI_pnu, setându-i o valoare implicit?.

ALTER TABLE angajati_tle
ADD (nr_telefon varchar2(15) default '07namcartela');

SELECT * FROM angajati_tle;


10. Vizualiza?i înregistr?rile existente. Suprima?i coloana nr_telefon.

SELECT * FROM angajati_pnu;

ALTER TABLE angajati_tle
DROP column nr_telefon;

ROLLBACK; -- ce efect are rollback?

R: ____


11. Crea?i ?i tabelul DEPARTAMENTE_pnu, corespunz?tor schemei rela?ionale:

DEPARTAMENTE_pnu (cod_dep# number(2), nume varchar2(15), cod_director number(4))

specificând doar constrângerea NOT NULL pentru nume 
(nu preciza?i deocamdat? constrângerea de cheie primar?);

CREATE TABLE departamente_tle
    (cod_dep number(2),
     nume varchar2(15) constraint nume_dep not null,
     cod_director number(4)
    );
    
DESC departamente_tle;

SELECT * FROM departamente_tle;


12. Introduce?i urm?toarele înregistr?ri în tabelul DEPARTAMENTE

INSERT INTO departamente_tle
VALUES (10, 'Administrativ', 100);

INSERT INTO departamente_tle
VALUES (20, 'Proiectare', 101);

INSERT INTO departamente_tle
VALUES (30, 'Programare', null);

delete from departamente_tle;

rollback;
commit;
13. Se va preciza apoi cheia primara cod_dep, f?r? suprimarea ?i recrearea tabelului 
(comanda ALTER);

ALTER TABLE departamente_tle
ADD CONSTRAINT pkey_dep PRIMARY KEY(cod_dep);

DESC departamente_tle;

-- In acest punct mai este nevoie de comanda commit 
-- pentru salvarea celor 3 inserari anterioare?

R: ______


SELECT * FROM departamente_pnu;
SELECT * FROM angajati_pnu;

DESC departamente_pnu;
DESC angajati_pnu;

14. S? se precizeze constrângerea de cheie extern? pentru coloana cod_dep din ANGAJATI_pnu:

a) f?r? suprimarea tabelului (ALTER TABLE);

ALTER TABLE angajati_tle
ADD CONSTRAINT fkey_ang_dep foreign key(cod_dep) REFERENCES departamente_tle(cod_dep);


b) prin suprimarea ?i recrearea tabelului, cu precizarea noii constrângeri la nivel de coloan? 
({DROP, CREATE} TABLE). 

De asemenea, se vor mai preciza constrângerile (la nivel de coloan?, dac? este posibil):
- PRIMARY KEY pentru cod_ang;
- FOREIGN KEY pentru cod_sef;
- UNIQUE pentru combina?ia nume + prenume;
- UNIQUE pentru email;
- NOT NULL pentru nume;
- verificarea cod_dep >0;
- verificarea ca salariul sa fie mai mare decat comisionul*100.

DROP TABLE angajati_tle;

CREATE TABLE angajati_tle
    (cod_ang number(4) constraint pkey_ang primary key,
     nume varchar2(20) constraint nume_ang not null,
     prenume varchar2(20),
     email char(15) constraint email_unic unique,
     data_ang date default sysdate,
     job varchar2(10),
     cod_sef number(4) constraint sef_ang references angajati_pnu(cod_ang), -- cheie externa
     salariu number(8, 2) constraint salariu_ang not null,
     cod_dep number(2) constraint fk_ang_dept references departmente_tle(cod_dep), --cheie externa
     comision number(2,2),
     constraint cod_dep_poz check (cod_dep > 0),
     constraint nume_pren_unice unique (nume,prenume),
     constraint verif_sal check(salariu>100*comision)
     );
     

15. Suprima?i ?i recrea?i tabelul, specificând toate constrângerile la nivel de tabel (în m?sura în care este posibil).


CREATE TABLE ANGAJATI_tle
    (cod_ang number(4),
    nume varchar2(20) constraint nume_tle not null,
    prenume varchar2(20),
    email char(15),
    data_ang date default sysdate,
    job varchar2(10),
    cod_sef number(4),
    salariu number(8, 2) constraint salariu_tle not null,
    cod_dep number(2),
    comision number(2,2),
    constraint nume_prenume_unique_tle unique(nume,prenume),
    constraint verifica_sal_tle check(salariu > 100*comision),
    constraint pk_angajati_tle primary key(cod_ang),
    constraint email_unic unique(email),
    constraint sef_tle foreign key(cod_sef) references angajati_tle(cod_ang),
    constraint fk_dep_tle foreign key(cod_dep) references departamente_tle (cod_dep),
    constraint cod_dep_poz check(cod_dep > 0)
    );


16. Reintroduce?i date în tabel, utilizând (?i modificând, dac? este necesar) comenzile salvate anterior.

INSERT INTO angajati_pnu
VALUES(100, 'nume1', 'prenume1', 'email1', sysdate, 'Director', null, 20000, 10, 0.1);

INSERT INTO angajati_pnu
VALUES(101, 'nume2', 'prenume2', 'email2', to_date('02-02-2004','dd-mm-yyyy'), 'Inginer', 100, 10000, 10, 0.2);

INSERT INTO angajati_pnu
VALUES(102, 'nume3', 'prenume3', 'email3', to_date('05-06-2000','dd-mm-yyyy'), 'Analist', 101, 5000, 20, 0.1);

INSERT INTO angajati_pnu
VALUES(103, 'nume4', 'prenume4', 'email4', sysdate, 'Inginer', 100, 9000, 20, 0.1);

INSERT INTO angajati_pnu
VALUES(104, 'nume5', 'prenume5', 'email5', sysdate, 'Analist', 101, 3000, 30, 0.1);


-- Ce comanda trebuie executata?

R: _____


19. Introduce?i constrângerea NOT NULL asupra coloanei email.

desc angajati_pnu;

ALTER TABLE angajati_pnu
MODIFY(email not null);


20. (Incerca?i s?) ad?uga?i o nou? înregistrare în tabelul ANGAJATI_pnu, 
care s? corespund? codului de departament 50. Se poate?

INSERT INTO angajati_pnu
VALUES(105, 'nume6', 'prenume6', 'email6', sysdate, 'Analist', 101, 3000, 50, 0.1);
--nu exista departamentul 50
De ce nu se poate insera?

R: ____

SELECT * FROM angajati_pnu;


21. Ad?uga?i un nou departament, cu numele Analiza, codul 60 ?i 
directorul null în DEPARTAMENTE_pnu. Salvati inregistrarea. 

INSERT INTO departamente_pnu
VALUES (60, 'Analiza', null);

SELECT * FROM departamente_pnu;

COMMIT;


22. (Incerca?i s?) ?terge?i departamentul 20 din tabelul DEPARTAMENTE. Comenta?i.

DELETE FROM departamente_pnu
WHERE cod_dep = 20;

-- De ce nu se poate sterge?

R: --exista angajati care lucreaza in departamentul 20



23. ?terge?i departamentul 60 din DEPARTAMENTE. ROLLBACK;

DELETE FROM departamente_pnu
WHERE cod_dep = 60;  

-- De ce putem sterge departamentul 60?
R: --nu exista angajati care lucreaza in departamentul 60

SELECT * FROM departamente;

ROLLBACK;


24. Se dore?te ?tergerea automat? a angaja?ilor dintr-un departament, odat? cu 
suprimarea departamentului. Pentru aceasta, este necesar? introducerea clauzei 
ON DELETE CASCADE în definirea constrângerii de cheie extern?. 

Suprima?i constrângerea de cheie extern? asupra tabelului ANGAJATI_pnu 
?i reintroduce?i aceast? constrângere, specificând clauza ON DELETE CASCADE.

SELECT * 
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'ANGAJATI_PNU'; -- dorim sa aflam numele constrangerii


-- stergem constrangerea 
ALTER TABLE angajati_pnu
DROP CONSTRAINT FK_DEP_PNU;

--adaugam constrangerea utilizand clauza ON DELETE CASCADE
ALTER TABLE angajati_pnu
ADD CONSTRAINT FK_DEP_PNU FOREIGN KEY(cod_dep)
REFERENCES departamente_pnu(cod_dep) ON DELETE CASCADE;


25. ?terge?i departamentul 20 din DEPARTAMENTE. Ce se întâmpl?? Rollback;

-- Inainte de stergere analizati datele, atat din angajati, cat si din departamente

SELECT * FROM angajati_pnu; 

-- Cati angajati lucreaza in departamentul 20?

R: _____

-- Ce este cod_dep in angajati_pnu?

R: --cheie primara

SELECT * FROM departamente_pnu;

-- Ce este cod_dep in departamente_pnu?

R: ____


-- Stergeti departamentul din departamente_pnu si analizati din nou datele din BD

DELETE FROM departamente_pnu
WHERE cod_dep = 20; 

SELECT * FROM departamente_pnu;

SELECT * FROM angajati_pnu; 

-- Ce se intampla daca executam ROLLBACK?

R: ____

ROLLBACK;


26. Introduce?i constrângerea de cheie extern? asupra coloanei cod_director 
a tabelului DEPARTAMENTE. 
Se dore?te ca ?tergerea unui angajat care este director de departament s? atrag? dup? sine 
setarea automat? a valorii coloanei cod_director la null.

DESC departamente_pnu;

____ 

27. Actualiza?i tabelul DEPARTAMENTE, astfel încât angajatul având codul 102 
s? devin? directorul departamentului 30. 
?terge?i angajatul având codul 102 din tabelul ANGAJATI_pnu. 
Analiza?i efectele comenzii. Rollback;

UPDATE departamente_PNU
SET cod_director = 102
WHERE cod_dep = 30;

SELECT * FROM departamente_pnu;

SELECT * FROM angajati_pnu;

DELETE FROM angajati_pnu
WHERE cod_ang = 102; 
      -- avand constrangerea on delete set null pe cheia externa cod_director din departamente
      -- observam ca stergerea angajatului 102 din angajati, 
      -- care era sef de departament in tabelul departamente
      -- a dus la setarea valorii cod_director din tabelul departamente la null

-- Cititi notiunile din Laborator 5 - paginile 4 si 5
-- Studiati exercitiile rezolvate in laborator - exercitiile 28 si 29
Displaying Template_Laborator5.txt.


-- SAPTAMANA 9 - LABORATOR 6 - Subcereri Necorelate


1.	Folosind subcereri, s? se afi?eze numele ?i data angaj?rii pentru salaria?ii 
care au fost angaja?i dup? Gates.

SELECT last_name, hire_date
FROM employees
WHERE hire_date > (SELECT hire_date
                   FROM employees
                   WHERE INITCAP(last_name)= 'Gates'
                   );


2.	Folosind subcereri, scrie?i o cerere pentru a afi?a numele ?i salariul 
pentru to?i colegii (din acela?i departament) lui Gates. Se va exclude Gates. 


R: ___
select last_name, salary
from employees
where department_id = (select department_id
                       from employees
                       where initcap(last_name) = 'Gates'
                       )
and initcap(last_name)!='Gates'



--Se va inlocui Gates cu King;





3.	Folosind subcereri, s? se afi?eze numele ?i salariul angaja?ilor condu?i direct 
de pre?edintele companiei (acesta este considerat angajatul care nu are manager).

-- REZOLVATI INDIVIDUAL

-- CEREREA TREBUIE SA RETURNEZE 14 ANGAJATI
-- VEZI IMAGINEA ATASATA IN LABORATOR

SELECT last_name, salary
FROM employees
WHERE manager_id = (
    SELECT employee_id
    FROM employees
    WHERE manager_id IS NULL
);

4.	Scrie?i o cerere pentru a afi?a numele, codul departamentului ?i salariul angaja?ilor 
al c?ror cod de departament ?i salariu coincid cu codul departamentului ?i salariul 
unui angajat care câ?tig? comision. 

SELECT last_name, department_id, salary
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, salary
                                  FROM employees
                                  WHERE commission_pct is not null
                                  );
           

                                                                       
5.	S? se afi?eze codul, numele ?i salariul tuturor angaja?ilor al c?ror salariu 
este mai mare decât salariul mediu din companie.

SELECT employee_id, last_name, salary 
FROM employees 
WHERE salary > (SELECT AVG(salary) 
                FROM employees);




6.	Scrieti o cerere pentru a afi?a angaja?ii care câ?tig? 
(castiga = salariul plus comision din salariu) 
mai mult decât oricare func?ionar (job-ul functionarilor  con?ine ?irul "CLERK"). 
Sorta?i rezultatele dupa salariu, în ordine descresc?toare;

select employee_id, salary, commission_pct, job_id
from employees
where (salary + salary * commission_pct)>any
        (select salary+salary*(NVL(commission_pct,0))
        from employees
        where upper(job_id)like '%CLERK%')
order by salary desc;


7.	Scrie?i o cerere pentru a afi?a numele angajatilor, numele departamentului 
?i salariul angaja?ilor care câ?tig? comision, dar al c?ror ?ef direct nu câ?tig? comision.	

-- REZOLVATI IN ECHIPA DE 2 PERSOANE

-- CEREREA TREBUIE SA RETURNEZE 5 ANGAJATI
-- VEZI IMAGINEA ATASATA IN LABORATOR

SELECT e.last_name AS employee_name, d.department_name, salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.commission_pct IS NOT NULL 
AND e.employee_id IN (
    SELECT e1.employee_id
    FROM employees e1
    WHERE e1.commission_pct IS NOT NULL
    AND e1.manager_id NOT IN (
        SELECT e2.employee_id
        FROM employees e2
        WHERE e2.commission_pct IS NOT NULL
    )
);

8.	S? se afi?eze numele angaja?ilor, codul departamentului ?i codul job-ului salaria?ilor 
al c?ror departament se afl? în Toronto. Sa se rezolve atat cu subcerere, cat si fara subcerere.

-- REZOLVATI IN ECHIPA DE 2 PERSOANE

-- CEREREA TREBUIE SA RETURNEZE 2 ANGAJATI
-- VEZI IMAGINEA ATASATA IN LABORATOR

-- CU SUBCERERE
select last_name, department_id, job_id
from employees
where department_id = (select department_id
                        from departments where location_id in)

-- FARA SUBCERERE

select * from  locations

SELECT e.last_name, e.department_id, e.job_id
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE d.locations_id

9.	S? se ob?in? codurile departamentelor în care nu lucreaza nimeni 
(nu este introdus nici un salariat în tabelul employees). Sa se utilizeze subcereri;

select d.department_id 
from departments d
where not exists(select department_id from employees where department_id=d.department_id);

10.	Este posibil? introducerea de înregistr?ri prin intermediul subcererilor (specificate în locul tabelului). 
Ce reprezint?, de fapt, aceste subcereri? S? se analizeze urm?toarele comenzi INSERT:

INSERT INTO emp (employee_id, last_name, email, hire_date, job_id, salary, commission_pct) 
VALUES (252, 'Nume252', 'nume252@emp.com', SYSDATE, 'SA_REP', 5000, NULL);

SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct 
FROM emp
WHERE employee_id = 252;

ROLLBACK;

INSERT INTO 
   (SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct 
    FROM emp) 
VALUES (252, 'Nume252', 'nume252@emp.com', SYSDATE, 'SA_REP', 5000, NULL);


SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct 
FROM emp
WHERE employee_id = 252;

ROLLBACK;


11. Sa se creeze tabelul SUBALTERNI care sa contina codul, numele si prenumele angajatilor 
care il au manager pe Steven King, alaturi de codul si numele lui King.
Coloanele se vor numi cod, nume, prenume, cod_manager, nume_manager.

DESC employees;

CREATE TABLE SUBALTERNI
    (
    );
     

INSERT INTO SUBALTERNI (cod, nume, prenume, cod_manager, nume_manager)
        (SELECT 
        
        );
Displaying Template_Laborator6.txt.


-- LABORATOR 7 

--exemplu grupare

create table grupare (id number(5) primary key,
                      nume varchar2(10) not null,
                      salariu number(10) not null,
                      manager_id number(5) not null
                      );
                      
select * from grupare;

insert into grupare values (1, 'user1', 1000, 1);

insert into grupare values (2, 'user2', 1400, 1);

insert into grupare values (3, 'user3', 700, 2);

insert into grupare values (4, 'user4', 300, 2);

insert into grupare values (5, 'user5', 1600, 2);

insert into grupare values (6, 'user6', 1200, 2);

commit;

--exemplu folosind clauza where
select *
from grupare
where salariu < 1100;

--exemplu folosind where si grupare
select manager_id, salariu
from grupare
where salariu < 1100
group by manager_id, salariu;

--exemplu folosind where, iar gruparea realizata doar dupa coloana manager_id
select manager_id
from grupare
where salariu < 1100
group by manager_id;

--exemplu folosind having
select max(salariu)
from grupare
having max(salariu) < 10000;

--group by si having
select manager_id, min(salariu)
from grupare
group by manager_id
having min(salariu) <= 1000;


1. 
a) Functiile grup includ valorile NULL in calcule?
b) Care este deosebirea dintre clauzele WHERE ?i HAVING? 


2.	S? se afi?eze cel mai mare salariu, cel mai mic salariu, suma ?i media salariilor tuturor angaja?ilor. 
Eticheta?i coloanele Maxim, Minim, Suma, respectiv Media. 
Sa se rotunjeasca media salariilor. 

SELECT MAX(salary) "Maxim", min(salary), "Minim", sum(salary), "Suma", round(avg(salary),2)) "Media"
FROM employees;


3.	S? se modifice problema 2 pentru a se afi?a minimul, maximul, suma ?i media salariilor pentru FIECARE job. 

SELECT job_id, MAX(salary) Maxim, ______, ________, _________
FROM employees
______;


4.	S? se afi?eze num?rul de angaja?i pentru FIECARE  departament.

SELECT COUNT(...), department_id
FROM   ____
GROUP BY ____;


5.	S? se determine num?rul de angaja?i care sunt ?efi. 
Etichetati coloana “Nr. manageri”.


_____


6.	S? se afi?eze diferen?a dintre cel mai mare si cel mai mic salariu. 
Etichetati coloana “Diferenta”.

SELECT max(salary)-min(salary) Diferenta
FROM employees;


7.	Scrie?i o cerere pentru a se afi?a numele departamentului, loca?ia, num?rul de angaja?i 
?i salariul mediu pentru angaja?ii din acel departament. 
Coloanele vor fi etichetate corespunz?tor.
Se vor afisa si angajatii care nu au departament

!!!Obs: În clauza GROUP BY se trec obligatoriu toate coloanele prezente în clauza SELECT, 
cu exceptia functiilor de agregare

SELECT department_name, location_id, ____, ____
FROM ____;



8.	S? se afi?eze codul ?i numele angaja?ilor care au salariul mai mare decât salariul mediu din firm?.
Se va sorta rezultatul în ordine descresc?toare a salariilor.

SELECT employee_id, first_name, last_name
FROM employees 
WHERE salary > (SELECT AVG(salary)
                FROM employees
                )
ORDER BY salary DESC;  



9.	Pentru fiecare ?ef, s? se afi?eze codul s?u ?i salariul celui mai prost platit subordonat. 
Se vor exclude cei pentru care codul managerului nu este cunoscut. 
De asemenea, se vor exclude grupurile în care salariul minim este mai mic de 1000$. 
Sorta?i rezultatul în ordine descresc?toare a salariilor.


________




10.	Pentru departamentele in care salariul maxim dep??e?te 3000$, s? se ob?in? codul, 
numele acestor departamente ?i salariul maxim pe departament.

SELECT department_id, department_name, MAX(salary)
FROM departments JOIN employees USING(department_id)
GROUP BY department_id,department_name
HAVING MAX(salary) >= 3000;


11.	Care este salariul mediu minim al job-urilor existente? 
Salariul mediu al unui job va fi considerat drept media aritmetic? a salariilor celor care îl practic?.

SELECT ____
FROM employees ____;



12.	S? se afi?eze maximul salariilor medii pe departamente.

SELECT ____;



13.	Sa se obtina codul, titlul ?i salariul mediu al job-ului pentru care salariul mediu este minim. 

-- Rezolvati
desc jobs
select job_id, job_title, 




14.	S? se afi?eze salariul mediu din firm? doar dac? acesta este mai mare decât 2500.

SELECT AVG(salary)
FROM employees
____;


15.	S? se afi?eze suma salariilor pe departamente ?i, în cadrul acestora, pe job-uri.

SELECT department_id, job_id, SUM(salary)
FROM employees
GROUP BY department_id, job_id; 


16.	Sa se afiseze codul, numele departamentului si numarul de angajati care lucreaza in acel departament pentru:

a)	departamentele in care lucreaza mai putin de 4 angajati;

SELECT e.department_id, d.department_name, COUNT(*)
FROM employees e JOIN departments d ON (d.department_id = e.department_id )
GROUP BY e.department_id, d.department_name
HAVING COUNT(*) < 4; 


b)	departamentul care are numarul maxim de angajati.

--REZOLVATI


-- LABORATOR 7 -- continuare SAPTAMANA 11



18.	S? se ob?in? codul departamentelor ?i suma salariilor angaja?ilor care lucreaz? în acestea, în ordine cresc?toare. 
Se consider? departamentele care au mai mult de 10 angaja?i ?i al c?ror cod este diferit de 30.

-- Cand utilizand where? Cand se foloseste having?

select department_id, sum(salary), count(employee_id)
from employees
where department_id is not null
group by department_id
having count(employee_id) > 10
order by count(employee_id);

19.	Care sunt angajatii care au mai avut cel putin doua joburi?

select employee_id
from job_history
group by employee_id
having count(job_id)>=2;




20.	S? se calculeze comisionul mediu din firm?, luând în considerare toate liniile din tabel.

select round(sum(commission_pct)/count(employee_id), 3)
from employees;

--count(*) numara tot
--count(coloana) numara fara null

21.	Scrie?i o cerere pentru a afi?a job-ul, salariul total pentru job-ul respectiv pe departamente 
si salariul total pentru job-ul respectiv pe departamentele 30, 50, 80. 
Se vor eticheta coloanele corespunz?tor. Rezultatul va ap?rea sub forma de mai jos:

Job	   Dep30   Dep50   Dep80	Total
---------------------------------------

--forma generala;
-- DECODE(value, if1, then1, if2, then2, … , ifN, thenN, else);

-- METODA 1
SELECT job_id, SUM(DECODE(department_id, 30, salary)) Dep30,
               SUM(DECODE(department_id, 50, salary)) Dep50,
               SUM(DECODE(department_id, 80, salary)) Dep80,
               SUM(salary) Total
FROM employees
GROUP BY job_id;

-- METODA 2: (cu subcereri corelate în clauza SELECT)
SELECT job_id, (SELECT SUM(salary)
                FROM employees
                WHERE department_id = 30
                AND job_id = e.job_id
               ) Dep30,
               
               (SELECT SUM(salary)
                FROM employees
                WHERE department_id = 50
                AND job_id = e.job_id
               ) Dep50,
                
               (SELECT SUM(salary)
                FROM employees
                WHERE department_id = 80
                AND job_id = e.job_id
               ) Dep80,
               
              SUM(salary) Total
              
FROM employees e
GROUP BY job_id;



23.	S? se afi?eze codul, numele departamentului ?i suma salariilor pe departamente.

-- Varianta fara subcerere
SELECT d.department_id, department_name, sum(salary)
FROM departments d join employees e ON (d.department_id = e.department_id)
GROUP BY d.department_id, department_name
ORDER BY d.department_id;


-- Varianta cu subcerere in from
SELECT d.department_id, department_name, a.suma
FROM departments d, (SELECT department_id ,SUM(salary) suma 
                     FROM employees
                     GROUP BY department_id) a --VIEW IN-LINE (tabel temporar)
WHERE d.department_id = a.department_id; 



24.	S? se afi?eze numele, salariul, codul departamentului si salariul mediu din departamentul respectiv.

-- Varianta fara subcerere -> discutati rezultatul
--gresit
select last_name, salary, department_id, avg(salary)
from employees join departments using(department_id)
group by department_id,salary,last_name;
--corect
SELECT e.last_name, e.salary, e.department_id, b.Sal_mediu
FROM employees e
JOIN (
    SELECT department_id, ROUND(AVG(salary)) AS Sal_mediu
    FROM employees
    GROUP BY department_id
) b
ON e.department_id = b.department_id;


Displaying Template_Laborator7_Partea2.txt.


-- LABORATOR 8 - SAPTAMANA 11

1. 

a) S? se afi?eze informa?ii (numele, salariul si codul departamentului) 
despre angaja?ii al c?ror salariu dep??e?te valoarea medie a salariilor 
tuturor colegilor din companie.

select last_name, salary, department_id
from employees
where salary > (select round(avg(salary)) from employees);


b) S? se afi?eze informa?ii (numele, salariul si codul departamentului) 
despre angaja?ii al c?ror salariu dep??e?te valoarea medie a salariilor 
colegilor s?i de departament.

select last_name, salary, e.department_id
from employees e
where salary > (select round(avg(salary)) from employees where e.department_id = department_id);

c) Analog cu cererea precedent?, afi?ându-se ?i numele departamentului 
?i media salariilor acestuia ?i num?rul de angaja?i.

-- De ce varianta aceasta este gresita?
-- Argumentati

select last_name, salary, e.department_id, department_name, 
       round(avg(salary)), count(employee_id)
from employees e join departments d on (e.department_id = d.department_id)
group by last_name, salary, e.department_id, department_name;  


-- Discutati variantele incluse in laborator





2.	S? se afi?eze numele ?i salariul angaja?ilor al c?ror salariu 
este mai mare decât salariile medii din toate departamentele. 
Se cer 2 variante de rezolvare: cu operatorul ALL sau cu func?ia MAX.

-- Varianta cu ALL
SELECT last_name, salary 
FROM employees 
WHERE salary > all (select round(avg(salary))
                    from employees 
                    group by department_id
                    ); -- subcererea calculeaza salariul mediu pentru fiecare departament


-- Varianta cu functia MAX
SELECT last_name, salary 
FROM employees 
WHERE salary > (select ROUND(max(avg(salary)))
                from employees 
                group by department_id
                );



3.	Sa se afiseze numele si salariul celor mai prost platiti angajati 
din fiecare departament.

-- Solu?ia 1 (cu sincronizare):
SELECT last_name, salary, department_id
FROM employees e
WHERE salary = (select min(salary)
                from employees
                where e.department_id = department_id
                group by department_id);


-- Solu?ia 2 (f?r? sincronizare):
SELECT last_name, salary, department_id  
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, MIN(salary) 
                                  FROM employees 
                                  GROUP BY department_id
                                  );


-- Solu?ia 3: Subcerere în clauza FROM 
               
SELECT last_name, salary, e.department_id  
FROM employees e join (select department_id, min(salary) min_sal
                        from employees
                        group by department_id) a
    on e.department_id=a.department_id 
where e.salary = min_sal;





4.	Sa se obtina numele si salariul salariatilor care lucreaza intr-un departament 
in care exista cel putin 1 angajat cu salariul egal cu 
salariul maxim din departamentul 30.

-- METODA 1 - IN

select last_name, salary, department_id
from employees
where department_id in (select department_id
                        from employees join departments using (department_id)
                        where salary = (select max(salary)
                                        from employees
                                        where department_id = 30));

-- METODA 2 - EXISTS
select last_name, salary, department_id
from employees e
where exists (select 1
                        from employees join departments using(department_id)
                        where e.department_id = department_id
                        and salary = (select max(salary)
                                        from employees
                                        where department_id = 30));

--ciorna tema 2 curs--


-- Create SUBANTREPRENOR table
CREATE TABLE SUBANTREPRENOR (
    cod_contractant INT PRIMARY KEY,
    nume VARCHAR(100)
);

-- Create OBIECTIV_INVESTITIE table
CREATE TABLE OBIECTIV_INVESTITIE (
    cod_ob_inv INT PRIMARY KEY,
    denumire VARCHAR(100)
);

-- Create LUCRARE table with FK to SUBANTREPRENOR
CREATE TABLE LUCRARE (
    cod_lucrare INT,
    cod_ob_inv INT, 
    cod_contractant INT,
    tip VARCHAR(50),
    PRIMARY KEY (cod_lucrare, cod_ob_inv),
    FOREIGN KEY (cod_ob_inv) REFERENCES OBIECTIV_INVESTITIE(cod_ob_inv),
    FOREIGN KEY (cod_contractant) REFERENCES SUBANTREPRENOR(cod_contractant)
);
-- LABORATOR 8 - SAPTAMANA 12


-- DISCUTIE EXERCITIUL 8

-- EX 9

9. S? se afi?eze codul, prenumele, numele ?i data angaj?rii, pentru angajatii condusi de Steven King 
care au cea mai mare vechime dintre subordonatii lui Steven King. 
Rezultatul nu va con?ine angaja?ii din anul 1970. 

--SUBORDONATII LUI KING
with subord as (select employee_id
                from employees
                where manager_id = 
                                    (select employee_id
                                     from employees
                                     where lower(first_name || last_name) = 'stevenking')
                ),
--SUBORDONATII CU CEA MAI MARE VECHIME DINTRE CEI DE SUS
vechime as (select employee_id
            from subord
            where hire_date = (select min(hire_date) from subord)
            )
--CEREREA PRINCIPALA
select employee_id, first_name, last_name, hire_date
from employees
where employee_id in (select employee_id from vechime)
and to_char(hire_date, 'yyyy')!=1970;


10. Sa se obtina numele primilor 10 angajati avand salariul maxim. 
Rezultatul se va afi?a în ordine cresc?toare a salariilor. 

-- Solutia 1: subcerere sincronizat?

-- numaram cate salarii sunt mai mari decat linia la care a ajuns

select last_name, salary
from employees e
where 10 >
     (select count(salary) 
      from employees
      where e.salary < salary
     );




-- Solutia 2: analiza top-n 
-- ESTE CORECTA VARIANTA URMATOARE?
--where se executa inainte de sortare
select employee_id, last_name, salary, rownum
from employees
where rownum <= 10
order by salary desc;
--VARIANTA CORECTA
--DORIM SA SORTAM INAINTE DE CONDITIA DIN WHERE

select employee_id, last_name, salary, rownum
from (select employee_id, salary, last_name
      from employees
      order by salary desc)
where rownum <= 10
order by salary desc;

12.	S? se afi?eze informa?ii despre departamente, în formatul urm?tor: 
"Departamentul <department_name> este condus de {<manager_id> | nimeni} 
?i {are num?rul de salaria?i  <n> | nu are salariati}".

select 'Departamentul ' || department_name || 'este condus de ' || NVL(to_char(manager_id), 'nimeni') || ' si ' || 'are numarul de angajati' ||
case
when (select count(employee_id)
      from employees
      where d.department_id = department_id
      ) = 0
then 'nu are salariati'
else 'are numarul de salariati ' || (select count(employee_id)
                                     from employees
                                     where d.department_id = department_id)
end "Detalii Departament"
from departments d;

17. Sa se afiseze salariatii care au fost angajati în aceea?i zi a lunii 
în care cei mai multi dintre salariati au fost angajati 
(ziua lunii insemnand numarul zilei, indiferent de luna si an).

--DETERMINAM NR DE ANGAJATI PT FIECARE ZI
--indiferent de luna si an
select count(employee_id), to_char(hire_date, 'dd')
from employees
group by to_char(hire_date, 'dd');

select max(count(employee_id))), to_char(hire_date, 'dd')
from employees
group by to_char(hire_date, 'dd');

select max(count(employee_id))
from employees
group by to_char(hire_date, 'dd'); --12

--ziua coresp
select to_char(hire_date, 'dd')
from employees
group by to_char(hire_date, 'dd')
having count(employee_id = (select max(count(employee_id))
                            from employees
                            group by to_char(hire_date, 'dd')));
                            
--cererea principala
select *
from employees
where to_char(hire_date, 'dd') = (select to_char(hire_date, 'dd')
from employees
group by to_char(hire_date, 'dd')
having count(employee_id = (select max(count(employee_id))
                            from employees
                            group by to_char(hire_date, 'dd'))));
                            
    
5.	S? se afi?eze codul, numele ?i prenumele angaja?ilor care au cel pu?in doi subalterni. 

a)

select employee_id, last_name, first_name
from employees mgr
where 1 < (select count(employee_id)
           from employees
           where mgr.employee_id = manager_id
          );

--SAU:
select employee_id, last_name, first_name
from employees e join (select manager_id, count(*) 
                       from employees 
                       group by manager_id
                       having count(*) >= 2
                       ) man
on e.employee_id = man.manager_id;


b) Cati subalterni are fiecare angajat? Se vor afisa codul, numele, prenumele si numarul de subalterni.
Daca un angajat nu are subalterni, o sa se afiseze 0 (zero). 


select employee_id, last_name, first_name, (select count*(employee_id))
___



6.	S? se determine loca?iile în care se afl? cel pu?in un departament.

-- REZOLVATI
-- CEREREA TREBUIE SA AFISEZE 7 LOCATII 
-- VEZI IMAGINEAZA ATASATA IN LABORATOR

-- METODA 1 - IN (care este echivalent cu  = ANY )         


-- METODA 2 - EXISTS



7.	S? se determine departamentele în care nu exist? niciun angajat.

-- REZOLVATI
-- CEREREA TREBUIE SA RETURNEZE 16 DEPARTAMENTE
-- VEZI IMAGINEAZA ATASATA IN LABORATOR

-- METODA 1 - UTILIZAND NOT IN 

SELECT department_id, department_name
FROM departments d
WHERE ___ NOT IN (SELECT ____
                  FROM ____
                  );


-- METODA 2 - UTILIZAND NOT EXISTS

SELECT department_id, department_name
FROM departments d
WHERE ___ (SELECT 
           FROM 
          );




Displaying Template_Laborator8_Partea2.txt.

select * from project;
select * from works_on;
select * from job_history;

-- LABORATOR 9 - SAPTAMANA 12

2.	S? se listeze informa?ii despre proiectele la care au participat to?i angaja?ii 
care au de?inut alte 2 posturi în firm?.

select employee_id
from job_history
group by employee_id
having count(employee_id) = 2;

--proiectele la care au lucrat angajatii care au detinut alte doua posturi in firma in trecut
select project_id
from works_on
where employee__id in (select employee_id
                        from job_history
                        group by employee_id
                        having count(employee_id) = 2
                        )
group by project_id
having count(employee_id = (select employee_id
                        from job_history
                        group by employee_id
                        having count(employee_id) = 2));
3.	S? se ob?in? num?rul de angaja?i care au avut cel pu?in trei job-uri, 
luându-se în considerare ?i job-ul curent.

-- cel putin 3 joburi cu jobul curent inseamna ca in job_history sa aiba cel putin doua 
-- acolo este istoricul joburilor trecute

select e.last_name, 1 + (select count(*) fromm job_history j where j.employee_id = e.employee_id) as cnt from employees e where cnt >=3;




4.	Pentru fiecare ?ar?, s? se afi?eze num?rul de angaja?i din cadrul acesteia.

_____
   


   

5.	S? se listeze codurile angaja?ilor ?i codurile proiectelor pe care au lucrat. 
Listarea va cuprinde ?i angaja?ii care nu au lucrat pe niciun proiect.

______


Displaying Template_Laborator9_Partea1.txt.
