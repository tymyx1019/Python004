#第三周学习笔记
本周主要学习内容有scrapy参数优化、多进程及进程间通信、多线程、进程锁和线程锁、进程池和线程池、队列等


##scrapy参数优化
scrapy参数主要在settings.py文件中，通过CONCURRENT_REQUESTS等参数控制

##创建进程及多进程
Unix/Linux操作系统提供了一个fork()系统调用，Python的os模块封装了常见的系统调用，其中就包括fork，可以在Python程序中轻松创建子进程：os.fork()
multiprocessing模块实现了更高级的封装，multiprocessing模块提供了一个Process类来代表一个进程对象，创建子进程时，只需要传入一个执行函数和函数的参数，
创建一个Process实例，用start()方法启动，这样创建进程比fork()还要简单：
```python
        from multiprocessing import Process

        def run_process(name):
    		print(f'子进程开始 {name}...')

    	if __name__=='__main__':
    		print('父进程开始')
    	    p = Process(target=run_proc, args=('test',))
    	    p.start()
    		p.join()
    		print("父进程结束")

```

##进程池（Pool）
要启动大量的子进程，可以用进程池的方式批量创建子进程：
```python
        from multiprocessing.pool import Pool
		from time import sleep, time
		import random
		import os

		def run(name):
		    print("%s子进程开始，进程ID：%d" % (name, os.getpid()))
		    start = time()
		    sleep(random.choice([1, 2, 3, 4]))
		    end = time()
		    print("%s子进程结束，进程ID：%d。耗时%0.2f" % (name, os.getpid(), end-start))


		if __name__ == "__main__":
		    print("父进程开始")
		    p = Pool(4)
		    for i in range(10):
		        p.apply_async(run, args=(i,))
		    p.close()
		    p.join()
		    print("父进程结束。")
		    p.terminate()
```
但是注意：在调用join()之前必须要先close()，并且在close()之后不能再继续往进程池添加新的进程。

##进程锁
为了解决不同进程抢共享资源的问题，可以用加进程锁来解决：
```python
		import multiprocessing as mp
		import time

		# 在job()中设置进程锁的使用，保证运行时一个进程的对锁内内容的独占
		def job(v, num, l):
		    l.acquire() # 锁住
		    for _ in range(5):
		        time.sleep(0.1) 
		        v.value += num # 获取共享内存
		        print(v.value, end="|")
		    l.release() # 释放

		def multicore():
		    l = mp.Lock() # 定义一个进程锁
		    v = mp.Value('i', 0) # 定义共享内存
		    # 进程锁的信息传入各个进程中
		    p1 = mp.Process(target=job, args=(v,1,l)) 
		    p2 = mp.Process(target=job, args=(v,3,l)) 
		    p1.start()
		    p2.start()
		    p1.join()
		    p2.join()

		if __name__ == '__main__':
		    multicore()
```

##进程池间通信
操作系统提供了很多机制来实现进程间的通信，multiprocessing模块包装了底层的机制，提供了Queue、Pipes等多种方式来交换数据。
其中使用最多的是队列（Queue），代码以Queue为例：
```python
		from multiprocessing import Process, Queue
		import os, time

		def write(q):
		    print("启动Write子进程：%s" % os.getpid())
		    for i in ["A", "B", "C", "D"]:
		        q.put(i)  # 写入队列
		        time.sleep(1)
		    print("结束Write子进程：%s" % os.getpid())

		def read(q):
		    print("启动Read子进程：%s" % os.getpid())
		    while True:  # 阻塞，等待获取write的值
		        value = q.get(True)
		        print(value)
		    print("结束Read子进程：%s" % os.getpid())  # 不会执行

		if __name__ == "__main__":
		    # 父进程创建队列，并传递给子进程
		    q = Queue()
		    pw = Process(target=write, args=(q,))
		    pr = Process(target=read, args=(q,))
		    pw.start()
		    pr.start()

		    pw.join()
		    # pr进程是一个死循环，无法等待其结束，只能强行结束
		    # （写进程结束了，所以读进程也可以结束了）
		    pr.terminate()
		    print("父进程结束")
```



##多线程
Python的标准库提供了两个模块：threading和__thread，其中threading是__thread的高级封装。
启动一个线程就是把一个函数传入并创建Thread实例，然后调用start()开始执行：
```python
        import threading

		# 这个函数名可随便定义
		def run(n):
		    print("current task：", n)

		if __name__ == "__main__":
		    t1 = threading.Thread(target=run, args=("thread 1",))
		    t2 = threading.Thread(target=run, args=("thread 2",))
		    t1.start()
		    t2.start()
```
进程是由若干线程组成的，一个进程至少有一个线程。进程默认就会启动一个线程，我们把该线程称为主线程，主线程又可以启动新的线程，
Python的threading模块有个current_thread()函数返回当前线程的实例。主线程实例的名字叫MainThread，子线程的名字在创建时指定，上例中
我们起的名字为thread 1和thread 2，如果不起名字，默认名字为：Thread-1，Thread-2......

##线程锁
多线程和多进程最大的不同在于，多进程中，同一个变量，各自有一份拷贝存在于每个进程中，互不影响。
而多线程中，所有变量都由所有线程共享，所以，任何一个变量都可以被任何一个线程修改，因此，线程之间共享数据最大的危险在于多个线程同时改一个变量。
因此需要引入锁机制，某线程获得了锁，因为只有一把锁，那么其他线程只能等待。创建一个锁就是通过threading.Lock()来实现：
```python
		import threading
		import time

		num = 0
		mutex = threading.Lock()

		class MyThread(threading.Thread):
		    def run(self):
		        global num
		        time.sleep(1)

		        if mutex.acquire(1):    # 加锁 
		            num = num + 1
		            print(f'{self.name} : num value is  {num}')
		        mutex.release()   #解锁

		if __name__ == '__main__':
		    for i in range(5):
		        t = MyThread()
		        t.start()
```

另外threading模块还提供嵌套锁，通过threading.RLock()调用：
```python
		import threading
		import time
		# Lock普通锁不可嵌套，RLock普通锁可嵌套
		mutex = threading.RLock()

		class MyThread(threading.Thread):
		    def run(self):
		        if mutex.acquire(1):
		            print("thread " + self.name + " get mutex")
		            time.sleep(1)
		            mutex.acquire()
		            mutex.release()
		        mutex.release()

		if __name__ == '__main__':
		    for i in range(5):
		        t = MyThread()
		        t.start()
```

##线程池（Pool）
同进程一样，要启动大量的线程，可以用线程池的方式批量创建线程：
```python
		import requests
		from multiprocessing.dummy import Pool as ThreadPool

		urls = [
		   'http://www.baidu.com',
		   'http://www.sina.com.cn',
		   'http://www.163.com',
		   'http://www.qq.com',
		   'http://www.taobao.com',            
		   ]

		# 开启线程池
		pool = ThreadPool(4)
		# 获取urls的结果
		results = pool.map(requests.get, urls)
		# 关闭线程池等待任务完成退出
		pool.close()
		pool.join()

		for  i in results:
		    print(i.url)
```

##队列
queue 模块实现多生产者，多消费者队列。当信息必须安全的在多线程之间交换时，它在线程编程中是特别有用的。此模块中的 Queue 类实现了所有锁定需求的语义。