# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
import pymysql
from scrapy.utils.project import get_project_settings


class MaoyanPipeline:
    conn = None

    def process_item(self, item, spider):
        if self.conn:
            try:
                sql = 'INSERT INTO items(`title`,`cate`,`plan_time`) VALUES(%s, %s, %s);'
                self.cussor.execute(sql, [item['title'],item['cate'],item['plan_time']] )
                last_id = self.cussor.lastrowid
                print(last_id)
            except Exception as e:
                self.conn.rollback()
                raise Exception('数据插入失败')
            finally:
                self.conn.commit()

    def open_spider(self, spider):
        try:
            # 配置文件中读取MySQL配置信息
            settings = get_project_settings()
            mysql_config = settings.get('MYSQL_CONFIGS')

            self.conn = pymysql.connect(
                host=mysql_config['host'],
                user=mysql_config['user'],
                password=mysql_config['password'],
                database=mysql_config['database'],
                charset=mysql_config['charset']
            )
        except Exception as e:
            # 如果连接失败则抛出异常
            raise Exception('数据库连接失败，请检查连接地址或用户信息！')

        self.cussor = self.conn.cursor()

    def close_spider(self, spider):
        #如果连接资源存在则关闭游标和连接
        if self.conn:
            self.cussor.close()
            self.conn.close()


