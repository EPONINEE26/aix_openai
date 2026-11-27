select * from board;

-- bno 1~10번까지 가져오기
select * from board
where bno>=1 and bno<=10;

select * from board
where bno between 1 and 10;


-- 3,7,11,20,22,23,26,35,36,38,49,54번 삭제
delete board where bno=54;

-- 삭제 후 10개를 불러오면 10개가 아니라 개수가 줄어듬
select * from board
where bno between 1 and 10;

--rownum (삭제 후 번호 재수정)
select rownum, bno, id from board;
select rownum, a.* from board a;

select  rownum, a.* from board a;
select  rownum, a.* from board a
where rownum>=1 and rownum<=10;

-- rownum을 실행하니깐 11번이 1번으로 변경되고 1번이 있었던 정보를 삭제하여 실행하기에 아에 출력이 안됨
select  rownum, a.* from board a
where rownum>=11 and rownum<=20;

select * from board;
select  rownum rnum, a.* from board a;
select * from (select  rownum rnum, a.* from board a)
where rnum>=1 and rnum<=10;
select * from (select  rownum rnum, a.* from board a)
where rnum>=11 and rnum<=20;

select * from board a order by id desc;
select rownum rnum, b.* from (select * from board a order by id desc) b;

select * from 
(select rownum rnum, b.* from (select * from board a order by id desc) b)
where rnum>=1 and rnum<=10;
-- 11번부터 20번 출력 
select * from 
(select rownum rnum, b.* from (select * from board a order by id desc) b)
where rnum>=11 and rnum<=20;

-- 합계점수가 가장 높은 학생 1에서 20을 출력하고 앞에 번호를 부여해서 출력하시오
select * from stuscore;
select name, school, kor,eng,math, kor,eng,math,kor+eng+math as total, avg 
from stuscore order by total desc; 

select rownum rnum, b.* from 
(select a.*,(kor+eng+math) total from stuscore a
order by total desc) b 
where rownum >=1 and rownum<=20;

-- row_number() over():정렬을 먼저 한 후 번호부여
-- rownum : 번호를 먼저 부여한 후 정렬 
select row_number() over (order by kor desc) rnum, a.* 
from stuscore a; 

select * from ( 
select row_number() over (order by kor desc) rnum, a.* 
from stuscore a) 
where rnum >= 1 and rnum <= 20;

select * from ( 
select rownum rnum, b.* from ( 
select a.*, (kor+eng+math) tot from stuscore a
order by tot desc ) b
) where rnum>=11 and rnum<=20;

-- rank : 순위
-- rank() : 동일점수가 있을때 중복순위 개수만큼 다음 순위가 증가됨 
-- dense_rank() : 동일점수가 존재해도 다음순위 표시
select * from stuscore;
select rank() over(order by (kor+eng+math) desc), a.* from stuscore a;
select rank() over(order by (kor+eng+math) desc), kor+eng+math from stuscore a;
select dense_rank() over(order by (kor+eng+math) desc), kor+eng+math from stuscore a;

select * from stuscore;
-- add 
alter table stuscore add total number(3);
desc stuscore;
--update 
update stuscore set total = kor+eng+math;
ALTER TABLE stuscore MODIFY total NUMBER(5);

select name,total, rank() over (order by total desc) ranks
from stuscore;

update stuscore set rank=null;
commit;
alter table stuscore modify rank number(5);
desc stuscore;

-- rank() over() 사용해서 rank 컬럼 등수를 입력
select name,total, rank() over (order by total desc) ranks
from stuscore;

--합계점수를 update 사용해서 입력
update stuscore set total = kor+eng+math;
select name,total, rank() over (order by total desc) ranks from stuscore;
select rank() over(order by total desc) ranks from stuscore;
-- 단일 행 하위 질의에 2개 이상의 행이 리턴에러로 안 됨 
--update stuscore set rank = (
--select rank() over(order by total desc) ranks from stuscore
--);

