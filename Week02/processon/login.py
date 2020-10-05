import requests
from fake_useragent import UserAgent
from time import sleep

# 利用request登录https://processon.com/
ua = UserAgent(verify_ssl=False)
headers = {
    'user-agent':ua.random,
    'Referer':'https://processon.com/login?f=index'
}

#登录的信息，login_email：邮箱地址或手机号码；login_password：登录密码
data = {
    'login_email':'',
    'login_password':''
}

login_url = 'https://processon.com/login?f=index'

with requests.Session() as s:
    # 通过requests.Session(),后续的操作自动带上登录后的cookie
    response = s.post(url=login_url, data=data, headers=headers)

sleep(3)
url = 'https://processon.com/setting'
oper = s.get(url)
print(oper.text)