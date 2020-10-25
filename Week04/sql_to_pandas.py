import pandas as pd
import os


'''
data.csv存放的数据格式

    id  age  order_id
0    1   12        22
1    2   23        34
2    3   43      4343
3    4   48        12
4    5   12        11
5    6   34         6
6    7   89        67
7    8    5        76
8    9    4        66
9   10   44        57
10  11   75        54
11  12   56        45
12  13   12     34345
13  14   23       343
14  15   54        65
15  16   22     23232
16  17   56        23
17  18   32        23
18  19   34        66
19  20   75        54
'''

#组装data.csv路径
file_name = os.path.join(os.path.realpath('.'),'data.csv')

# 导入csv数据
df = pd.read_csv(file_name)

'''
1, ELECT * FROM data;
相当于读取整个表data的数据，因此对应pandas的DataFrame创建数据，和read_csv类似，因此本例中为 df
'''
print(df)

'''
2, SELECT * FROM data LIMIT 10;
取数据表data的前10行，对应的pandas方法为: df.head(10)
本例中如下：
'''
print(df.head(10))


"""
3. SELECT id FROM data;  //id 是 data 表的特定一列
取表中的id列，对应的pandas为 df['id']
"""
print(df['id'])


'''
4. SELECT COUNT(id) FROM data;
查询id列的个数, 对应的pandas为：df['id'].count()
'''
print(df['id'].count())


'''
5. SELECT * FROM data WHERE id<1000 AND age>30;
条件查询，由两个条件组合id<1000 并且 age>30，对应的pandas为：df['id']<1000) & (df['age']>30)
取值为：df[ (df['id']<1000) & (df['age']>30)]
'''
print(df[ (df['id']<1000) & (df['age']>30)])


'''
6. SELECT id,COUNT(DISTINCT order_id) FROM table1 GROUP BY id;
通过id列分组，查询id和对应的不相同的order_id的个数
对应的pandas为：df[['id','order_id']].groupby('id').count()
因为构造数据中id唯一，看不出效果，换成通过age排序，如下：
'''
print(df[['age','order_id']].groupby('age').count())


'''
7. SELECT * FROM table1 t1 INNER JOIN table2 t2 ON t1.id = t2.id;
t1和t2内连接，对应的pandas的方法为merge().
为方便调试，copy()方法构造两个t1,t2, 如下：
'''
t1 = df.copy()
t2 = df.copy()
print(pd.merge(t1, t2, on='id'))


'''
8. SELECT * FROM table1 UNION SELECT * FROM table2;
数据库的union操作，相同行会删除，对应的pandas方法为：pd.concat([t1, t2]).drop_duplicates()
'''
print(pd.concat([t1, t2]).drop_duplicates())


'''
9. DELETE FROM table1 WHERE id=10;
通过条件删除id为10的行，对应的pandas的操作为：找到df['id']==10的行，然后取反则得到其余的值
如下：
'''
print(df[ ~(df['id']==10)])


'''
10. ALTER TABLE table1 DROP COLUMN column_name;
SQL删除某列操作，对应的pandas有如下几种方法：
a: 通过pandas的drop(columns)方法删除
b: 通过del方式删除，类似python的del，如：del data[column]
c: 通过pandas的pop(column)方法,同时返回删除的列
例子中删除 age 列，如下：
'''
# df.drop(columns='age')
# del df['age']
df.pop('age')
print(df)