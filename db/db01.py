import oracledb
import os
from dotenv import load_dotenv

# oracle 접속정보 : sql 정보를 더블클릭
load_dotenv()
ora_conn = os.getenv('ora_conn')
conn = oracledb.connect(ora_conn)

# print(conn.version)

# connect : 연결한다는 의미
# cursor : 창을 연다는 의미
# execute : 실행한다, 저장한다는 의미
# fetchone() : 데이타 한 행씩 함수로 접근한 후 출력한다는 의미 

# 커서연결 : sql명령어 창 연결
cursor = conn.cursor()

# 실행문 
# sql = 'select * from students'
sql = 'select * from students where no=1'
# sql = 'select * from kor_loan_status'
cursor.execute(sql)

# 데이터 연결
# rows 타입은 [()] 
rows = cursor.fetchall()
print(rows)
cursor.close()
conn.close()

# rows 타입은 [[]] : 리스트 안에 리스트
# for row in rows:
#     print(row)

# row 타입은 () : 튜플
# row = cursor.fetchone()
# print(row)

