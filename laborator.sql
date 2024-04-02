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

-- 6. Se cer codurile departamentelor al căror nume conţine şirul “re” sau în care
--lucrează angajaţi având codul job-ului “SA_REP”.--

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

--8. Să se obțină codurile departamentelor în care nu lucreaza nimeni (nu este introdus
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

create table EMP_teo as select * from employees;
create table DEPT_teo as select * from departments;

desc emp_teo;
desc dept_teo;

select * from emp_teo;
select * from dept_teo;
--se obs ca se copiaza struct tabelelor, datele, tipurile, constrangerile de not null dar nu se copiaza constrangeri de PK, FK, check, unique
--comenzi LDD si LCD

--LDD = limbajul de definire a datelor
--create, alter, drop, truncatee -> executa un commit implicit

--LMD = limbajul de manipulare a datelor
--select, insert, update, delete, merge
--nu executa commit

--LCD = limbajul de control al datelor
--commit, rollback, savepoint

--rollback anuleaza comenzi
--commit salveaza comenzi
