import threading

class Philosopher(threading.Thread):
    def __init__(self, threadID, leftLock, rightLock):
        threading.Thread.__init__(self)
        self.id = threadID
        self.leftLock = leftLock
        self.rightLock = rightLock


    def run(self):
        global count
        while True:
            while True:
                # 拿起左叉子
                self.leftLock.acquire(True)
                result.append([self.id, 2, 1])

                acquired = self.rightLock.acquire(False)
                if acquired: # 拿起右叉子
                    result.append([self.id, 1, 1])
                    break
                else:
                    # 放下左叉子
                    self.leftLock.release()
                    result.append([self.id, 2, 2])

            # 进餐
            result.append([self.id, 0, 3])

            # 放下左叉子
            self.leftLock.release()
            result.append([self.id, 2, 2])

            # 放下右叉子
            self.rightLock.release()
            result.append([self.id, 1, 2])

            count += 1
            if count >= n:
                break


if __name__ == '__main__':
    count = 0
    result = []
    n = 1
    philosophers_num = 5
    threads = []

    # 实例化5把锁和5个哲学家
    locks = [threading.Lock() for _ in range(philosophers_num)]
    threads = [Philosopher(i, locks[i], locks[(i+1) % philosophers_num]) for i in range(philosophers_num)]

    # 启动线程
    for ph_thread in threads:
        ph_thread.start()

    # 打印结果
    print(result)