update stuscore set rank = (
select ranks from (
select ranks from (
select name, rank() over(order by total desc) ranks from stuscore
) b 
where a.name=b.name
);

select rank from (
select name, rank() over(order by total desc) ranks from stuscore
) b
);

select name, rank() over(order by total desc) ranks from stuscore;
select ranks from (
select name, rank() over(order by total desc) ranks from stuscore
) b 
where a.name=b.name
);

select no,name,rank from stuscore a;
select no, name,rank() over(order by total desc) ranks from stuscore b;
update stuscore a set rank = (
select ranks from
(select name, rank() over(order by total desc) ranks from stuscore) b 
where a.name=b.name ); 

select * from stuscore order by rank;

create table employees2 as select * from employees;
select * from employees2;

-- employees2 테이블에 rank의 컬럼을 생성하고 
-- 월급이 높은 순으로 rank를 입력하시오
select * from employees2;
select salary, rank() over(order by salary desc) from employees2;
select employee_id, emp_name,salary from employees2 order by salary desc; 
-- rank 컬럼 생성 
alter table employees2 add rank number(5);
desc employees2;
-- primary key가 무엇인지 확인 한 다음 실행을 해야함
select salary, rank() over(order by salary desc) from employees2;
select employee_id, emp_name,salary from employees2 order by salary desc;
select employee_id, emp_name,salary from employees2
where salary=24000;

update employees2 a set rank = (
select ranks from
(select employee_id,emp_name, rank() over(order by salary desc) ranks 
from employees2) b 
where a.employee_id=b.employee_id );

select employee_id, emp_name, salary, rank from employees2;

select * from students;
select * from stuscore;
select * from sturank;

-- member 테이블에 rank 생성하고
-- board bhit가 높은 순으로 순위를 부여해서
-- member 테이블의 rank에 입력하시오
-- board 테이블에 rank 생성하기
select * from member;
select * from board;
alter table member add rank number(5); 
desc member;

select bhit from board;
select a.id, a.name, b.bhit, rank() over(order by b.bhit desc) ranks
from member a, board b
where a.id = b.id;

-- member 테이블에 rank 컬럼에 board 컬럼의 bhit 등수를 입력
update member a set rank = (
select ranks from (
select a.id, rank() over(order by b.bhit desc) ranks 
from member a, board b
where a.id = b.id
) b 
where a.id = b.id and rownum = 1
);
select * from member order by rank asc;

select * from board;
alter table board add rank number(5);
desc board;
select bhit from board;
select id, bhit, rank() over(order by bhit desc) ranks
from board;

-- board 테이블의 rank 컬럼에 등수를 입력
select bhit, rank() over(order by bhit desc) from board;
update board a set rank = (
select ranks from (
select id,rank()over(order by bhit desc) ranks from board
) b
where a.id=b.id
);
select bhit,rank from board order by bhit desc; 

select * from board;
select id, count(bhit)from board;
select id,count(bhit)from board
group by id;

select count(school) from stuscore;
select school,count(school) from stuscore
group by school
order by school desc;

select rownum rnum, a.* from (
    select school, count(school) cnt from stuscore
    group by school
    order by cnt desc
) a;

-- 그룹별 등수 출력
select * from stuscore;
select school,total,rank()over(
partition by school
order by total desc) ranks
from stuscore;

-- kor 50점 이상을 출력하시오
select * from stuscore
where kor>=50;

-- eng 80점 이상을 출력하시오
select * from stuscore
where eng>=80;

select * from stuscore;
select * from 
(select * from stuscore where kor>=50) 
where eng>=80;

select * from stuscore;
select bno,a.id,nickname
from board a, member b
where a.id=b.id;

select * from board;
select bno,a.id,nickname,btitle,bcontent,
bgroup,bstep,bindent,bhit
from board a, member b
where a.id=b.id;
