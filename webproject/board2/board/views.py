from django.shortcuts import render
import oracledb
from dotenv import load_dotenv
from pathlib import Path
import os
from board.models import Board 

# 전역변수
BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent
env_file = BASE_DIR/'.env'
load_dotenv(env_file)
ora_conn = os.getenv('ora_conn')
# print('확인 : ',BASE_DIR)

import oracledb
from django.shortcuts import render

# 1. 게시글 목록 페이지 (board 테이블 데이터 출력)
def blist(request):
        # 오라클 데이터베이스에 접속
        conn = oracledb.connect(ora_conn)
        # SQL 쿼리를 실행할 커서(작업 도구) 생성
        cursor = conn.cursor()
        
# 게시글 전체 조회 (최신 원글 그룹 순 내림차순, 답글 순서 오름차순 정렬)
        sql = 'select * from board order by bgroup desc, bstep asc'
        # 작성한 SQL문 실행
        cursor.execute(sql)
        
# 조회된 테이블의 컬럼 이름만 뽑아서 소문자 리스트로 변환 (예: ['ebno', 'id', 'btitle', ...])
# (오라클은 기본 대문자로 가져오므로 HTML 소문자 변수명과 맞추기 위해 .lower() 사용)
        columns = [col[0].lower() for col in cursor.description]
        
# 실행된 쿼리의 모든 데이터(행) 가져오기
        rows = cursor.fetchall()
        
# 컬럼 이름(columns)과 데이터 한 줄(row)을 1:1로 짝지어 딕셔너리 리스트로 변환
# 예: [{'ebno': 1, 'btitle': '제목1', ...}, {'ebno': 2, 'btitle': '제목2', ...}]
        rows_list = [dict(zip(columns, row)) for row in rows]
        
# 사용이 끝난 커서와 DB 연결 닫기 (자원 반납)
        cursor.close()
        conn.close()
        
# HTML 템플릿으로 전달할 데이터를 'blist'라는 이름으로 포장
        context = {'blist': rows_list}
        # context 데이터를 담아서 blist.html 화면 출력
        return render(request, 'blist.html', context)




# 2. 게시판2 목록 페이지 (member 테이블 데이터 출력)
def blist2(request):
# 오라클 데이터베이스에 접속
        conn = oracledb.connect(ora_conn)
        # SQL 쿼리를 실행할 커서 생성
        cursor = conn.cursor()

        # 회원 전체 조회 (가입일 최신순 내림차순 정렬)
        sql = 'select * from member order by mdate desc'
        # 작성한 SQL문 실행
        cursor.execute(sql)

        # 조회된 member 테이블의 컬럼 이름을 소문자 리스트로 추출
        columns = [col[0].lower() for col in cursor.description]
        # 모든 회원 데이터 가져오기
        rows = cursor.fetchall()

        # 컬럼 이름과 회원 데이터 한 줄(row)을 짝지어 딕셔너리 리스트로 변환
        rows_list = [dict(zip(columns, row)) for row in rows]

        # 커서와 DB 연결 닫기
        cursor.close()
        conn.close()

# HTML 템플릿으로 전달할 데이터를 'blist2'라는 이름으로 포장
        context = {'blist2': rows_list}
        # context 데이터를 담아서 blist2.html 화면 출력
        return render(request, 'blist2.html', context)
