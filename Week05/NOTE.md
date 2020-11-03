## 第五周-第六周学习笔记

### Django
- 采⽤了 MTV 的框架
- 强调快速开发和代码复⽤ DRY (Do Not Repeat Yourself)
- 组件丰富：
  ###### ORM (对象关系映射) 映射类来构建数据模型；
  ###### URL 支持正则表达式；
  ###### 模板可继承；
  ###### 内置用户认证 ，提供用户认证和权限功能；
  ###### admin 管理系统；
  ###### 内置表单模型、Cache 缓存系统、国际化系统等。

### 创建 Django 项目

##### 使用django-admin startproject命令行创建项目

```
# 创建一个名为mysite的项目
django-admin startproject mysite
```
注意事项：避免使用 Python 或 Django 的内部保留字来命名你的项目。具体地说，避免使用像 django (会和 Django 自己产生冲突)或 test (会和 Python 的内置组件产生冲突)这样的名字。

##### 项目目录结构
```
mysite/
    manage.py
    mysite/
        __init__.py
        settings.py
        urls.py
        wsgi.py
```
- 最外层的 mysite/ 根目录只是你项目的容器， Django不关心它的名字，你可以将它重命名为任何你喜欢的名字。
- manage.py: 一个让你用各种方式管理 Django 项目的命令行工具。你可以阅读 django-admin and manage.py 获取所有 manage.py 的细节。
- 里面一层的 mysite/ 目录包含你的项目，它是一个纯 Python 包。它的名字就是当你引用它内部任何东西时需要用到的 Python 包名。 (比如 mysite.urls).
- mysite/__init__.py：一个空文件，告诉 Python 这个目录应该被认为是一个 Python 包。如果你是 Python 初学者，阅读官方文档中的 更多关于包的知识。
- mysite/settings.py：Django 项目的配置文件。如果你想知道这个文件是如何工作的，请查看 Django 配置 了解细节。
- mysite/urls.py：Django 项目的 URL 声明，就像你网站的“目录”。阅读 URL调度器 文档来获取更多关于 URL 的内容。
mysite/wsgi.py：作为你的项目的运行在 WSGI 兼容的Web服务器上的入口。阅读 如何使用 WSGI 进行部署 了解更多细节。

##### 启动项目命令
```
python manage.py runserver
```
默认情况下，runserver 命令会将服务器设置为监听本机内部 IP 的 8000 端口。如果想更换服务器的监听端口，请使用命令行参数。举个例子，下面的命令会使服务器监听 8080 端口：

```
python manage.py runserver 8080
```

##### Django 的配置文件
配置文件包括：
- 项目路径

```
# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
```

- 密钥

```
# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '-*l36*u9&m3qcv^k_7+x$$!bn2i1=sn-af*mde(vtu9=szrrw9'
```
 
- 域名访问权限

```
ALLOWED_HOSTS = []
```

- App 列表

```
# Application definition

INSTALLED_APPS = [
    'movies.apps.MoviesConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

- 静态资源，包括 CSS、JavaScript 图片等

```
# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/2.2/howto/static-files/

STATIC_URL = '/static/'
```

- 模板文件

```
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

- 数据库配置

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'douban',
        'USER': 'root',
        'PASSWORD': 'password',
        'HOST': '127.0.0.1',
        'PORT': '3306',
    }

    # 'default': {
    #     'ENGINE': 'django.db.backends.sqlite3',
    #     'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    # }
}
```

- 缓存

```
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': [
            '172.19.26.240:11211',
            '172.19.26.242:11211',
        ]
    }
}
```

- 中间件

```
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```


##### 创建 Django 应用程序
应用可以存放在任何 Python path 中定义的路径。利用manage.py startapp  命令能够在同级目录下创建投票应用。这样它就可以作为顶级模块导入，而不是 mysite 的子模块。
```
# 创建一名为index的应用程序
python manage.py startapp index
```
上述命令将创建一个 index 目录，它的目录结构大致如下：

```
index/
    __init__.py
    admin.py
    apps.py
    migrations/
        __init__.py
    models.py
    tests.py
    views.py
