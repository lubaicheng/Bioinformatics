#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@文件    :fasta_count.py
@说明    :将fasta数据格式的碱基进行统计
@时间    :2020/09/06 13:23:37
@作者    :陆柏成
@版本    :1.0
@Email   :lu_baicheng@163.com
'''


chrm_genome = ""

with open ('E:\\new 1.fasta','r') as input_file:            #打开需要统计的文件  
    for line  in input_file:                     #循环读取文件
        if line[0] != ">":
            line = line.strip().upper()                     #strip去掉行末的换行符号，upper()把所有的字母大写
            chrm_genome = chrm_genome + line                #将新读取的行添加到之前的序列中

print("测序的总长度为："+ str(len(chrm_genome))) 
print("在new 1.fasta中A的数量是：{0}".format(chrm_genome.count("A")))       #通过format函数来填充字符串
print("在new 1.fasta中T的数量是：{0}".format(chrm_genome.count("T")))
print("在new 1.fasta中G的数量是：{0}".format(chrm_genome.count("G")))
print("在new 1.fasta中C的数量是：{0}".format(chrm_genome.count("C")))
