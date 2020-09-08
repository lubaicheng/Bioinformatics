#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@文件    :fastq_to_fasta.py
@说明    :fastq格式转换成fasta
@时间    :2020/09/07 20:39:58
@作者    :陆柏成
@版本    :1.0
@Email   :lu_baicheng@163.com
'''

with open("E:\\新建文件夹\\text.txt","r") as input_file:
    for index,line in enumerate(input_file):
        if index % 4 == 0:
            print(">" + line.strip()[1:])
        elif index % 4 == 1:
            for i in range(0,len(line.strip()),5):
                print(line.strip()[i:i+5])  
        elif index % 4 == 2:
            continue
        elif index % 4 == 3:
            continue

