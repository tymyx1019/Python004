## 第四周学习笔记

### pandas简介
Pandas是一个强大的分析结构化数据的工具集；它的使用基础是Numpy（提供高性能的矩阵运算）；用于数据挖掘和数据分析，同时也提供数据清洗功能。

#### 几个有用的参考文档
- pandas 中文文档：https://www.pypandas.cn/
- sklearn-pandas安装参考文档：https://pypi.org/project/sklearn-pandas/1.5.0/
- Numpy 学习文档：https://numpy.org/doc/
- matplotlib 学习文档：https://matplotlib.org/contents.html

### pandas两种数据类型
包含Series和DataFrame两种

#### Series
它是一种类似于一维数组的对象（一列数据），是由一组数据(各种NumPy数据类型)以及一组与之相关的数据标签(即索引)组成。仅由一组数据也可产生简单的Series对象。

##### 从列表创建Series

```
pd.Series(['a', 'b', 'c'])
0    a
1    b
2    c
```
上面没有指定索引，因此会自动创建索引,如上所示的0,1,2

###### 通过字典创建带索引的Series

```
s1 = pd.Series({'a':11, 'b':22, 'c':33})
```

###### 通过关键字创建带索引的Series

```
s2 = pd.Series([11, 22, 33], index = ['a', 'b', 'c'])
```
###### 获取全部索引:

```
s1.index
#获取值为：Index(['a', 'b', 'c'], dtype='object')
```
###### 获取全部值

```
s1.values
#array([11, 22, 33], dtype=int64)
```
###### 获取类型

```
type(s1.values)
#<class 'numpy.ndarray'>
```
###### 转换为列表

```
s1.values.tolist()
#[11, 22, 33]
```
##### 使用index会提升查询性能
- 如果index唯一，pandas会使用哈希表优化，查询性能为O(1)
- 如果index有序不唯一，pandas会使用二分查找算法，查询性能为O(logN)
- 如果index完全随机，每次查询都要扫全表，查询性能为O(N)


#### DataFrame
DataFrame是Pandas中的一个表格型的数据结构，包含有一组有序的列，每列可以是不同的值类型(数值、字符串、布尔型等)，DataFrame即有行索引也有列索引，可以被看做是由Series组成的字典。DataFrame 是最常用的 Pandas 对象。数据创建方式主要有：
- 用多维数组字典、列表字典生成 DataFrame
- 用列表字典生成 DataFrame
- 用元组字典生成 DataFrame
- 导入csv、excel表格数据
- 导入数据库数据（SQL）
- Pickling、JOSN、HTML等其他

##### 用多维数组字典、列表字典生成 DataFrame

```
df = pd.DataFrame([
                     ['a', 'b'], 
                     ['c', 'd']
                    ])
# 得到数据结构如下
#    0  1
# 0  a  b
# 1  c  d
```
###### 自定义列索引

```
df.columns= ['one', 'two']
```
###### 自定义行索引

```
df.index = ['first', 'second']
```
##### 可以在创建时直接指定 DataFrame([...] , columns='...', index='...' )

```
df = pd.DataFrame([[1,2],[3,4]], columns=['a','b'], index=['first','second'])

#得到的数据如下
#         a  b
# first   1  2
# second  3  4
```

##### 导入csv、excel表格数据生成DataFrame数据

主要通过调用read_excel、read_csv方法
```
excel = pd.read_excel('1.xlsx')
df = pd.read_csv('1.csv',sep=',', nrows=10, encoding='utf-8')
```

##### 导入数据库数据

指定数据库连接资源和SQL语句,通过read_sql方法调用

```
import pymysql
sql  =  'SELECT *  FROM mytable'
conn = pymysql.connect('ip','name','pass','dbname','charset=utf8')
df = pd.read_sql(sql,conn)
```
#### 几个有用的方法
- 显示前3行: df.head(3)
- 显示后3行：df.tail(3)
- 显示行列数量：df.shape, 返回类似元组：(20, 3)
- 显示详细信息: 调用 info() 

