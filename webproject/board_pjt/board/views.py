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


def blist(request):
        # db접속
        conn = oracledb.connect(ora_conn)
        cursor = conn.cursor()
        # sql = 'select * from board'
        sql = '''select bno, a.id, nickname, btitle, bcontent,
                bgroup, bstep, bindent, bhit
                from board a, member b
                where a.id = b.id'''
        print("test : ",sql)
        cursor.execute(sql)
        # 컬럼정보
        columns = [col[0] for col in cursor.description]
        rows = cursor.fetchall()
        print('확인 : ',columns)
        rows_list = [dict(zip(columns,rows))for row in rows]
        cursor.close()
        conn.close()
        context = {'blist':rows_list}
        return render (request,'blist.html',context)


def blist2(request):
        qs = Board.objects.all().order_by('-bgroup','bstep')
        context = {'list': qs}
        return render(request, 'blist.html', context)

