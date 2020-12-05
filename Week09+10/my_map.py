'''
自定义一个 python 函数，实现 map() 函数的功能。
'''


from collections.abc import Iterable


def my_map(func, iter_data):
    if not isinstance(iter_data, Iterable):
        object_name = type(iter_data).__name__
        raise TypeError("'{}' object is not iterable".format(object_name))

    iter_len = len(iter_data)
    if iter_len:
        for val in iter_data:
            yield func(val)



if __name__ == '__main__':
    try:
    	# 测试
        data = my_map(lambda x: x * 2, (1, 2, 3))
        # data = my_map(lambda x: x * 2, [])
        # data = my_map(lambda x: x * 2, 'abcD')
        # data = my_map(lambda x: x * 2, range(1, 10))
        # data = my_map(lambda x: x * 2, {'a': 1, 2: 'b'})
        # data = my_map(lambda x: x * 2, 123)
        
        for i in data:
            print(i)

    except Exception as e:
        print(e)