```
调用：df.info()

<class 'pandas.core.frame.DataFrame'>
RangeIndex: 20 entries, 0 to 19
Data columns (total 3 columns):
 #   Column    Non-Null Count  Dtype
---  ------    --------------  -----
 0   id        20 non-null     int64
 1   age       20 non-null     int64
 2   order_id  20 non-null     int64
dtypes: int64(3)
```
- 快速查看数据的统计摘要df.describe()
```
调用：df.describe()

             id        age     order_id
count  20.00000  20.000000     20.00000
mean   10.50000  37.650000   3147.20000
std     5.91608  24.547001   9003.57852
min     1.00000   4.000000      6.00000
25%     5.75000  19.500000     23.00000
50%    10.50000  34.000000     55.50000
75%    15.25000  54.500000     69.25000
max    20.00000  89.000000  34345.00000
```

- 转置数据: df.T

```
          0   1     2   3   4   5   6   ...   13  14     15  16  17  18  19
id         1   2     3   4   5   6   7  ...   14  15     16  17  18  19  20
age       12  23    43  48  12  34  89  ...   23  54     22  56  32  34  75
order_id  22  34  4343  12  11   6  67  ...  343  65  23232  23  23  66  54

[3 rows x 20 columns]
```
- 按值排序：df.sort_values(by=['age','order_id'], ascending=True),ascending为True为升序，False降序排列。里面有inplace参数，如果为True，则代替原来的数据。多列排序：df.sort_values ( by = ['age','order_id'] ,ascending = [True,False])

```
    id  age  order_id
8    9    4        66
7    8    5        76
4    5   12        11
0    1   12        22
12  13   12     34345
15  16   22     23232
1    2   23        34
13  14   23       343
17  18   32        23
5    6   34         6
18  19   34        66
2    3   43      4343
9   10   44        57
3    4   48        12
14  15   54        65
16  17   56        23
11  12   56        45
10  11   75        54
19  20   75        54
6    7   89        67
```

- 查看缺失值汇总: df.isnull().sum()

```
A    1
B    1
C    0
D    1
dtype: int64
```
- 填充缺失值:用前一行填充,用前一列填充

```
df.ffill()        # 用前一行填充
df.ffill(axis=1)  # 用前一列填充
```
- 缺失值删除

```
df3.dropna() #只要出现NaN就整行删除
```

缺失值填充：df3.fillna('0')

```
# 填充前：
     A    B  C    D
0  5.0  NaN  4  5.0
1  3.0  2.0  3  4.0
2  NaN  4.0  8  2.0
3  4.0  3.0  5  NaN

# 填充后：例子中用0填充
df3.fillna('0')
   A  B  C  D
0  5  0  4  5
1  3  2  3  4
2  0  4  8  2
3  4  3  5  0

```
- 重复值处理: 调用 drop_duplicates()

```
df.drop_duplicates()
```
### DateFrame数据获取

代码如下：

```
import pandas as pd
import numpy as np


#生成日期索引
dates = pd.date_range('20130101', periods=6)

#随机生成6行4列的数据，列名分别为A,B,C,D，并将前面生成的日期索引作为数据索引
df = pd.DataFrame(np.random.randn(6, 4), index=dates, columns=list('ABCD'))

print(df)
print('#'*10, '用标签提取一行数据:df.loc[dates[0]]', '#'*10)
#用标签提取一行数据：
print(df.loc[dates[0]])

print('#'*10, '用标签选择多列数据', '#'*10)
#用标签选择多列数据
print(df.loc[:, ['A', 'B']])

print('#'*10, "用标签切片，包含行与列结束点:df.loc['20130102':'20130104', ['A', 'B']]", '+'*10)
#用标签切片，包含行与列结束点
print(df.loc['20130102':'20130104', ['A', 'B']])

print('#'*10, "用标签切片:df['20130102':'20130104']", '+'*10)
print(df['20130102':'20130104'])

print('+'*10, "返回对象降维:df.loc['20130102', ['A', 'B']]", '+'*10)
#返回对象降维：
print(df.loc['20130102', ['A', 'B']])

print('+'*10, "提取标量值：df.loc[dates[0], 'A'],df.at[dates[0], 'A']", '+'*10)
#提取标量值：
print(df.loc[dates[0], 'A'])
print(df.at[dates[0], 'A'])

print('+'*10, '用整数位置选择:df.iloc[3]', '+'*10)
print(df.iloc[3])

print('+'*10, '类似 NumPy / Python，用整数切片:df.iloc[3:5, 0:2]', '+'*10)
print(df.iloc[3:5, 0:2])

print('+'*10, '类似 NumPy / Python，用整数列表按位置切片:df.iloc[[1, 2, 4], [0, 2]]', '+'*10)
print(df.iloc[[1, 2, 4], [0, 2]])

print('+'*10, '显式整行切片:df.iloc[1:3, :]', '+'*10)
print(df.iloc[1:3, :])

print('+'*10, '显式整列切片:df.iloc[:, 1:3]', '+'*10)
print(df.iloc[:, 1:3])

print('+'*10, '显式提取值:df.iloc[1, 1]', '+'*10)
print(df.iloc[1, 1])
```
上述返回的值：

