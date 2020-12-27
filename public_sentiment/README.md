## 毕业项目：构建一个舆情分析平台

###### 项目背景：某公司计划新上线一款苏打水饮料，为了了解用户对苏打水的接受程度，需要抓取“什么值得买”( https://www.smzdm.com/fenlei/qipaoshui/ ) 网站中气泡水种类前 10 的产品的用户评论，通过对用户评论的正向、负向评价了解排名前 10 的气泡水产品的用户接受程度。

注意：
由于这个网站的产品是实时更新的，一些新的气泡水产品可能没有足够数量的评论，大家可以将气泡水替换为其他产品，比如：

手机产品 24 小时排行 https://www.smzdm.com/fenlei/zhinengshouji/h5c4s0f0t0p1/#feed-main/
电脑游戏最新排行 https://www.smzdm.com/fenlei/diannaoyouxi/
洗发护发产品 24 小时排行 https://www.smzdm.com/fenlei/xifahufa/h5c4s0f0t0p1/#feed-main/
具体需求：

正确使用 Scrapy 框架或 Selenium 获取评论，如果评论有多页，需实现自动翻页功能，将原始评论结果存入 MySQL 数据库，并使用定时任务每天定期更新。
对评论数据进行清洗（可借助 Pandas 库），并进行语义情感分析，将分析结果存入数据库。
使用 Django 集成在线图表对采集数、舆情进行展示，需包括该产品正、负评价比例，以及评价内容等。
数据展示支持按时间筛选和按关键词筛选功能（参考）
https://www.yqt365.com/newEdition/wb/event/analysis/w1yqtxwb62574190201152403817
评分标准：（实现相应功能，每项 +10 分，部分实现 +5 分）
1. 正确使用 Scrapy 框架获取评论，如果评论有多页，需实现自动翻页功能。
2. 评论内容能够正确存储到 MySQL数据库中，不因表结构不合理出现数据截断情况。
3. 数据清洗后，再次存储的数据不应出现缺失值。
4. Django 能够正确运行，并展示采集到的数据，数据不应该有乱码、缺失等问题。
5. 在 Django 上采用图表方式展示数据分类情况。
6. 舆情分析的结果存入到 MySQL 数据库中。
7. 在 Django 上采用图表方式展示舆情分析的结果。
8. 可以在 Web 界面根据关键字或关键词进行搜索，并能够在页面展示正确的搜索结果。
9. 支持按照时间（录入时间或评论时间）进行搜索，并能够在页面展示正确的搜索结果。
10. 符合 PEP8 代码规范，函数、模块之间的调用高内聚低耦合，具有良好的扩展性和可读性。


### 我做的项目选取的是什么值得买的手机产品
###### 链接地址: https://www.smzdm.com/fenlei/zhinengshouji/h5c4s0f0t0p1/#feed-main/

#### 页面结构分析
##### 手机列表html页面如下：

