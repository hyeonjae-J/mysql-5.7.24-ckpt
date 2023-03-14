def substring(line):
    substring = line[11:16]
    substring = substring.replace(",","")
    substring = substring.replace(" ","")
    return substring

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

lines_list = []
for file in files:
    with open(file, 'r') as f:
        lines = f.readlines()
        lines_list.append(lines)

with open('line.txt', 'w') as f:  
    for lines in lines_list:
        for i, line in enumerate(lines):
            if 25<i<566:
                trx=substring(line)
                f.write(trx)
                f.write('\n')
        f.write('\n\n\n')