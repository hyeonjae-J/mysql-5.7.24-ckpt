def search_master_line(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
        reversed_lines = reversed(lines) # 라인을 뒤집어서 탐색
        for i, line in enumerate(reversed_lines):
            if 'Master     :' in line:
                return len(lines) - i # 라인 인덱스를 거꾸로 돌려야 함
    return -1 # Master 라인을 찾지 못한 경우 -1 반환

files = ['/home/vldb/RESULT/redo_test3/20G_1G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_2G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_3G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_4G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_5G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_6G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_7G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_8G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_9G_16M_vanila.stat',
        '/home/vldb/RESULT/redo_test3/20G_10G_16M_vanila.stat']

with open('ckpt_num.txt', 'w') as f:  
        f.write("# Buffer Master FlushList Dirty Logging\n")

for i, file in enumerate(files):
    m_line_num = search_master_line(file)-1
    
    with open(file, 'r') as f:

        lines = f.readlines()
        
        master_line = lines[m_line_num]
        flush_line = lines[m_line_num+1]
        dirty_line = lines[m_line_num+2]
        log_line = lines[m_line_num+3]

        master =int(''.join(filter(lambda x: x.isdigit(), master_line)))
        flush = int(''.join(filter(lambda x: x.isdigit(), flush_line)))
        dirty = int(''.join(filter(lambda x: x.isdigit(), dirty_line)))
        log = int(''.join(filter(lambda x: x.isdigit(), log_line)))

        
    with open('ckpt_num.txt', 'a') as f:  
        print(str(i+1)+"G 0 %d %d %d %d" %(master, flush, dirty, log), file=f)
        