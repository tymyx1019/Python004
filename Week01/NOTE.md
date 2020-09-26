学习笔记

本周学习的主要内容是爬虫技术，通过老师的视频教学和代码示例，再结合课后自己练习，基本能够达到爬取某些网站数据的目标。
作为一个没有Python开发经验的Python小白，最大的感触就是多看视频多练习，从勤能补拙的浅显道理出发，到熟能生巧的这个过程，
没有捷径。

本周的两个作业的说明：
1、job1_maoyan.py 对应作业1
2、maoyan文件夹对应作业2，maoyan是项目名，爬虫名称是movies

本周主要遇到的问题和注意事项有如下：
一，按照某些包时，会出现timeout的情况，需要切换到国内的镜像。

二，关于scrapy.Requests方法的回调函数
scrapy.Requests(url, callback),这个方法里面的参数callback传入的是一个方法或者函数，比如本类中的parse，
此时调用的格式如：
	yield scrapy.Requests(url=url, callback=self.parse)

 通过parse(self, response)解析爬取的内容，特别注意的是，parse（）方法里面的response参数可以获取一些
 额外的数据，比如通过response.url可以获取scrapy.Requests的url的值，同理，如果scrapy.Requests传入了更
 多的参数，都可以通过response获取，比如：
 	yield scrapy.Requests(url=url, meta={'item':'aa'}, callback=self.parse)
 那么paser方法里面想要获取meta里面的item的值，可以通过response.meta['item']获取

 三，关于scrapy的Selector.xpath的查找参数问题
 抓取猫眼电影过程中，出现如下的网页结构：
 	&#60;div class="movie-hover-info">
        &#60;div class="movie-hover-title" title="我的女友是机器人" >
          &#60;span class="name ">我的女友是机器人</span>
            &#60;span class="score channel-detail-orange">&#60;i class="integer">7.</i>&#60;i class="fraction">3</i></span>
        &#60;/div>
        &#60;div class="movie-hover-title" title="我的女友是机器人" >
          &#60;span class="hover-tag">类型:</span>
          爱情／喜剧
        &#60;/div>
        &#60;div class="movie-hover-title" title="我的女友是机器人" >
          &#60;span class="hover-tag">主演:</span>
          辛芷蕾／包贝尔／魏翔
        &#60;/div>
        &#60;div class="movie-hover-title movie-hover-brief" title="我的女友是机器人" >
          &#60;span class="hover-tag">上映时间:</span>
          2020-09-11
        &#60;/div>
    &#60;/div>
通过div的class="movie-hover-title"查找，查找出来的选择器用[1],[2]分开，例如传入的路径为 /div[@class="movie-hover-title"] ,只能匹配前面三个的内容，如果需要匹配第四个内容（上映时间），则需要传入的class完整的 ./div[@class="movie-hover-title movie-hover-brief"]

四，多看相关手册，很多简单的问题在手册上面都有描述
