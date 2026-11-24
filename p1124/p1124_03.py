import os
from pathlib import Path
from dotenv import load_dotenv
import openai
from openai import OpenAI

# 파일 불러오기
BASE_DIR = Path(__file__).resolve().parent.parent
envFile = BASE_DIR/'.env'
print(BASE_DIR)
print(envFile)

load_dotenv(envFile)
api_key = os.getenv('opne_ai_key')
print('api_key')

# load_dotenv()
# api_key = os.getenv('opne_ai_key')
# print('api_key')

# chat gpt 연결 