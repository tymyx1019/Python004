import scrapy
from scrapy.selector import Selector
from maoyan.items import MaoyanItem


class MoviesSpider(scrapy.Spider):
    name = 'movies'
    allowed_domains = ['maoyan.com']
    start_urls = ['https://maoyan.com/films?showType=3']

    def start_requests(self):
        movie_url = 'https://maoyan.com/films?showType=3'
        yield scrapy.Request(url=movie_url, callback=self.parse)

    def parse(self, response):
        movies = Selector(response=response).xpath('//div[@class="movie-hover-info"]')
        if not movies:
            raise Exception('没有找到相关内容，请检查是否被反爬虫')

        for movie in movies[:10]:
            item = MaoyanItem()
            title = movie.xpath('./div[@class="movie-hover-title"][1]/span/text()').extract_first().strip()
            cate = movie.xpath('./div[@class="movie-hover-title"][2]/text()')[1].extract().strip()
            plan_time = movie.xpath('./div[@class="movie-hover-title movie-hover-brief"]/text()')[1].extract().strip()

            item['title'] = title
            item['cate'] = cate
            item['plan_time'] = plan_time

            yield item
