#使用 requests、bs4 库，爬取猫眼电影的前 10 个电影名称、电影类型和上映时间，并以 UTF-8 字符集保存到 csv 格式的文件中
import requests
from bs4 import BeautifulSoup as bs
import time
import pandas as pd

target_url = 'https://maoyan.com/films?showType=3'
user_agent = 'User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 ' \
             '(KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36'
cookie = 'uuid_n_v=v1; uuid=D6E60000FD2B11EA985FDD1498D583AFAD99C40050864802B40BF6D8FC074F22;' \
         ' _csrf=f336d91fbbc84f480d883a1d84e4046c97d289697864c65a3499563f9f13fc0a; ' \
         'mojo-uuid=11d5df7e3231d7acae14b20a12440bff; ' \
         'Hm_lvt_703e94591e87be68cc8da0da7cbd0be2=1600817535; ' \
         '_lxsdk_cuid=174b829198cc8-05e1e58e8a5587-b7a1334-100200-174b829198dc8; ' \
         '_lxsdk=D6E60000FD2B11EA985FDD1498D583AFAD99C40050864802B40BF6D8FC074F22; ' \
         'mojo-session-id={"id":"3aaf431617fc10d67c68e31eedbdd018","time":1600820498767}; ' \
         'mojo-trace-id=1; Hm_lpvt_703e94591e87be68cc8da0da7cbd0be2=1600820499; ' \
         '__mta=207994541.1600817535427.1600817535427.1600820498896.2; ' \
         '_lxsdk_s=174b8564cf6-8c0-cb5-d15%7C%7C3'

header = {'user-agent': user_agent, 'cookie': cookie}

response = requests.get(target_url, headers = header)
film_html = bs(response.text, 'html.parser')

for film_item in film_html.find_all('div',attrs={'class':'movie-item'}, limit=10):
    detail = film_item.select('div.movie-hover-title')
    film_name = detail[0].find('span',attrs={'class':'name'}).get_text()
    film_type = detail[1].find('span', attrs={'class': 'hover-tag'}).next_sibling.strip()
    film_roles = detail[2].find('span', attrs={'class': 'hover-tag'}).next_sibling
    film_plan_date = detail[3].find('span', attrs={'class': 'hover-tag'}).next_sibling.strip()

    film_list = {
        '电影名称':[film_name],
        '电影类型':[film_type],
        '上映时间':[film_plan_date]
    }
    movie_csv = pd.DataFrame(data=film_list)
    movie_csv.to_csv('./maoyan_movie.csv', encoding='utf8',index=False,header=False,mode='a')






