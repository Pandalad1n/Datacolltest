from worker import Worker
from initdb import Initdb

if __name__ == '__main__':
    worker = Worker()
    worker.do()
    worker.initdb()
    Initdb()
