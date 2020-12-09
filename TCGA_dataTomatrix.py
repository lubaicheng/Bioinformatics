#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@文件    :TCGA_dataTomatrix.py
@说明    :
@时间    :2020/12/09 20:29:34
@作者    :陆柏成
@版本    :1.0
@Email   :lu_baicheng@163.com
'''

import os
import sys
from collections import OrderedDict
import json
import re
import glob
import gzip
import time
import shutil
from multiprocessing import Pool
os.chdir(r'E:\实验室\TCGA\TCGA数据\PRAD')
import asyncio
def TCGA_data_transformer(json_file):
    gene_group = OrderedDict()
    tcga_file = OrderedDict()
    list_1 = []
    normal = []
    tumor = []
    with open(json_file, "r") as f1:
        data = json.load(f1)
        for i in data:
            file_name = i["file_name"]
            file_name = re.sub("\.gz", "", file_name)
            tcga_id = i["associated_entities"][0]["entity_submitter_id"]
            tcga_file[tcga_id] = file_name
           
            ID = tcga_id.split("-")
            if ID[3] == "11A":
                normal.append(tcga_id)
            else:
                tumor.append(tcga_id)

    list_1.extend(normal)
    list_1.extend(tumor)
    return list_1,tcga_file

def un_gz(file_name):
    # 获取文件的名称，去掉后缀名
    f_name = file_name.replace(".gz", "")
    # 开始解压
    g_file = gzip.GzipFile(file_name)
    # 读取解压后的文件，并写入去掉后缀名的同名文件（即得到解压后的文件）
    open(f_name, "wb+").write(g_file.read())
    g_file.close()

def get_count_file():
    for root, dirs, files in os.walk('./'):
        for item in files:
            if re.search('gz',item):
                # i +=1
                # print(item,i)
                file_Dir=os.path.join(root,item)

                un_gz(file_Dir)
                file_read=re.sub('.gz','',file_Dir)
                shutil.move(file_read,'./')

def readfile(file):
    file_obj = open(file)
    try:
        while True:
            line = file_obj.readline().strip("\n")
            if not line:
                break
            arry = line.split("\t")
            if arry[0] in tcga_matrix:
                tcga_matrix[arry[0]].append(arry[1])
            else:
                tcga_matrix[arry[0]] = [arry[1]]
    finally:
        file_obj.close()

if __name__ == "__main__":
    tcga_matrix = OrderedDict()
    s1=time.time()
    case_list,tcga_dic=TCGA_data_transformer(r'E:\实验室\TCGA\TCGA数据\metadata.cart.2020-12-09.json')
    get_count_file()

    for i in case_list:
        readfile(tcga_dic[i])
    with open('tgca_matrix.txt','w') as f_w:
        f_w.write('id'+'\t'+'\t'.join(case_list[0:len(case_list)])+'\n')
        for k,v in tcga_matrix.items():
            f_w.write(k+'\t'+'\t'.join(v[0:len(v)])+'\n')
        f_w.close()

    s2=time.time()
    print(s2-s1)
