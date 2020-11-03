import requests
import lxml.etree
import time
import pymysql
import fake_useragent


def download(request_url):
    # print(url)
    # 请求头部信息
    ua = fake_useragent.UserAgent(verify_ssl=False)
    # user_agent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.108 Safari/537.36'
    header = {}
    header['user-agent'] = ua.random
    response = requests.get(request_url, headers=header)

    # xml化处理
    selector = lxml.etree.HTML(response.text)
    # print(response.text)

    # 短评得分
    star = selector.xpath('//*[@class="comment"]//span[2]/span[2]/@class')

    # 短评内容
    shorts = selector.xpath('//*[@class="comment"]//span[@class="short"]/text()')

    # 用户名
    user_name = selector.xpath('//*[@class="comment"]//span[2]/a/text()')

    #发布时间
    pub_date = selector.xpath('//*[@class="comment"]//span[2]/span[3]/text()')

    # 结尾页
    end = selector.xpath('//*[@class="comment-paginator"]/li[3]/span/@class')

    return (star, user_name, shorts, pub_date), end

def mysql_conn():
    db_config = {
        'host': '127.0.0.1',
        'user': 'root',
        'password': 'root',
        'database': 'douban',
        'port': 3306,
        'charset': 'utf8mb4'
    }

    conn = pymysql.connect(**db_config)
    cursor = conn.cursor()

    return conn, cursor

def write_to_mysql(page_content):

    for i in range(len(page_content[0])):
        rating = page_content[0][i][7:8]
        user_name = page_content[1][i]
        comment_content = page_content[2][i]
        pub_date = page_content[3][i]

        try:
            sql = 'INSERT INTO movies_comments(`user_name`,`comment_content`,`pub_date`,`rating`) VALUES(%s, %s, %s, %s) '
            cursor.execute(sql, [user_name, comment_content, pub_date,rating ])
            last_id = cursor.lastrowid
        except Exception as e:
            conn.rollback()
            raise Exception('数据插入失败')
        finally:
            conn.commit()


if __name__ == '__main__':
    conn, cursor = mysql_conn()

    for page in range(0, 20):
        url = 'https://movie.douban.com/subject/1292052/comments?start={}&limit=20&status=P&sort=new_score'
        url = url.format(page*20)

        content, endpage = download(url)
        write_to_mysql(content)
        if endpage:
            # print(f'debug --- {endpage}')
            if endpage[0] == 'page-disabled':
                break
        time.sleep(2)


    cursor.close()
    conn.close()