```
                   A         B         C         D
2013-01-01  0.622449 -1.233722  0.831927 -1.007144
2013-01-02  1.219420  0.434644  0.028887  0.851639
2013-01-03  0.833609 -0.502525 -1.309884  0.073319
2013-01-04  0.687200 -0.545574 -0.160811 -1.355826
2013-01-05  1.297350  0.805917 -0.432199  0.912396
2013-01-06  0.781028  0.552472  1.393201  1.011922

########## 用标签提取一行数据:df.loc[dates[0]] ##########
A    0.622449
B   -1.233722
C    0.831927
D   -1.007144
Name: 2013-01-01 00:00:00, dtype: float64

########## 用标签选择多列数据 ##########
                   A         B
2013-01-01  0.622449 -1.233722
2013-01-02  1.219420  0.434644
2013-01-03  0.833609 -0.502525
2013-01-04  0.687200 -0.545574
2013-01-05  1.297350  0.805917
2013-01-06  0.781028  0.552472

##用标签切片，包含行与列结束点:df.loc['20130102':'20130104', ['A', 'B']] ##
                   A         B
2013-01-02  1.219420  0.434644
2013-01-03  0.833609 -0.502525
2013-01-04  0.687200 -0.545574

########## 用标签切片:df['20130102':'20130104'] ##########
                   A         B         C         D
2013-01-02  1.219420  0.434644  0.028887  0.851639
2013-01-03  0.833609 -0.502525 -1.309884  0.073319
2013-01-04  0.687200 -0.545574 -0.160811 -1.355826

########## 返回对象降维:df.loc['20130102', ['A', 'B']] ##########
A    1.219420
B    0.434644
Name: 2013-01-02 00:00:00, dtype: float64

## 提取标量值：df.loc[dates[0], 'A'],df.at[dates[0], 'A'] ##
0.6224489446507094
0.6224489446507094

########## 用整数位置选择:df.iloc[3] ##########
A    0.687200
B   -0.545574
C   -0.160811
D   -1.355826
Name: 2013-01-04 00:00:00, dtype: float64

## 类似 NumPy / Python，用整数切片:df.iloc[3:5, 0:2] ##
                  A         B
2013-01-04  0.68720 -0.545574
2013-01-05  1.29735  0.805917

## 类似 NumPy / Python，用整数列表按位置切片:df.iloc[[1, 2, 4], [0, 2]] ##
                   A         C
2013-01-02  1.219420  0.028887
2013-01-03  0.833609 -1.309884
2013-01-05  1.297350 -0.432199

########## 显式整行切片:df.iloc[1:3, :] ##########
                   A         B         C         D
2013-01-02  1.219420  0.434644  0.028887  0.851639
2013-01-03  0.833609 -0.502525 -1.309884  0.073319

########## 显式整列切片:df.iloc[:, 1:3] ##########
                   B         C
2013-01-01 -1.233722  0.831927
2013-01-02  0.434644  0.028887
2013-01-03 -0.502525 -1.309884
2013-01-04 -0.545574 -0.160811
2013-01-05  0.805917 -0.432199
2013-01-06  0.552472  1.393201

########## 显式提取值:df.iloc[1, 1] ##########
0.43464430353134265
```

### DateFrame布尔索引
代码如下：

