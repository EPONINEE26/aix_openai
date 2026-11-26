--조인
select emp_name, department_id from employees;
select * from employees;

select * from board2;
select * from stuscore;
-- 학년,학반,전화번호,주소,보호자,담당교사,학교이름,성명,키,몸무게,특기 (동일한 컬럼)
-- 학기,국어,영어,수학,합계,평균,등수 (변동할 컬럼)
-- 추가할 컬럼을 만든느 것보다는 리스트를 추가하는 것이 좋음 
-- bno로 primary key를 만들어서 join 함수를 이용해서 추가
-- 관계형 db 

-- 조인의 필요성
-- 1. 중복된 데이터를 방지하게 위해
-- 2. null 값을 피하기 위해 

-- 107* 27 : 총 개수
select * from employees;
select * from employees, departments;
select count(*) from employees;
select count(*) from departments;
-- cross 조인 : 테이블 연결 
select * from employees, departments,jobs;
-- Equi Join:동일 컬럼을 기준으로 조인. 공통적으로 존제하는 컬럼을 일치시켜서 연결
-- 동일한 컬럼이 존재해야 실행 가능
-- Non-Equi Join  
-- Outer Join   
-- Seif Join 
select department_id from employees;
select department_id from departments;

select * from employees, departments
where employees.department_id = departments.department_id;

select employees.department_id, departments.department_id,
departments.department_name from employees, departments
where employees.department_id = departments.department_id;

select emp_name,employees.department_id,departments.department_name,
salary from employees, departments
where employees.department_id = departments.department_id; 

select emp_name,employees.department_id,salary from employees;

select employees.department_id, departments.department_name 
from employees, departments 
where employees.department_id=departments.department_id;

select emp_name, a.department_id, b.department_name 
from employees a, departments b 
where a.department_id = b.department_id;

select job_id from employees;
select * from jobs;

-- equi join / employees, jobs
-- emp_name,salary,job_id,job_title,min_salary,max_salary,department_id
-- hire_date
select * from employees;
select * from jobs;
 
select emp_name,salary,job_id,department_id,hire_date from employees;
select job_id,job_title,min_salary,max_salary from jobs;

select emp_name,salary,a.job_id,department_id,hire_date,
b.job_id,job_title,min_salary,max_salary
from employees a, jobs b 
where a.job_id=b.job_id; 

select * from member;
select * from stuscore;

--drop table board;
--drop table board2;
--drop table member;
--drop table students;
--drop table stuscore;
--drop table stuscore2;

create table board2 as select * from board; 

create table board (
bno number(4) primary key,
id varchar2(100),
btitle varchar2(1000),
bcontent clob,
bgroup number(4),
bstep number(4) default 0,
bindent number(4) default 0,
bhit number(4) default 0,
bdate date default sysdate,
bfile varchar2(100)
);

create table member(
id varchar2(100) primary key,
pw varchar2(100),
name varchar2(100), 
nickname varchar2(100),
tel char(13),
gender varchar2(100), 
hobby varchar2(200),
mdate date default sysdate
);

--drop table board;
--drop table member;

create table students(
no number(4),
name varchar2(100) primary key,
major varchar2(100),
grade number(2),
age number(3),
gender varchar2(100),
hobby varchar2(200),
sdate date default sysdate
);

create table stuscore(
no number(4),
name varchar2(100),
school varchar2(100),
grade varchar2(2),
height number(5),
kor number(4),
eng number(4),
math number(4),
sw varchar2(100)
);

-- 외래키 등록 
-- member의 primary key를 board foreign key로 등록 
select * from member;
select * from board;
alter table board add constraints board_member_fk_id foreign key (id)
references member(id) on delete set null; 

select * from students;
select * from stuscore;
alter table stuscore add constraints stuscore_students_fk_name foreign key(name)
references students(name) on delete cascade;

-- equi join 을 name으로 실행완료
select * from stuscore;
select * from students;

