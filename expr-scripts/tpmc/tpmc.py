files = ['/home/vldb/RESULT/redo_test3/20G_1G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_2G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_3G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_4G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_5G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_6G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_7G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_8G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_9G_16M_vanila.tpcc',
         '/home/vldb/RESULT/redo_test3/20G_10G_16M_vanila.tpcc']

tpmc_list = []
for file in files:
    with open(file, 'r') as f:
        line = f.readlines()[598]
        tpmc = ''.join(filter(lambda x: x.isdigit() or x == '.', line))
        tpmc_list.append(tpmc)

with open('tpmc.txt', 'w') as f:  
    for i, tpmc in enumerate(tpmc_list):
        
        f.write(str(i+1) + "G 0 " + str(tpmc)+"\n")