```
print(df)
print('#'*10, '用单列的值选择数据：df[df.A > 0]', '#'*10)
#用标签提取一行数据：
print(df[df.A > 0])

print('#'*10, '选择 DataFrame 里满足条件的值：df[df > 0]', '#'*10)
#用标签提取一行数据：
print(df[df > 0])

print('#'*10, "用isin() 筛选：df2[df2['E'].isin(['two', 'four'])]", '#'*10)
df2 = df.copy()
df2['E'] = ['one', 'one', 'two', 'three', 'four', 'three']
print(df2)
print(df2[df2['E'].isin(['two', 'four'])])
```
结果如下：

```
                   A         B         C         D
2013-01-01  0.976894  0.797907 -0.327750 -0.445965
2013-01-02 -1.711636 -0.434126 -0.197788 -0.112459
2013-01-03 -1.179992 -0.215712  3.004319 -0.710752
2013-01-04 -0.843088 -0.436575  0.066355  1.962227
2013-01-05 -0.748851  0.093879 -0.080892 -0.916704
2013-01-06 -0.287512  0.853493  0.733210  0.499588

########## 用单列的值选择数据：df[df.A > 0] ##########
                   A         B        C         D
2013-01-01  0.976894  0.797907 -0.32775 -0.445965

########## 选择 DataFrame 里满足条件的值：df[df > 0] ##########
                   A         B         C         D
2013-01-01  0.976894  0.797907       NaN       NaN
2013-01-02       NaN       NaN       NaN       NaN
2013-01-03       NaN       NaN  3.004319       NaN
2013-01-04       NaN       NaN  0.066355  1.962227
2013-01-05       NaN  0.093879       NaN       NaN
2013-01-06       NaN  0.853493  0.733210  0.499588

########## 用isin() 筛选：df2[df2['E'].isin(['two', 'four'])] ##########
                   A         B         C         D      E
2013-01-01  0.976894  0.797907 -0.327750 -0.445965    one
2013-01-02 -1.711636 -0.434126 -0.197788 -0.112459    one
2013-01-03 -1.179992 -0.215712  3.004319 -0.710752    two
2013-01-04 -0.843088 -0.436575  0.066355  1.962227  three
2013-01-05 -0.748851  0.093879 -0.080892 -0.916704   four
2013-01-06 -0.287512  0.853493  0.733210  0.499588  three
                   A         B         C         D     E
2013-01-03 -1.179992 -0.215712  3.004319 -0.710752   two
2013-01-05 -0.748851  0.093879 -0.080892 -0.916704  four
```

### DateFrame运算
#### 统计

```
import pandas as pd


df = pd.DataFrame({"A":[5,3,None,4],
                 "B":[None,2,4,3], 
                 "C":[4,3,8,5], 
                 "D":[5,4,2,None]}) 
```
df结果：
```
     A    B  C    D
0  5.0  NaN  4  5.0
1  3.0  2.0  3  4.0
2  NaN  4.0  8  2.0
3  4.0  3.0  5  NaN

```

运算结果如下：
- 两列之间的加减乘除 df['A'] + df['C'] 

```
0    9.0
1    6.0
2    NaN
3    9.0
```
- 任意一列加/减一个常数值，这一列中的所有值都加/减这个常数值，如：df['A'] + 5


```
0    10.0
1     8.0
2     NaN
3     9.0
```

- 比较运算，如：df['A'] > df ['C']  

```
0     True
1    False
2    False
3    False
```

- count非空值计数，如：df.count()

```
A    3
B    3
C    4
D    3
```

- 非空值每列求和，如：df.sum(),得到的是float

```
A    12.0
B     9.0
C    20.0
D    11.0
dtype: float64
```

- mean求均值，如df.mean(), 注意：拿到是数据是float

```
A    4.000000
B    3.000000
C    5.000000
D    3.666667
dtype: float64
```

- max求最大值, df.max()，得到的是float

```
A    5.0
B    4.0
C    8.0
D    5.0
dtype: float64
```

- min求最小值，df.min(),得到的是float

```
A    3.0
B    2.0
C    3.0
D    2.0
dtype: float64
```

- median求中位数, df.median()

```
A    4.0
B    3.0
C    4.5
D    4.0
dtype: float64
```

- mode求众数, df.mode(), 数据大小重新排列了

```
     A    B  C    D
0  3.0  2.0  3  2.0
1  4.0  3.0  4  4.0
2  5.0  4.0  5  5.0
3  NaN  NaN  8  NaN
```

- var求方差，df.var()

