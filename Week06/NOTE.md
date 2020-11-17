## 面向对象编程
面向对象编程——Object Oriented Programming，简称OOP，是一种程序设计思想。OOP把对象作为程序的基本单元，是一个数据以及相关行为的集合

### 属性
面向对象最重要的概念就是类（Class）和实例（Instance），必须牢记类是抽象的模板（一般由class关键字定义），而实例是根据类创建出来的一个个具体的“对象”，每个对象都拥有相同的方法，但各自的数据可能不同。通过obj__dict__和dir(obj)查看类/对象的成员属性方法等。类名通常是大写开头的单词。

```
class Human(object):
    # 静态字段
    live = True

    def __init__(self, name):
        # 普通字段
        self.name = name
        
man = Human('Adam')
woman = Human('Eve')

# 有静态字段live属性，无name属性
Human.__dict__
# 有普通字段name属性，无live属性
man.__dict__

# 设置普通字段有live变量，注意Human.live的属性不变，还是True
man.live = False

del man.live
```


**类属性与对象属性区别：**
- 类属性字段在内存中只保存一份
- 对象属性在每个对象都保存一份
###### 原因在于：类中的属性为静态字段。如上代码所示

#### 属性作用域
- _name 人为约定不可修改
- __name 私有属性
- __name__ 魔术方法(前后各有双下划线，Markdown不能正确显示前后双划线)

### 方法
三种方法（三种方法在内存中都归属于类
）：
- 普通方法 至少一个 self 参数，表示该方法的对象
- 类方法 至少一个 cls 参数，表示该方法的类
- 静态方法 由类调用，无参数

```
class Foo(object):
    def instance_method(self):
        pass
        
    @classmethod
    def class_method(cls):
        pass
        
    @staticmethod
    def static_method():
        pass
```

##### 几个有用的魔术方法（双下划线开头和结尾的方法）：
- __ init__()， 实例化对象的初始化方法,不需要显式返回，默认为 None，否则会在运行时抛出 TypeError；
- __ getattribute__()， 对所有属性的访问都会调用该方法；
- __ getattr__()，对实例属性进行获取拦截，适用于未定义的属性
- __ new__()， 是实例创建之前被调用，返回该实例对象，是静态方法
- __ call__(), 当把对象当做函数调用，会调用此方法
- __ str__(), 自定义设置返回的字符串，打印类的时候显示
- __ repr__()，为调试服务的，返回程序开发者看到的字符串，这样赋值后__ repr__ = __ str__后，调试模式也显示__ str__()设置的字符串
##### 利用__ str__(), __ getattr__(), __ repr__()可以很轻松一个链式调取方法

```
def Chain(boject):
    def __init__(self, path=''):
        self._path = path
    
    def __getattr__(self, path):
        return Chain('{}/{}'.format(self._path, path))
        
    def __str__(self):
        return self._path
    
    __repr__ = __str__

Chain().tmall.order.list

# /tmall/order/list
```


### 属性描述符 property
描述符：实现特定协议的类。property 类需要实现 __ get__、__ set__、 __ delete__ 方法。
Django中 的 property：site-packages/django/db/models/base.py

```
class Model(metaclass=ModelBase):
    def _get_pk_val(self, meta=None):
        meta = meta or self._meta
        return getattr(self, meta.pk.attname)
    def _set_pk_val(self, value):
        return setattr(self, self._meta.pk.attname, value)
        
    pk = property(_get_pk_val, _set_pk_val)
```

### 面向对象编程的特性
封装
- 将内容封装到某处
- 从某处调用被封装的内容

继承
- 基本继承
- 多重继承

重载
- Python 无法在语法层面实现数据类型重载，需要在代码逻辑上实现
- Python 可以实现参数个数重载

多态
- Pyhon 不支持 Java 和 C# 这一类强类型语言中多态的写法
- Python 使用“鸭子类型”

#### 新式类
新式类和经典类的区别：当前类或者父类继承了 object 类，那么该类便是新式类，否则便是经典类。
##### object 和 type 的关系
- object 和 type 都属于 type 类 (class 'type')
- type 类由 type 元类自身创建的。object 类是由元类 type 创建
- object 的父类为空，没有继承任何类
- type 的父类为 object 类 (class 'object')

#### 类的继承
- 单一继承
- 多重继承
- 菱形继承（钻石继承）
- 继承机制 MRO
- MRO 的 C3 算法

##### 多重继承的顺序问题
有向无环图：DAG(Directed Acyclic Graph)
- DAG 原本是一种数据结构，因为 DAG 的拓扑结构带来的优异特性，经常被用于处理动态规划、寻求最短路径的场景。

### SOLID 设计原则
- 单一责任原则 The Single Responsibility Principle
- 开放封闭原则 The Open Closed Principle
- 里氏替换原则 The Liskov Substitution Principle
- 依赖倒置原则 The Dependency Inversion Principle
- 接口分离原则 The Interface Segregation Principle

#### 设计模式
- 设计模式用于解决普遍性问题
- 设计模式保证结构的完整性

#### 单例模式
1、对象只存在一个实例

2、__ init__() 和 __ new__() 的区别：
- __ new__ 是实例创建之前被调用，返回该实例对象，是静态方法
- __ init__ 是实例对象创建完成后被调用，是实例方法
- __ new__ 先被调用，__init__ 后被调用
- __ new__ 的返回值（实例）将传递给 __ init__ 方法的第一个参数，__ init__ 给这个
实例设置相关参数

#### 元类
- 元类是关于类的类，是类的模板。
- 元类是用来控制如何创建类的，正如类是创建对象的模板一样。
- 元类的实例为类，正如类的实例为对象
- 创建元类的两种方法

1、class
2、type：type（类名，父类的元组（根据继承的需要，可以为空，包含属性的字典（名字和值））
 
#### 抽象基类
- 抽象基类（abstract base class，ABC）用来确保派生类实现了基类中的特定方法。
- 使用抽象基类的好处：1、避免继承错误，使类层次易于理解和维护；2、无法实例化基类；3、如果忘记在其中一个子类中实现接口方法，要尽早报错。

```
from abc import ABCMeta, abstractmethod
class Base(metaclass=ABCMeta):
    @abstractmethod
    def foo(self):
        pass
    @abstractmethod
    def bar(self):
        pass

class Concrete(Base):
    def foo(self):
        pass

c = Concrete() # TypeError
```

#### Mixin 模式
在程序运行过程中，重定义类的继承，即动态继承。
- 可以在不修改任何源代码的情况下，对已有类进行扩展
- 进行组件的划分

几个有用的函数方法：
- isinstance(instance, obj)：判断一个变量(instance)是否是某个类型(obj)
- type(instance)：获取对象类型。通过type(instance).__ name__可以获取对象名字或者通过instance.__ class__.__ name__获取
- getattr(instance, property)：获取对象(instance)的属性(property)
- setattr(instance, property, value):设置对象(instance)的属性(property)
- hasattr(instance, property)：判断对象(instance)是否存在属性(property)
