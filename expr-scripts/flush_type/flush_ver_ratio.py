import sys

def ratio(ckpt, lru, spf):
    sum = ckpt + lru + spf
    global CKPT
    global LRU
    global SPF
    CKPT=str(100*round(ckpt/sum, 4))
    LRU=str(100*round(lru/sum, 4))
    SPF=str(100*round(spf/sum, 4))

def main():
    f=open('flush_ver.txt', 'w')
    global CKPT
    global LRU
    global SPF

    print("#Table 0 CKPT LRU SPF", file=f)
    
    ratio(226, 0, 0)
    print("Warehouse 0 "+CKPT +" "+ LRU +" "+ SPF, file=f)
    ratio(12214799, 3352122, 445226)
    print("Stock 0 "+CKPT+" "+ LRU +" "+ SPF, file=f)
    #ratio(0, 0, 0)
    #print("Item 0 0 0 0", file=f)
    ratio(2288,0,0)
    print("District 0 "+CKPT+" "+ LRU +" "+  SPF, file=f)
    ratio(3764710,2736569,350369)
    print("Customer 0 "+CKPT+" "+ LRU +" "+ SPF, file=f)
    ratio(1373332,28809,5373)
    print("Orders 0 "+CKPT+" "+ LRU +" "+ SPF, file=f)
    ratio(181403,13579,2082)
    print("\"New Orders\" 0 "+CKPT+" "+ LRU +" "+ SPF, file=f)
    ratio(1516076,81872,11225)
    print("History 0 "+CKPT+" "+ LRU +" "+ SPF, file=f)
    ratio(11093988,1178934,166147)
    print("Orderline 0 "+CKPT+" "+ LRU +" "+ SPF, file=f)

    f.close()
    
if __name__=="__main__":
    main()