```
- index/migrations 数据库迁移文件夹
- index/models.py 模型
- index/apps.py 当前 app 配置文件
- index/admin.py 管理后台
- index/tests.py 自动化测试
- index/views.py 视图

#### 带变量的 URL
Django 支持对 URL 设置变量, URL 变量类型包括：
- str
- int
- slug
- uuid
- path

```
# 下面path会将传入的int参数，赋值给year,并传给views文件里面的myyear方法
path('<int:year>', views.myyear),
```

URL 支持正则表达式

```
# urls.py
re_path('(?P<year>[0-9]{4}).html', views.myyear, name='urlyear’),
```

```
# views.py
def myyear(request, year):
return render(request, 'yearview.html')
```

```
# Templates 文件夹增加 yearview.html
# 注意url 后面的 ‘urlyear’ 和 urls.py中的path对应
<a href="{% url 'urlyear' 2020 %}">2020 booklist</a></div>
```

#### view 视图
响应类型 | 说明
---|---
HttpResponse(‘Hello world’) | HTTP 状态码 200，请求已成功被服务器接收
HttpResponseRedirect(‘/admin/’) | HTTP 状态码 302，重定向 Admin 站点的 URL
HttpResponsePermanentRedirect(‘/admin/’) | HTTP 状态码 301，永久重定向 Admin 站点URL
HttpResponseBadRequest(‘BadRequest’) | HTTP 状态码 400，访问的页面不存在或者请求错误
HttpResponseNotFound(‘NotFound’) | HTTP 状态码 404，页面不存在或者网页的 URL 失效
HttpResponseForbidden(‘NotFound’) | HTTP 状态码 403，没有访问权限
HttpResponseNotAllowed(‘NotAllowedGet’) | HTTP 状态码 405，不允许使用该请求方式
HttpResponseSeverError(‘SeverError’) | HTTP 状态码 500，服务器内容错误

#### 基于类的视图
在视图函数里处理 HTTP GET 的代码应该像下面这样：

```
from django.http import HttpResponse

def my_view(request):
    if request.method == 'GET':
    # <view logic>
    return HttpResponse('result')
```
而在基于类的视图里，会变成：

```
from django.http import HttpResponse
from django.views import View

class MyView(View):
    def get(self, request):
        # <view logic>
        return HttpResponse('result’)
```

#### 模型与数据库
- 每个模型都是一个 Python 的类，这些类继承 django.db.models.Model
- 模型类的每个属性都相当于一个数据库的字段
- 利用这些，Django 提供了一个自动生成访问数据库的 API

```
from django.db import models

class Person(models.Model):
    id = models.IntegerField(primary_key=True)
    first_name = models.CharField(max_length=30)
    last_name = models.CharField(max_length=30)

# 对应 SQL
CREATE TABLE myapp_person (
"id" serial NOT NULL PRIMARY KEY,
"first_name" varchar(30) NOT NULL,
"last_name" varchar(30) NOT NULL
);
```
通过运行 makemigrations 和 migrate

```
# 生成sql对应的文件
python manage.py makemigrations

# 连接数据库创建数据库表
python manage.py migrate
```
##### 字段
- 字段类型：模型中每一个字段都应该是某个 Field 类的实例
- 字段选项：每一种字段都需要指定一些特定的参数
- 参考：https://docs.djangoproject.com/zh-hans/2.2/topics/db/models/

##### 关联关系
- 多对一（ForeignKey）
- 多对多（ManyToManyField）会生成对应的中间表
- 一对一（OneToOneField）

##### 执行查询常见方法
- save()
- add()
- all()
- filter()
- get()

### 几个有用的函数

#### 一、include()

- 函数 include() 允许引用其它 URLconfs。每当 Django 遇到 include() 时，它会截断与此项匹配的 URL 的部分，并将剩余的字符串发送到 URLconf 以供进一步处理。
- 当包括其它 URL 模式时应该总是使用 include() ， admin.site.urls 是唯一例外。

```
# 文件：mysite/urls.py

from django.contrib import admin
from django.urls import include, path

urlpatterns = [
    path('index/', include('index.urls')),
    path('admin/', admin.site.urls),
]
```

#### 二、path()
函数 path() 具有四个参数，两个必须参数：route和view，两个可选参数：kwargs 和 name。

- **path() 参数： route**

route 是一个匹配 URL 的准则（类似正则表达式）。当 Django 响应一个请求时，它会从 urlpatterns 的第一项开始，按顺序依次匹配列表中的项，直到找到匹配的项。这些准则不会匹配 GET 和 POST 参数或域名。例如，URLconf 在处理请求 https://www.example.com/myapp/ 时，它会尝试匹配 myapp/ 。处理请求 https://www.example.com/myapp/?page=3 时，也只会尝试匹配 myapp/。

---

- **path() 参数： view**

当 Django 找到了一个匹配的准则，就会调用这个特定的视图函数，并传入一个 HttpRequest 对象作为第一个参数，被“捕获”的参数以关键字参数的形式传入。稍后，我们会给出一个例子。

---

- **path() 参数： kwargs**

任意个关键字参数可以作为一个字典传递给目标视图函数。

---

- **path() 参数： name**
为了 URL 取名能使在 Django 的任意地方唯一地引用它，尤其是在模板中。这个有用的特性允许只改一个文件就能全局地修改某个 URL 模式。


#### render()
将给定的模板与给定的上下⽂字典组合在⼀起，并以渲染的⽂本返回⼀个
HttpResponse 对象。

```
# 不用render函数时，正常是下面调用方式：
from django.http import HttpResponse
from django.template import loader

from .models import Question

def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    template = loader.get_template('polls/index.html')
    context = {
        'latest_question_list': latest_question_list,
    }
    return HttpResponse(template.render(context, request))
```

```
# 使用render函数，不再需要导入 loader 和 HttpResponse
from django.shortcuts import render
from .models import Question

def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    context = {'latest_question_list': latest_question_list}
    return render(request, 'polls/index.html', context)
```
#### redirect()
将⼀个 HttpResponseRedirect 返回到传递的参数的适当URL。

#### get_object_or_404()
尝试用 get() 函数获取一个对象，如果不存在就抛出 Http404 错误也是一个普遍的流程。

使用辅助函数 get_object_or_404() 而不是自己捕获 ObjectDoesNotExist 异常呢？还有，为什么模型 API 不直接抛出 ObjectDoesNotExist 而是抛出 Http404 呢？

因为这样做会增加模型层和视图层的耦合性。指导 Django 设计的最重要的思想之一就是要保证松散耦合。一些受控的耦合将会被包含在 django.shortcuts 模块中。