```
A    1.000000
B    1.000000
C    4.666667
D    2.333333
dtype: float64
```

- td求标准差,df.std()

```
A    1.000000
B    1.000000
C    2.160247
D    1.527525
dtype: float64
```
#### 聚合

```
import pandas as pd
import numpy as np

# 聚合
sales = [{'account': 'Jones LLC','type':'a', 'Jan': 150, 'Feb': 200, 'Mar': 140},
         {'account': 'Alpha Co','type':'b',  'Jan': 200, 'Feb': 210, 'Mar': 215},
         {'account': 'Blue Inc','type':'a',  'Jan': 50,  'Feb': 90,  'Mar': 95 }]
         
df = pd.DataFrame(sales)
```
- df结果
```
df
     account type  Jan  Feb  Mar
0  Jones LLC    a  150  200  140
1   Alpha Co    b  200  210  215
2   Blue Inc    a   50   90   95
```
- df.groupby('type').groups 结果
```
{'a': [0, 2], 'b': [1]}
```
- 通过for a, b in df2.groupby('type'):得到a,b

```
a
     account type  Jan  Feb  Mar
0  Jones LLC    a  150  200  140
2   Blue Inc    a   50   90   95

b
    account type  Jan  Feb  Mar
1  Alpha Co    b  200  210  215
```
- 聚合后再计算,如：df.groupby('type').count()

```
      account  Jan  Feb  Mar
type                        
a           2    2    2    2
b           1    1    1    1
```
- 各类型产品的销售数量和销售总额，df.groupby('type').aggregate( {'type':'count' , 'Feb':'sum' })

```
      type  Feb
type           
a        2  290
b        1  210
```
- 同时，通过groupby可以进行各类运算：比如平均值，mean()，df.groupby('type').mean()

### DateFrame合并（Merge）

```
import pandas as pd
import numpy as np

group = ['x','y','z']
data1 = pd.DataFrame({
    "group":[group[x] for x in np.random.randint(0,len(group),10)] ,
    "age":np.random.randint(15,50,10)
    })

data2 = pd.DataFrame({
    "group":[group[x] for x in np.random.randint(0,len(group),10)] ,
    "salary":np.random.randint(5,50,10),
    })

data3 = pd.DataFrame({
    "group":[group[x] for x in np.random.randint(0,len(group),10)] ,
    "age":np.random.randint(15,50,10),
    "salary":np.random.randint(5,50,10),
    })
```
data1结果：
```
data1
  group  age
0     x   47
1     y   41
2     y   34
3     z   42
4     z   19
5     x   22
6     y   38
7     z   31
8     y   37
9     y   16
```
data2结果：

```
data2
  group  salary
0     y      26
1     y      23
2     x      16
3     x      48
4     z      37
5     y      18
6     y      31
7     y      38
8     y       6
9     y      10
```

data3结果：

```
data3
  group  age  salary
0     x   44      42
1     y   32      29
2     x   23      28
3     x   47      10
4     z   38      10
5     y   23      45
6     y   23      48
7     y   18      49
8     z   46      26
9     x   42      20
```
- 一对一 pd.merge(data1, data2)

```
pd.merge(data1, data2)
   group  age  salary
0      x   47      16
1      x   47      48
2      x   22      16
3      x   22      48
4      y   41      26
5      y   41      23
6      y   41      18
7      y   41      31
8      y   41      38
9      y   41       6
10     y   41      10
11     y   34      26
12     y   34      23
13     y   34      18
14     y   34      31
15     y   34      38
16     y   34       6
17     y   34      10
18     y   38      26
19     y   38      23
20     y   38      18
21     y   38      31
22     y   38      38
23     y   38       6
24     y   38      10
25     y   37      26
26     y   37      23
27     y   37      18
28     y   37      31
29     y   37      38
30     y   37       6
31     y   37      10
32     y   16      26
33     y   16      23
34     y   16      18
35     y   16      31
36     y   16      38
37     y   16       6
38     y   16      10
39     z   42      37
40     z   19      37
41     z   31      37
```
- 多对一，pd.merge(data3, data2, on='group')

