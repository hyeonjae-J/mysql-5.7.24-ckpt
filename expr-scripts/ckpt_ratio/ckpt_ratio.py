import sys

def ratio(master, flush, log):
    sum = master + flush + log
    global Master
    global FlushList
    global Logging
    Master=str(100*round(master/sum, 4))
    FlushList=str(100*round(flush/sum, 4))
    Logging=str(100*round(log/sum, 4))

def main():
    f=open('ckpt-trigger.txt', 'w')
    global Master
    global FlushList
    global Logging

    print("# Buffer Master Dirty FlushList Logging", file=f)
    
    #put master, flush, log
    ratio(1041, 33292, 2253)
    print("32M    0 "+Master+" 0 "+FlushList+" "+ Logging, file=f)
    ratio(1056, 33920, 2291)
    print("64M    0 "+Master+" 0 "+FlushList+" "+ Logging, file=f)
    ratio(1046, 34423, 2379)
    print("128M    0 "+Master+" 0 "+FlushList+" "+ Logging, file=f)
    ratio(1047, 34219, 2345)
    print("256M    0 "+Master+" 0 "+FlushList+" "+ Logging, file=f)
    ratio(1053, 35244, 2528)
    print("512M    0 "+Master+" 0 "+FlushList+" "+ Logging, file=f)
    ratio(1051, 37223, 2696)
    print("1G    0 "+Master+" 0 "+FlushList+" "+ Logging, file=f)
    
    
    f.close()
    
if __name__=="__main__":
    main()