-- 성적출력하는데, 성별과 나이를 같이 출력하시오
select a.no,a.name,gender,age,kor,eng,math from stuscore a, students b
where a.name= b.name;

-- 
select * from board;
select * from member;
-- member의 nickname을 board로 join해 출력하시오
-- primary key와 foreign key로 조인으로 등록을 해야만 하나만 수정해도 다른 곳도 수정 가능
select bno,a.id, nickname, btitle, bcontent
from board a, member b
where a.id=b.id;

select * from students;
update students set grade=3 where name = 'Romonda';
commit;
update students set grade=4 where name = 'Romonda';
commit;
select * from stuscore;

alter table stuscore drop column grade;

select a.name,grade,kor,eng,math
from students a, stuscore b
where a.name=b.name;

select a.name,grade,kor,eng,math
from students a, stuscore b
where a.name=b.name and kor>=90 and eng>=80;

-- lower(a.name) : 대소문자 상관없이 a 자 포함된 이름 출력
-- lower(name) : 어느 부분의 name을 사용할지에 대한 문제로 인해 에러 발생. 테이블명을 무조건 써야함
-- 별칭을 쓰면 좋음. 아니면 모든 이름을 다 써야함
select a.name,grade,kor,eng,math
from students a, stuscore b
where a.name=b.name and lower(a.name) like '%a%'; -- lower(a.name) : 대소문자 상관없이 a 자 포함된 이름 출력

select * from employees;
select * from departments;
-- 사원명, 부서명, 입사일 출력
-- 부서번호가 50번 이상만 출력하시오
select a.emp_name,a.department_id,department_name,hire_date 
from employees a, departments b
where a.department_id = b.department_id
and a.department_id >=50
order by a.department_id;

select * from employees;
select * from jobs;
-- job_id 가 manager인 사원의 job_id,job_title,salary,min_salary, hire_date출력하시오
select a.job_id,job_title,salary,min_salary,hire_date
from employees a, jobs b 
where a.job_id = b.job_id and a.job_id like '%MAN%'; 

-- job_id 가 manager인 사원의 입사일이 02~03월, 05월인 사원을 출력하시오 
select a.job_id,job_title,salary,min_salary,hire_date
from employees a, jobs b 
where a.hire_date = b.hire_date and to_char(a.hire_date, 'mm')in(02,03,05) ;

select to_char(hire_date, 'yyyy-mm-dd hh24:mi:ss') from employees;
select to_char(hire_date, 'mm') from employees;

select to_char(hire_date, 'mm') from employees
where to_char(hire_date, 'mm')>='02' 
and to_char(hire_date, 'mm')>='03' 
and to_char(hire_date, 'mm')>='05';

select substr(hire_date,4,2) from employees
where substr(hire_date,4,2) in ('02','03','05');

select a.job_id,job_title,salary,min_salary,hire_date
from employees a,jobs b
where a.job_id = b.job_id and a.job_id like '%MAN%'
and substr(hire_date,4,2) in ('02','03','05');

-- equi join : 같은 컬럼을 가지고 검색
-- non equi join : 두 테이블 간 같은 컬럼이 없이 검색

-- 3개의 테이블을 가지고 equi-join 
select * from jobs;
select a.department_id,department_name,a.job_id,job_title
from employees a,departments b,jobs c
where a.department_id=b.department_id and 
a.job_id=c.job_id; 

create table sturank(
srank varchar2(10),
low_score number(3),
high_score number(3)
);

-- VVIP,VIP,GOLD,SILVER,BRONZE 
insert into sturank values ('VVIP',91,100);
insert into sturank values ('VIP',81,90);
insert into sturank values ('GOLD',71,80);
insert into sturank values ('SILVER',61,70);
insert into sturank values ('BRONZE',0,60);
commit;

select * from sturank;
select * from stuscore;

select no,name,school,kor,srank 
from stuscore, sturank
where kor between low_score and high_score
order by no; 