```
<ul id="feed-main-list" class="feed-list-hits">
	<li class="feed-row-wide" articleid="3_28308907" data-position="1" data-cid="2" data-atp="3" data-tagid="无">
        <div class="feed-block z-hor-feed">
            <div class="z-feed-img">
                <a href="https://www.smzdm.com/p/28308907/" target="_blank" onclick="sensors.track('FeedArticleClick', {'business':'百科','sub_business':'分类','feed_name':'品类页feed流','tab1_name':'好价','article_title':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','article_id':'28308907','channel':'youhui','channel_id':'1','brand':'Apple/苹果','mall_name':'天猫精选','cate_level1':'电脑数码','position':'1'});dataLayer.push({'event':'1340005','tab':'好价','position':'1','pagetitle':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','商城':'天猫精选','频道':'youhui'})">
                    <img src="//y.zdmimg.com/202012/10/5fceed30641da9529.jpg_d200.jpg" alt="21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB">
                </a>
            </div>
            <div class="z-feed-content ">
                <h5 class="feed-block-title">
                    <a href="https://www.smzdm.com/p/28308907/" target="_blank" onclick="sensors.track('FeedArticleClick', {'business':'百科','sub_business':'分类','feed_name':'品类页feed流','tab1_name':'好价','article_title':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','article_id':'28308907','channel':'youhui','channel_id':'1','brand':'Apple/苹果','mall_name':'天猫精选','cate_level1':'电脑数码','position':'1'});dataLayer.push({'event':'1340005','tab':'好价','position':'1','pagetitle':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','商城':'天猫精选','频道':'youhui'})">21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB</a>
                </h5>
                <div class="z-highlight" _hover-ignore="1">
                    <a href="https://www.smzdm.com/p/28308907/" target="_blank" class="z-highlight " onclick="sensors.track('FeedArticleClick', {'business':'百科','sub_business':'分类','feed_name':'品类页feed流','tab1_name':'好价','article_title':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','article_id':'28308907','channel':'youhui','channel_id':'1','brand':'Apple/苹果','mall_name':'天猫精选','cate_level1':'电脑数码','position':'1'});dataLayer.push({'event':'1340005','tab':'好价','position':'1','pagetitle':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','商城':'天猫精选','频道':'youhui'})" _hover-ignore="1">
                            8999元包邮（赠Apple Care+服务）</a>
                </div>
                    <!-- feed-block-info tag栏 一级标签额外添加class tag-level1 -->
                    <!-- 如果没有标签，不渲染该结构 -->
                    <!-- 有落地页的tag用a标签，没有落地页的用i标签，参照以下结构 -->
                <div class="feed-block-info">
                    <span class="feed-block-tags">
                        <i class="">手机通讯热度Top1</i>
                    </span>
                </div>
                <div class="feed-block-descripe" _hover-ignore="1">类微云台结构，相机传感器每秒进行5000次位移微调整iPhone 12 Pro Max采用不锈钢机身材质，在磁控涂层工艺下不锈钢呈现出精致的亮金色外观。iPho...                            
                    <a href="https://www.smzdm.com/p/28308907/" target="_blank" onclick="sensors.track('FeedArticleClick', {'business':'百科','sub_business':'分类','feed_name':'品类页feed流','tab1_name':'好价','article_title':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','article_id':'28308907','channel':'youhui','channel_id':'1','brand':'Apple/苹果','mall_name':'天猫精选','cate_level1':'电脑数码','position':'1'});dataLayer.push({'event':'1340005','tab':'好价','position':'1','pagetitle':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','商城':'天猫精选','频道':'youhui'})">
                                阅读全文
                    </a>
                </div>
                <div class="z-feed-foot">
                    <div class="z-feed-foot-l">
                        <span class="feed-btn-group">
					        <a href="javascript:;" class="J_zhi_like_fav price-btn-up" data-channel="3" data-article="28308907" data-type="zhi" data-zhi-type="1">
					            <span class="unvoted-wrap">
                                    <i class="icon-zhi-o-thin" _hover-ignore="1"></i>
                                    <span _hover-ignore="1">505</span>
					            </span>
					            <span class="voted-wrap">
					                已打分
					            </span>
					            <span class="one-plus">+1</span>
					       </a>
					       <a href="javascript:;" class="J_zhi_like_fav price-btn-down" data-channel="3" data-article="28308907" data-type="zhi" data-zhi-type="-1" _hover-ignore="1">
					            <span class="unvoted-wrap">
                                    <i class="icon-buzhi-o-thin"></i>
                                    	<span>51</span>
					            </span>
					            <span class="voted-wrap">
					                已打分
					            </span>
					            <span class="one-plus">+1</span>
					       </a>
                        </span>
                        <a href="javascript:;" class="J_zhi_like_fav z-group-data" title="收藏数 368" data-channel="3" data-article="28308907" data-type="fav" data-severs="收藏">
                            <i class="icon-star-o-thin" _hover-ignore="1"></i>
                            <span _hover-ignore="1">368</span>
                        </a>
                        <a href="https://www.smzdm.com/p/28308907/#comments" target="_blank" class="z-group-data" title="评论数 237" onclick="sensors.track('FeedArticleClick', {'business':'百科','sub_business':'分类','feed_name':'品类页feed流','tab1_name':'好价','article_title':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','article_id':'28308907','channel':'youhui','channel_id':'1','brand':'Apple/苹果','mall_name':'天猫精选','cate_level1':'电脑数码','position':'1'});dataLayer.push({'event':'1340005','tab':'好价','position':'1','pagetitle':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','商城':'天猫精选','频道':'youhui'})" _hover-ignore="1">
                            <i class="icon-comment-o-thin"></i>
                            <span _hover-ignore="1">237</span>
                        </a>
                    </div>
                    <div class="z-feed-foot-r">
                        <!-- 单链接 -->
                        <div class="feed-link-btn">
                            <div class="feed-link-btn-inner">
                                <a class="z-btn z-btn-red" href="https://go.smzdm.com/8feea55389fd2e4e/ca_aa_yh_163_28308907_11800_0_165_0" target="_blank" rel="nofollow" onclick="sensors.track('FeedArticleClick', {'business':'百科','sub_business':'分类','feed_name':'品类页feed流','tab1_name':'好价','article_title':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','article_id':'28308907','channel':'youhui','channel_id':'1','brand':'Apple/苹果','mall_name':'天猫精选','cate_level1':'电脑数码','position':'1'});dataLayer.push({'event':'1340005','tab':'好价','position':'1','pagetitle':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','商城':'天猫精选','频道':'youhui'});gtmAddToCart({'name':'21日0点 : Apple 苹果 iPhone 12 Pro Max 5G智能手机 128GB','id':'28308907' , 'price':'8999','brand':'Apple/苹果' ,'mall':'天猫精选', 'category':'电脑数码/手机通讯/手机/iPhone','metric1':'8999','dimension10':'tmall.com','dimension9':'youhui','channel_id':'1','cate_level1':'电脑数码','dimension11':'9阶价格','dimension20':'无','dimension32':'','dimension34':'1731303','dimension25':'0','dimension39':'直达链接','dimension58':'无','dimension49':'无','dimension64':'pinlei','cd64':'pinlei','dimension96':'无','dimension99':'无'})">去购买<i class="icon-angle-right-o-thin"></i></a>
                            </div>
                        </div>
					    <span class="feed-block-extras">22小时前					     													<a href="https://www.smzdm.com/mall/tmall/" class="mall" target="_blank">天猫精选</a>
						</span>
                    </div>
                </div>
            </div>
        </div>
    </li>
</ul>
```
通过使用xpath获取什么值得买的产品ID、名称、值得、不值得等数据

