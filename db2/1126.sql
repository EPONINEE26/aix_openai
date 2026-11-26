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