```
pd.merge(data3, data2, on='group')
   group  age  salary_x  salary_y
0      x   44        42        16
1      x   44        42        48
2      x   23        28        16
3      x   23        28        48
4      x   47        10        16
5      x   47        10        48
6      x   42        20        16
7      x   42        20        48
8      y   32        29        26
9      y   32        29        23
10     y   32        29        18
11     y   32        29        31
12     y   32        29        38
13     y   32        29         6
14     y   32        29        10
15     y   23        45        26
16     y   23        45        23
17     y   23        45        18
18     y   23        45        31
19     y   23        45        38
20     y   23        45         6
21     y   23        45        10
22     y   23        48        26
23     y   23        48        23
24     y   23        48        18
25     y   23        48        31
26     y   23        48        38
27     y   23        48         6
28     y   23        48        10
29     y   18        49        26
30     y   18        49        23
31     y   18        49        18
32     y   18        49        31
33     y   18        49        38
34     y   18        49         6
35     y   18        49        10
36     z   38        10        37
37     z   46        26        37
```
- 多对多，pd.merge(data3, data1)

```
pd.merge(data3, data1)
  group  age  salary
0     x   47      10
```

- 连接键类型，解决没有公共列问题，pd.merge(data3, data2, left_on= 'age', right_on='salary')


```
pd.merge(data3, data2, left_on= 'age', right_on='salary')

  group_x  age  salary_x group_y  salary_y
0       x   23        28       y        23
1       y   23        45       y        23
2       y   23        48       y        23
3       z   38        10       y        38
4       y   18        49       y        18
```

- 连接方式，指明连接方式可以为
  - 左连接 left
  - 右连接 right
  - 外连接 outer
  - 内连接 inner，不指明连接方式，默认都是内连接

```
pd.merge(data3, data2, on= 'group', how='inner')
```

- 纵向拼接（concat），pd.concat([data1, data2])

```
  group   age  salary
0     x  47.0     NaN
1     y  41.0     NaN
2     y  34.0     NaN
3     z  42.0     NaN
4     z  19.0     NaN
5     x  22.0     NaN
6     y  38.0     NaN
7     z  31.0     NaN
8     y  37.0     NaN
9     y  16.0     NaN
0     y   NaN    26.0
1     y   NaN    23.0
2     x   NaN    16.0
3     x   NaN    48.0
4     z   NaN    37.0
5     y   NaN    18.0
6     y   NaN    31.0
7     y   NaN    38.0
8     y   NaN     6.0
9     y   NaN    10.0
```

### 导出数据
- 导出为.xlsx文件，通过 to_excel() 方法
- 导出为.csv文件，通过 to_csv() 方法
- 导出为.pkl文件，通过 to_pickle() 方法

### 绘图
通过matplotlib.pyplot进行绘图

```
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

dates = pd.date_range('20200101', periods=12)
df = pd.DataFrame(np.random.randn(12,4), index=dates, columns=list('ABCD'))
df

'''
                   A         B         C         D
2020-01-01  0.889956  0.199388  0.982893  0.667213
2020-01-02  0.243429 -0.562650  0.357026 -2.567597
2020-01-03  1.442112  0.128448 -1.137238  0.599423
2020-01-04 -0.723885 -1.916325  2.124941 -0.165593
2020-01-05 -0.514275 -0.341104 -0.964886  0.952628
2020-01-06  0.521100 -0.666874 -0.001867  2.401689
2020-01-07  0.399728  1.316129  1.226578 -0.571405
2020-01-08 -1.813031  1.001745 -0.647751 -0.432725
2020-01-09  0.160008  0.604464 -0.253916 -0.625603
2020-01-10 -0.890083 -0.924546 -1.039180 -1.689799
2020-01-11 -1.180408  0.972287  0.530524 -0.887061
2020-01-12 -0.644876  0.997069  0.386194 -0.393827

'''
plt.plot(df.index, df['A'], )
plt.show()

plt.plot(df.index, df['A'], 
        color='#FFAA00',    # 颜色
        linestyle='--',     # 线条样式
        linewidth=3,        # 线条宽度
        marker='D')         # 点标记

plt.show()

# seaborn其实是在matplotlib的基础上进行了更高级的API封装，从而使绘图更容易、更美观
# 绘制散点图
plt.scatter(df.index, df['A'])
plt.show()

# 美化plt
sns.set_style('darkgrid')
plt.scatter(df.index, df['A'])
plt.show()
```
