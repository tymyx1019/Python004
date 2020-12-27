# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class SmzdmphoneItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()
    sid = scrapy.Field()
    title = scrapy.Field()
    zhi = scrapy.Field()
    buzhi = scrapy.Field()
    star = scrapy.Field()
    comments = scrapy.Field()
    


class SmzdmphoneCommentsItem(scrapy.Item):
    content = scrapy.Field()
    sid = scrapy.Field()
    cid = scrapy.Field()
    mark = scrapy.Field()
    public_date = scrapy.Field()