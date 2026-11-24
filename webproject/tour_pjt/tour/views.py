import openai                        # openai.APIConnectionError 등 예외 이름을 쓰기 위해 불러옵니다.
from openai import OpenAI            # OpenAI(GPT)와 대화하기 위해 불러옵니다.
from django.shortcuts import render  # 파이썬 데이터를 HTML 파일과 합쳐서 웹 브라우저에 띄워주는 함수입니다.

# 내 컴퓨터에 등록된 OPENAI_API_KEY를 자동으로 불러와 GPT와 연결합니다.
client = OpenAI()


# 1. 기본 메인 페이지 (/tour/)
def tour(request):
    return render(request, 'tour.html')


# 2. [여행일정] 페이지 (/tour/tlist/)
def tlist(request):
    result = ""

    try:
        response = client.responses.create(
            model='gpt-5.6',
            instructions=(
                "당신은 경주 여행 전문가입니다. "
                "경주 1박 2일 여행일정을 알려주세요. "
                "[1일차 오전/오후/저녁], [2일차 오전/오후] 시간대별 동선 위주로 알려주세요. "
                "초보자도 이해하기 쉽게 간략하게 답해주세요."
            ),
            input="경주 1박 2일 여행일정 추천",
            max_output_tokens=500,
        )
        result = response.output_text.strip()
        if not result:
            raise RuntimeError('응답결과 내용이 없습니다.')

    except openai.APIConnectionError as error:
        result = f"인터넷 연결, 방화벽 문제 등 확인요망 : {error}"
    except openai.RateLimitError as error:
        result = f"요청량 또는 프로젝트 사용한도 확인 : {error}"
    except openai.APIError as error:
        result = f"인증, 권한 등 api 오류 확인 : {error}"

    # 배우신 원본 코드의 변수명(result) 그대로 tour.html의 {{ result }} 자리에 전달합니다.
    context = {
        'result': result,
    }
    return render(request, 'tour.html', context)


# 3. [여행지] 페이지 (/tour/tplace/)
def tplace(request):
    result = ""

    try:
        response = client.responses.create(
            model='gpt-5.6',
            instructions=(
                "당신은 경주 여행 전문가입니다. "
                "경주 1박 2일 필수 여행지를 알려주세요. "
                "[역사유적지], [야경명소], [사진찍기 좋은 곳]을 위주로 알려주세요. "
                "초보자도 이해하기 쉽게 간략하게 답해주세요."
            ),
            input="경주 1박 2일 여행지 추천",
            max_output_tokens=500,
        )
        result = response.output_text.strip()
        if not result:
            raise RuntimeError('응답결과 내용이 없습니다.')

    except openai.APIConnectionError as error:
        result = f"인터넷 연결, 방화벽 문제 등 확인요망 : {error}"
    except openai.RateLimitError as error:
        result = f"요청량 또는 프로젝트 사용한도 확인 : {error}"
    except openai.APIError as error:
        result = f"인증, 권한 등 api 오류 확인 : {error}"

    context = {
        'result': result,
    }
    return render(request, 'tour.html', context)


# 4. [숙소] 페이지 (/tour/tstay/)
def tstay(request):
    result = ""

    try:
        response = client.responses.create(
            model='gpt-5.6',
            instructions=(
                "당신은 경주 여행 전문가입니다. "
                "경주 1박 2일 추천 숙소를 알려주세요. "
                "[황리단길 한옥스테이], [보문단지 리조트/호텔], [가성비 숙소]를 위주로 알려주세요. "
                "초보자도 이해하기 쉽게 간략하게 답해주세요."
            ),
            input="경주 1박 2일 숙소 추천",
            max_output_tokens=500,
        )
        result = response.output_text.strip()
        if not result:
            raise RuntimeError('응답결과 내용이 없습니다.')

    except openai.APIConnectionError as error:
        result = f"인터넷 연결, 방화벽 문제 등 확인요망 : {error}"
    except openai.RateLimitError as error:
        result = f"요청량 또는 프로젝트 사용한도 확인 : {error}"
    except openai.APIError as error:
        result = f"인증, 권한 등 api 오류 확인 : {error}"

    context = {
        'result': result,
    }
    return render(request, 'tour.html', context)


# 5. [식사추천] 페이지 (/tour/tfood/)
def tfood(request):
    result = ""

    try:
        response = client.responses.create(
            model='gpt-5.6',
            instructions=(
                "당신은 경주 여행 전문가입니다. "
                "경주 1박 2일 식사 및 맛집을 알려주세요. "
                "[경주 대표 향토음식], [황리단길 인기 식당], [디저트/카페]를 위주로 알려주세요. "
                "초보자도 이해하기 쉽게 간략하게 답해주세요."
            ),
            input="경주 1박 2일 식사추천",
            max_output_tokens=500,
        )
        result = response.output_text.strip()
        if not result:
            raise RuntimeError('응답결과 내용이 없습니다.')

    except openai.APIConnectionError as error:
        result = f"인터넷 연결, 방화벽 문제 등 확인요망 : {error}"
    except openai.RateLimitError as error:
        result = f"요청량 또는 프로젝트 사용한도 확인 : {error}"
    except openai.APIError as error:
        result = f"인증, 권한 등 api 오류 확인 : {error}"

    context = {
        'result': result,
    }
    return render(request, 'tour.html', context)
