#第二周学习笔记
本周主要学习内容有异常、PYMYSQL、反爬虫、及scrapy中间件、分布式爬虫


##异常处理（保证程序的健壮运行）

* 程序出现异常，Traceback会顺序记录错误的调用栈信息，通过最后一条信息可以找到异常错误的源头。
* 通过try...except...finally语句进行捕获和处理，其中finally可以有，也可以没有，比如利用pymysql进行MySQL插入操作，如果失败，finally代码里面则进行回滚操作：
```python
        try:
            insert_sql = 'INSERT INTO items(`title`,`cate`,`plan_time`) VALUES(%s, %s, %s);'
            self.cussor.execute(insert_sql, [item['title'],item['cate'],item['plan_time']] )
        except Exception as e:
            self.conn.rollback()
        finally:
            self.conn.commit()

```
* 编写自定义的异常处理程序，通过raise来抛出异常。

##PYMYSQL
pymysql是一款优秀的第三方库，让我们很方便的连接MySQL，使用步骤如下：
	* 通过调用pymysql.connect()创建一个连接(con)
	* 通过上述的连接(con)创建一个游标,cur = con.cursor()
	* 通过游标进行CRUD操作
	* 关闭游标，关闭连接

##反爬虫
请求头信息里面的user-agent, cookie是最常规的反爬虫操作，爬虫程序通过模拟浏览器user-agent，通过模拟提交登录获取cookie可以比较容易绕过反爬虫技术。
如果遇到比较复杂的js加密的URL，可以利用webdriver模拟用户点击等行为进行操作。

##scrapy中间件
scrapy提供了丰富的中间件，主要通过下面四个方法进行重写：
* process_request(request, spider)
	* Request 对象经过下载中间件时会被调用，优先级高的先调用
* process_response(request, response, spider)
	* Response 对象经过下载中间件时会被调用，优先级高的后调用
* process_exception(request, exception, spider)
	* 当 process_exception() 和 process_request() 抛出异常时会被调用
* from_crawler(cls, crawler)
	* 使用 crawler 来创建中间器对象，并（必须）返回一个中间件对象

##分布式爬虫
主要通过redis实现多台scrapy爬虫共享队列和管道
	* 使用了 RedisSpider 类替代了 Spider 类
	* redis实现Scheduler 的 queue和 item pipeline