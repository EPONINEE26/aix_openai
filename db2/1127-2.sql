drop table board;

create table board (
    ebno number(4) primary key,
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

create table member (
    id varchar2(100) primary key,
    pw varchar2(100),
    name varchar2(100),
    nickname varchar2(100),
    tel varchar2(30),
    gender varchar2(10),
    hobby varchar2(100),
    mdate date default sysdate
);

alter table member modify gender varchar2(30);

select * from board;
select * from member;