-- non equi-join : 같은 컬럼은 없지만, 2개의 테이블을 가지고 검색
select no,name,school,round((kor+eng+math)/3,2),srank 
from stuscore, sturank
where (kor+eng+math)/3 between low_score and high_score
order by no;

-- 
select salary from employees
order by salary desc;

-- 0~3999    # E등급 
-- 4000~6999   # D등급
-- 7000~9999   # C등급
-- 10000~11999  # B등급
-- 12000~30000  # A등급

-- non equi-join
create table emprank(
erank varchar2(20),
low_salary number(20),
high_salary number(20)
);

insert into emprank values ('A등급',12000,30000);
insert into emprank values ('B등급',10000,11999);
insert into emprank values ('C등급',7000,9999);
insert into emprank values ('D등급',4000,6999);
insert into emprank values ('E등급',0,3999);
commit;


select * from emprank; 
select emp_name,salary,erank,low_salary,high_salary,hire_date
from employees, emprank 
where salary between low_salary and high_salary
order by salary; 

select * from emprank;

-- case when then 
select salary, 
case
when salary between 0 and 3999 then 'E등급'
when salary between 4000 and 6999 then 'D등급'
when salary between 7000 and 9999 then 'C등급'
when salary between 10000 and 11999 then 'B등급'
when salary between 12000 and 30000 then 'A등급'
-- else 'A등급'
end as emprank 
from employees;

select * from stuscore;
alter table stuscore add rank varchar2(20);

-- case when-then
select * from sturank;
update stuscore a set rank = (
select srank
from sturank b
where a.kor between b.low_score and b.high_score); 

select * from stuscore;
alter table stuscore add avg number(5,2);
update stuscore set avg = (kor+eng+math)/3;

update stuscore a set rank = (
select name, school, srank
from sturank b
where a.avg between b.low_score and b.high_score);

select srank
from sturank,stuscore
where avg between low_score and high_score;

--SELECT student_id,
--CASE
--WHEN student_id BETWEEN 1 AND 10 THEN '1반'
--WHEN student_id BETWEEN 11 AND 20 THEN '2반'
--WHEN student_id BETWEEN 21 AND 30 THEN '3반'
--ELSE '기타'
--END AS class_name
--FROM students;

-- bfile 분리 : filegroup 테이블 생성
create table filegroup(
bno number(4),
bfile varchar2(100),
constraint board_filegroup_fk_bno foreign key(bno)
references board(bno) on delete cascade
); 

-- 컬럼삭제 
alter table board drop column bfile;
select * from board;

insert into filegroup values (1,'1.jpg');
insert into filegroup values (2,'1111.jpg');
insert into filegroup values (2,'2222.jpg');
insert into filegroup values (3,'333.jpg');
insert into filegroup values (4,'44.jpg');
insert into filegroup values (5,'5.jpg');
insert into filegroup values (6,'6.jpg');
commit;
select * from filegroup;

select a.bno,btitle,bfile from board a,filegroup b
where a.bno = b.bno;

select * from board where bno=1;
select * from filegroup where bno=1; -- 여러 개 있을 경우가 있을 수 있음

--
create table event(
eno number(4) primary key,
etitle varchar2(1000),
econtent clob,
efile varchar2(100)
);

insert into event values (
event_seq.nextval,'이벤트제목','내용입니다','1.jpg'
);
commit;

select * from employees;
select * from departments;
select emp_name,a.department_id,department_name
from employees a, departments b
where a.department_id=b.department_id;

select name, kor+eng+math total, sw from stuscore;

-- 파일 여러 개 저장 
-- equi join : 같은 컬럼을 가지고 2개의 테이블에서 검색
-- non-equi join : 같은 컬럼은 없지만, 2개의 테이블에서 검색
-- seif join : 자신의 테이블을 2번 호출해서 검색 
select * from employees;
select a.employee_id, a.emp_name, a.job_id, a.manager_id, b.emp_name
from employees a,employees b
where a.manager_id=b.employee_id; -- b.employee_id 는 상사의 이름이 출력

