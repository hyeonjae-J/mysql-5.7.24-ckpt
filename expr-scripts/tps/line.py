def substring(line):
    substring = line[11:16]
    substring = substring.replace(",","")
    substring = substring.replace(" ","")
    return substring

files = ['/home/vldb/RESULT/ckpt-1g-128m-0.1/20G_32thd_vanilla_flush.tpcc',
         '/home/vldb/RESULT/ckpt-1g-128m/20G_32thd_vanilla_flush.tpcc',
         '/home/vldb/RESULT/ckpt-1g-128m-2/20G_32thd_vanilla_flush.tpcc']
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