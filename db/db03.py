import oracledb
import os
from dotenv import load_dotenv

load_dotenv()
ora_conn = os.getenv('ora_conn')
conn = oracledb.connect(ora_conn)

cursor = conn.cursor()

# insert

# sql = "insert into stuscore2 (no,name,school,height,kor,eng,math,total,avg,specialty) values\
#     (:no,:name,:school,:height,:kor,:eng,:math,:total,:avg,:specialty)"

# # 2번 홍길순
# no = 2
# name = '홍길순'
# school = '디지털고'
# height = 190
# kor = 90
# eng = 90
# math = 90
# total = 270
# avg = 90
# specialty = 'python'

# cursor.execute(sql,no=no,name=name,school=school,height=height,kor=kor,eng=eng,math=math,total=total,avg=avg,specialty=specialty)


# conn.commit()
# cursor.close()

# print('프로그램 종료')
# conn.close()


sql = "insert into stuscore2 (no,name,school,height,kor,eng,math,total,avg,specialty) values\
    (:no,:name,:school,:height,:kor,:eng,:math,:total,:avg,:specialty)"

# 3번 홍길자
no = 3
name = '홍길자'
school = '구로구'
height = 190
kor = 100
eng = 90
math = 80
total = 270
avg = 90
specialty = 'Java'

cursor.execute(sql,no=no,name=name,school=school,height=height,kor=kor,eng=eng,math=math,total=total,avg=avg,specialty=specialty)


conn.commit()
cursor.close()

print('프로그램 종료')
conn.close()


# 실행문 --- update
# sql = "delete stuscore2 where no=:no"
# cursor.execute(sql,no=2)
# cursor.close()

# #------------------------------
# 실행문 --- update
# sql = "update stuscore2 set height=:height,specialty=:specialty where no!=:no"
# cursor.execute(sql,height=180,specialty='C',no=3)
# cursor.close()
# #------------------------------

# #------------------------------
# 실행문 --- insert
# sql = "insert into stuscore2 (no,name,school) values (:no,:name,:school)"
# cursor.execute(sql, no=no, name=name, school=school)
# conn.commit()
# cursor.close()
# #------------------------------

# print('프로그램 종료')
# conn.commit()
# conn.close()
