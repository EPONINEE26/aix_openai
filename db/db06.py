import oracledb
import os
from dotenv import load_dotenv

# 1.불러오기
load_dotenv()
ora_conn = os.getenv('ora_conn')
# print(ora_conn)

# 2. db연결
conn = oracledb.connect(ora_conn)
# print(conn)
cursor = conn.cursor()
print(cursor)

# 3. 쿼리작성실행
# employees, emprank, non-equl join를 사용해서 월급의 등급을 출력하시오
# emp_name, salary,erank, low_salary, high_score, hire_date 출력하시오
#-- 0~3999    # E등급 
#-- 4000~6999   # D등급
#-- 7000~9999   # C등급
#-- 10000~11999  # B등급
#-- 12000~30000  # A등급

# sql = 'select * from stuscore'
# cursor.execute(sql)

# 디장고 - html, key, value 값으로 전달 (dict 타입으로 변환이 필요)
# employees, departments 테이블 이용해서 emp_name, department_id,deparment_name 출력하시오.
# sql = '''select emp_name,a.department_id,department_name
# from employees a, departments b
# where a.department_id=b.department_id
# '''

sql = 'select name, kor+eng+math total, sw from stuscore'
cursor.execute(sql)

# sql = '''select emp_name,salary,erank,low_salary,high_salary,hire_date
# from employees, emprank 
# where salary between low_salary and high_salary
# order by salary
# '''
cursor.execute(sql)

# sql = 'select * from stuscore'
# cursor.execute(sql)

# sql = 'select * from event'
# cursor.execute(sql)

# 컬럼명을 추출 : description
columns = [col[0] for col in cursor.description]
# print(columns)

# 4. 데이터정보전달
rows = cursor.fetchall()

# 4-2 딕셔너리 형태로 변환 (sql로 불러올 경우 변환이 필수)
# 하기 코드를 디장고로 전달해서 출력하면 됨
rows = [ dict(zip(columns,row))for row in rows]
print(rows)
context = {'stulist':rows}

# return render ('index.html',context={'stulist':rows})

# 5. 데이터출력
# for row in rows:
#     print(row)

# for row in rows:
#     print(row[0],row[1],row[2],row[3])

# for row in rows:
#     print(row[0],row[1],row[2],row[3],row[4],row[5])
    
# 5-2 insert, update, delete 할 경우
# insert - board 
# insert - file1
# insert - file2
# insert - file3 
# 이런 식으로 저장을 해야함


conn.commit()
conn.rollback()   
    
# 6. db정보 닫기 
cursor.close()
conn.close()





