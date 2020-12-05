'''实现一个 @timer 装饰器，记录函数的运行时间，注意需要考虑函数可能会接收不定长参数。'''


import time
import functools


def timer(func):
    @functools.wraps(func)
    def wraps(*args, **kwargs):
        begin = time.time()
        ret = func(*args, **kwargs)
        end = time.time()
        print('程序执行时间 {}'.format((end - begin)))
        return ret
    return wraps


@timer
def my_func(*args):
    s = 0
    # 为使程序有效果，sleep0.5s
    time.sleep(0.5)
    return s



if __name__ == '__main__':

    list_vals = range(0,10)
    val = my_func(*list_vals)
    print(val)