```
# 获取什么值得买ID
//*[@id="feed-main-list"]/li/@articleid

# 获取产品名称
//*[@id="feed-main-list"]/li/div/div[2]/h5/a/text()

......
```

###### 同理，分析评论页面的HTML结构，可以获取产品的评论信息

```
<li class="comment_list" id="li_comment_179557298" itemprop="review" itemscope="" itemtype="http://schema.org/Review">
    <div class="comment_avatar">
        <div class="user-box-new">
            <a class="user-avatar" href="https://zhiyou.smzdm.com/member/2379300877/" target="_blank">
                <img class="avatar-img" src="https://avatarimg.smzdm.com/default/2379300877/56cc245e6bdea-small.jpg">
            </a>
        </div>
        <span class="grey">238楼</span>
    </div>
    <div class="comment_conBox">
        <div class="comment_avatar_time ">
            <div class="time"><meta itemprop="datePublished" content="2020-12-20">15分钟前</div>
            <a class="a_underline user_name" target="_blank" href="https://zhiyou.smzdm.com/member/2379300877/" usmzdmid="2379300877"><span itemprop="author">fyyd969</span></a>                                                                    
            <div class="rank face-stuff-level">
            	<a href="https://zhiyou.smzdm.com/user/tequan/" target="_blank">
            		<img src="https://res.smzdm.com/h5/h5_user/dist/assets/level/6.png?v=1">
            	</a>
           	</div>
           	<div class="icon-medal">
           		<a title="值场高手" href="https://zhiyou.smzdm.com/user/tequan/" target="_blank"> 
           			<img src="https://eimg.smzdm.com/202007/21/5f16988e728dd8660.png" alt="值场高手"> 
           		</a> 
           	</div>                            
        </div>                                                                           
        <div class="comment_conWrap">
            <div class="comment_con">
                <input class="content-hidden" type="hidden" comment-id="179557298" value="0">
                <p class="p_content_179557298">
                	<span itemprop="description">我想问 apple care 买完了 可以快到期要求换个电池么？ </span>
                </p>
            </div>
            <div class="comment_action">
                <span class="come_from">来自 <a target="_blank" href="https://www.smzdm.com/push/">iPhone 客户端</a></span>
                <a class="jubao" href="javascript:void(0);" id="report_179557298" style="display:inline-block">举报</a>
                <a class="dingNum " href="javascript:void(0);" id="cdc_support_179557298" onclick="return comment_rating_ajax(3, 1, 179557298, 28308907, 179557298);">顶<span>(0)</span></a>
                <a class="caiNum" href="javascript:void(0);" id="cdc_oppose_179557298" onclick="return comment_rating_ajax(3, 0, 179557298, 28308907, 179557298);">踩<span>(0)</span></a>
                <a class="atta" href="javascript:void(0);" title="@fyyd969">@TA</a>                                    
                <a class="reply" href="javascript:void(0);" id="cdc_reply_179557298">回复</a>
            </div>
            <div class="blankDiv"></div>
        </div>
    </div>
    <div class="clear"></div>
</li>

<li class="comment_list" id="li_comment_179557172" itemprop="review" itemscope="" itemtype="http://schema.org/Review">
    <div class="comment_avatar">
        <div class="user-box-new">
            <a class="user-avatar" href="https://zhiyou.smzdm.com/member/2379300877/" target="_blank">
                <img class="avatar-img" src="https://avatarimg.smzdm.com/default/2379300877/56cc245e6bdea-small.jpg">
            </a>
        </div>
        <span class="grey">237楼</span>
	</div>
    <div class="comment_conBox">
	    <div class="comment_avatar_time ">
	        <div class="time"><meta itemprop="datePublished" content="2020-12-20">17分钟前</div>
            <a class="a_underline user_name" target="_blank" href="https://zhiyou.smzdm.com/member/2379300877/" usmzdmid="2379300877"><span itemprop="author">fyyd969</span></a>                                                                    
            <div class="rank face-stuff-level">
            	<a href="https://zhiyou.smzdm.com/user/tequan/" target="_blank">
            		<img src="https://res.smzdm.com/h5/h5_user/dist/assets/level/6.png?v=1">
            	</a>
            </div>
            <div class="icon-medal"><a title="值场高手" href="https://zhiyou.smzdm.com/user/tequan/" target="_blank"> 
            	<img src="https://eimg.smzdm.com/202007/21/5f16988e728dd8660.png" alt="值场高手"> </a> 
            </div>                            
        </div>
        <div class="blockquote_wrap">
            <blockquote class="comment_blockquote" blockquote_cid="179493290">
	            <div class="comment_floor">1</div>
	            <div class="comment_conWrap">
	                <div class="comment_con">
	                    <input class="content-hidden" type="hidden" comment-id="179493290" value="0">
	                    <a class="a_underline user_name" target="_blank" href="https://zhiyou.smzdm.com/member/2631975265/" usmzdmid="2631975265"><span itemprop="author">佛手中的鸟</span></a>
	                    ：<p class="p_content_179493290"><span itemprop="description">只是一年的AC 就是多了两次意外保修 </span></p>
	                </div>
	                <a href="javascript:void(0);" class="seaAll" style="display:none;">查看全部</a>
	                <div class="comment_action" style="visibility: hidden;">
	                    <a class="jubao" href="javascript:void(0);" id="report_179493290" style="display:inline-block">举报</a>
	                    <a class="dingNum current" href="javascript:void(0);" id="cdc_support_179493290" onclick="return comment_rating_ajax(3, 1, 179493290, 28308907, 179557172);">顶<span>(5)</span></a>
	                    <a class="caiNum" href="javascript:void(0);" id="cdc_oppose_179493290" onclick="return comment_rating_ajax(3, 0, 179493290, 28308907, 179557172);">踩<span>(0)</span></a>
	                    <a class="atta" href="javascript:void(0);" title="@佛手中的鸟">@TA</a>                                            
	                    <a class="reply" href="javascript:void(0);" id="cdc_reply_179493290">回复</a>
	                </div>
	                <div class="blankDiv"></div>
	            </div>
	        </blockquote>
            <blockquote class="comment_blockquote" blockquote_cid="179530680">
	            <div class="comment_floor">2</div>
	            <div class="comment_conWrap">
	                <div class="comment_con">
	                    <input class="content-hidden" type="hidden" comment-id="179530680" value="0">
                        <a class="a_underline user_name" target="_blank" href="https://zhiyou.smzdm.com/member/4569053563/" usmzdmid="4569053563"><span itemprop="author">ID180天修改一次</span></a>
                        ：<p class="p_content_179530680"><span itemprop="description">主要是换手机之前换新一下能卖个好价钱，每天可以放心裸奔 </span></p>
                	</div>
                	<a href="javascript:void(0);" class="seaAll" style="display:none;">查看全部</a>
                	<div class="comment_action" style="visibility: hidden;">
                    	<a class="jubao" href="javascript:void(0);" id="report_179530680" style="display:inline-block">举报</a>
                    	<a class="dingNum current" href="javascript:void(0);" id="cdc_support_179530680" onclick="return comment_rating_ajax(3, 1, 179530680, 28308907, 179557172);">顶<span>(1)</span></a>
                    	<a class="caiNum" href="javascript:void(0);" id="cdc_oppose_179530680" onclick="return comment_rating_ajax(3, 0, 179530680, 28308907, 179557172);">踩<span>(0)</span></a>
                    	<a class="atta" href="javascript:void(0);" title="@ID180天修改一次">@TA</a>                                            <a class="reply" href="javascript:void(0);" id="cdc_reply_179530680">回复</a>
                	</div>
                	<div class="blankDiv"></div>
            	</div>
        	</blockquote>
        </div>                       
        <div class="comment_conWrap">
        	<div class="comment_con">
            	<input class="content-hidden" type="hidden" comment-id="179557172" value="0">
            	<p class="p_content_179557172"><span itemprop="description">680换新你换全新能比保护好的二手多卖680才值 </span></p>
        	</div>
        	<div class="comment_action">
                <span class="come_from">来自 <a target="_blank" href="https://www.smzdm.com/push/">iPhone 客户端</a></span>
                <a class="jubao" href="javascript:void(0);" id="report_179557172" style="display:inline-block">举报</a>
            	<a class="dingNum " href="javascript:void(0);" id="cdc_support_179557172" onclick="return comment_rating_ajax(3, 1, 179557172, 28308907, 179557172);">顶<span>(0)</span></a>
            	<a class="caiNum" href="javascript:void(0);" id="cdc_oppose_179557172" onclick="return comment_rating_ajax(3, 0, 179557172, 28308907, 179557172);">踩<span>(0)</span></a>
            	<a class="atta" href="javascript:void(0);" title="@fyyd969">@TA</a>                                    <a class="reply" href="javascript:void(0);" id="cdc_reply_179557172">回复</a>
        	</div>
        	<div class="blankDiv"></div>
    	</div>
    </div>
    <div class="clear"></div>
</li>
```

###### 最后基本实现了以下功能
- 正确使用 Scrapy 框架获取评论，如果评论有多页，需实现自动翻页功能。
- 评论内容能够正确存储到 MySQL 数据库中，不因表结构不合理出现数据截断情况。
数据清洗后，再次存储的数据不应出现缺失值。
- Django 能够正确运行，并展示采集到的数据，数据不应该有乱码、缺失等问题。
- 在 Django 上采用图表方式展示数据分类情况。
- 舆情分析的结果存入到 MySQL 数据库中。
- 在 Django 上采用图表方式展示舆情分析的结果。
- 可以在 Web 界面根据关键字或关键词进行搜索，并能够在页面展示正确的搜索结果。
- 支持按照时间（录入时间或评论时间）进行搜索，并能够在页面展示正确的搜索结果。
- 符合 PEP8 代码规范，函数、模块之间的调用高内聚低耦合，具有良好的扩展性和可读性。