# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
import pymysql
from scrapy.utils.project import get_project_settings
from SmzdmPhone.items import SmzdmphoneItem
from SmzdmPhone.items import SmzdmphoneCommentsItem


class SmzdmphonePipeline:
    def open_spider(self, spider):
        try:
            # 配置文件中读取MySQL配置信息
            settings = get_project_settings()
            mysql_config = settings.get('MYSQL_CONFIGS')

            self.conn = pymysql.connect(**mysql_config)
        except Exception as e:
            # 如果连接失败则抛出异常
            raise Exception('数据库连接失败，请检查连接地址或用户信息！')

        self.cursor = self.conn.cursor()

    def process_item(self, item, spider):
        if isinstance(item, SmzdmphoneItem):
            try:
                sql = "INSERT INTO phones (sid, title, zhi, buzhi, star, comments) VALUES (%s,  %s, %s, %s, %s, %s)"
                # print(tuple(item.values()))
                self.cursor.execute(sql, tuple(item.values()))
            except Exception as e:
                self.conn.rollback()
                # print(f'手机信息写入数据库异常：{e}')
            return item

        if isinstance(item, SmzdmphoneCommentsItem):
            try:
                sql = "INSERT INTO phone_comments (content, mark, sid, cid, public_date) VALUES (%s, %s, %s, %s, %s)"
                self.cursor.execute(sql, tuple(item.values()))
            except Exception as e:
                self.conn.rollback()
                print(f"评论信息写入数据库异常：{e}")
            return item

    def close_spider(self, spider):

        # 如果连接资源存在则关闭游标和连接
        if self.conn:
            self.conn.commit()
            self.cursor.close()
            self.conn.close()
