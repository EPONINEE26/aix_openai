from django.shortcuts import render

# Create your views here.
from django.shortcuts import render
import os
from pathlib import Path
from dotenv import load_dotenv
from member.models import Member
from django.db.models import F,Q
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import smtplib                             
from email.mime.text import MIMEText
import random
import string

# 로그인 - get:로그인페이지, post-로그인확인
def logout(request):
    request.session.clear()
    context = {'temp':2}
    return render(request,'login.html',context)


# 로그인 - get:로그인페이지, post-로그인확인
def login(request):
    if request.method == 'GET':
        return render(request,'login.html')
    elif request.method == 'POST':
        id = request.POST.get('id')
        pw = request.POST.get('pw')
        qs = Member.objects.filter(id=id,pw=pw) 
        if qs:
            qs = qs[0]
            request.session['session_id'] = qs.id
            request.session['session_nickname'] = qs.nickname
            temp = 1
        else:
            temp = 0
        context = {'temp':temp}        
        return render(request,'login.html',context)

def membership1(request):
    return render(request, 'membership1.html')

def membership2(request):
    return render(request, 'membership2.html')

def membership3(request):
    return render(request, 'membership3.html')   


