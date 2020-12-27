import scrapy
from SmzdmPhone.items import SmzdmphoneItem
from SmzdmPhone.items import SmzdmphoneCommentsItem
from snownlp import SnowNLP
from scrapy.utils.project import get_project_settings


class SmzdmSpider(scrapy.Spider):
    name = 'smzdm'
    allowed_domains = ['smzdm.com']
    start_urls = [
        'https://www.smzdm.com/fenlei/zhinengshouji/h5c4s0f0t0p1/#feed-main/']

    def parse(self, response):
        phones = response.xpath(
            '//*[@id="feed-main-list"]/li')  # [position()<11]/div/div[2]

        settings = get_project_settings()
        smzdm_comment_url = settings.get('SMZDM_COMMENT_URL')

        for phone in phones[:10]:
            items = SmzdmphoneItem()
            id_str = phone.xpath('./@articleid').extract()[0]
            # phone_id = '0'
            phone_id = id_str.split('_')[1]
            items['sid'] = phone_id
            items['title'] = phone.xpath(
                './div/div[2]/h5/a/text()')[0].extract()
            items['zhi'] = phone.xpath(
                './div/div[2]/div[@class="z-feed-foot"]/div[1]/span/a[1]/span[1]/span/text()')[0].extract()
            items['buzhi'] = phone.xpath(
                './div/div[2]/div[@class="z-feed-foot"]/div[1]/span/a[2]/span[1]/span/text()')[0].extract()
            items['star'] = phone.xpath(
                './div/div[2]/div[@class="z-feed-foot"]/div[1]/a[1]/span/text()')[0].extract()
            items['comments'] = phone.xpath(
                './div/div[2]/div[@class="z-feed-foot"]/div[1]/a[2]/span/text()')[0].extract()
            yield items

            comment_url = smzdm_comment_url + phone_id + '/'

            yield scrapy.Request(comment_url, callback=self.comments_parse, meta={'ID': phone_id})

    def comments_parse(self, response):
        ID = response.meta['ID']
        comment_list = response.xpath(
            '//div[@id="commentTabBlockNew"]//div[@class="comment_conBox"]')
        for comment in comment_list:
            items = SmzdmphoneCommentsItem()
            items['content'] = comment.xpath(
                './div[@class="comment_conWrap"]/div[1]/p/span/text()')[0].extract()
            items['mark'] = SnowNLP(items['content']).sentiments
            items['sid'] = ID
            items['cid'] = comment.xpath(
                './div[@class="comment_conWrap"]/div[1]/input/@comment-id')[0].extract()

            public_date = comment.xpath(
                './div[1]/div[1]/meta/@content')[0].extract()
            items['public_date'] = int(public_date.replace('-', ''))
            # items['public_date'] = '2020-01-12'
            yield items
        next_links = response.xpath(
            '//*[@id="commentTabBlockNew"]//li[@class="pagedown"]/a/@href').extract()
        if next_links and len(next_links) > 0:
            next_link = next_links[0]
            yield scrapy.Request(next_link, callback=self.comments_parse, meta={'ID': ID})