-- null 값이 있는 것은 출력에서 제외
select a.employee_id, a.emp_name, a.job_id, a.manager_id, b.emp_name
from employees a,employees b -- seif join (자기 자신을 2번 호출해서 검색)
where a.manager_id=b.employee_id
order by employee_id;

-- inner join
-- outer join : null 값도 출력하라는 의미 
-- 그룹함수는 null값이 제외
select count(*), count(manager_id) from employees;
select a.employee_id, a.emp_name, a.job_id, a.salary, a.manager_id, b.emp_name,
from employees a,employees b -- self join (자기 자신을 2번 호출해서 검색)
where a.manager_id=b.employee_id
order by employee_id; 

-- outer join
-- seif join
select a.employee_id,a.emp_name,a.manager_id,b.emp_name
from employees a, employees b
where a.manager_id = b.employee_id;

select emp_name,manager_id from employees
where manager_id is null; 

-- null 값 포함 출력 (+)
select a.employee_id,a.emp_name,a.manager_id,b.emp_name
from employees a, employees b
where a.manager_id = b.employee_id(+);

--departments, employees 테이블에서
-- employees 테이블에서 없는 부서번호와 부서명도 출력하시오 
-- equi join으로 department_id, department_name 출력하시오
select * from departments;
select * from employees;

-- equi join : outer join
select emp_name, b.department_id, department_name 
from employees a, departments b
where a.department_id=b.department_id(+);

-- b.department_id 에 null값을 넣고 싶으면 반대편이 (+)를 입력해야함
-- 두 곳에는 (+) 입력은 불가능 
select emp_name, b.department_id, department_name 
from employees a, departments b
where a.department_id(+)=b.department_id;

-- a.department_id 에 null값을 넣고 싶으면 반대편이 (+)를 입력해야함
-- outer join은 null값 출력 
select emp_name,b.department_id,department_name
from employees a,departments b
where a.department_id(+) = b.department_id
and emp_name is null;

-- equi join
select emp_name, a.department_id, department_name
from employees a, departments b
where a.department_id = b.department_id;

-- ansi join
select emp_name,department_id
from employees inner join departments 
using (department_id);

-- ansi join + outer join(left)
-- 이 코드에는 (+) 양 쪽에 입력 가능 
select a.emp_name, a.manger_id,employee_id
from employees a left outer join employees b
on a,manger_id = b.employee_id;

select a.emp_name, a.manger_id,employee_id
from employees a left outer join employees b
on a,manger_id(+) = b.employee_id(+);


-- ansi join + outer join(left)
select emp_name,a.department_id,department_name
from employees a left outer join departments b
on a.department_id = b.department_id;

-- ansi join + outer join(right)
select emp_name,a.department_id,department_name
from employees a right outer join departments b
on a.department_id = b.department_id;

-- ansi join + outer join(full)
select emp_name,a.department_id,department_name
from employees a full outer join departments b
on a.department_id = b.department_id;

-- union 은 where 절로 사용해도 가능
-- view 는 필요한 컬럼만 저장 가능. 민감정보를 보이지 않고 지정한 필요컬럼만 저장
-- 일부의 컬럼만 보여지게 함
-- 원하는 컬럼만 작성해서 다른 곳에 join으로 사용 가능
create or replace view view_employees
as select employee_id,emp_name,phone_number
from employees;

select * from view_employees;

select * from stuscore;
select * from students;
select a.name,school,grade,kor,eng,math,avg
from stuscore a, students b
where a.name = b.name;

-- 컬럼에 없는 컬럼 생성 (total 컬럼 생성)
create or replace view view_stu
(
name,school,grade,kor,eng,math,total,avg
) as 
select a.name,school,grade,kor,eng,math,kor+eng+math as total,avg
from stuscore a, students b
where a.name = b.name;

select * from view_stu;
















