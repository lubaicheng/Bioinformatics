#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@文件    :read_fastq.py
@说明    :
@时间    :2020/09/07 20:51:42
@作者    :陆柏成
@版本    :1.0
@Email   :lu_baicheng@163.com
'''
    for index,line in enumerate(input_file):
        if index % 4 == 0:
            print(">" + line.strip()[1:])
        elif index % 4 == 1:
            print(line.strip())
        elif index % 4 == 2:
            continue
        elif index % 4 == 3:
            continue