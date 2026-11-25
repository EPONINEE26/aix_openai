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

# kor+eng+math/3 평균 80이상인 사람을 출력하시오
# 국어,영어,수학 : 역순정렬로 정렬하시오 

while True:
    # 80점 이상
    avg = input('검색할 평균 점수를 입력하세요.>> ')
    if avg == '': break
    avg = int(avg)
    
    # 역순정렬 
    # input_date = input('정렬한 과목을 입력하세요.>>')
    # if input_date.strip() == '국어' : i = 'kor'
    # elif input_date.strip() == '영어' : i = 'eng'
    # else: i = 'math'
    
    # kor = int(input('검색할 이름을 입력하세요.>>'))
    # if kor == '' : break

    # kor = int(input('국어점수 입력값 이상 점수를 검색함(ex:50점) '))
    # if kor == '' : break
    
    # kor = (input('국어점수 입력값 이상 점수를 검색함(ex:50점) '))
    # if kor == '' : break
    # kor = int(kor)

    # 실행문 
    # sql = "select * from stuscore order by {i} desc"
    sql = f"select * from stuscore where (kor + eng + math) / 3 >= {avg}"
    # sql = f'select * from stuscore where kor>={kor} desc'
    cursor.execute(sql)

    rows = cursor.fetchall()
    print(rows)
    print("인원 : ",len(rows))
    
cursor.close()
# conn.close()    

print('프로그램 종료')


