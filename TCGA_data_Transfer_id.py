#!/usr/bin/env python
# -*- encoding: utf-8 -*-
'''
@文件    :TCGA_data_Transfer_id.py
@说明    :
@时间    :2020/12/05 16:49:19
@作者    :陆柏成
@版本    :1.0
@Email   :lu_baicheng@163.com
'''
import os
from collections import OrderedDict
import re

os.chdir(r'E:\实验室\TCGA\TCGA数据\PRAD')

TCGA_id_trans=OrderedDict()
TCGA_trans_line=OrderedDict()
def annotation(gtf_file):

    with open(gtf_file,'r') as f:
        for line in f:

            if not line.startswith('chr'):
                continue

            line=line.rstrip().split('\t')
            if line[2]=='gene':
                gene_id=re.search(r'gene_id "(.*?)";',line[8])[1].split('.')[0]
                gene_symbol = re.search(r'gene_name "(.*?)";', line[8])[1]
                TCGA_id_trans[gene_id]=gene_symbol

                print(gene_id,gene_symbol)

    with open(r'E:\实验室\TCGA\TCGA数据\PRAD\tgca_matrix.txt', 'r') as f:
        for line in f:

            if line.startswith('id'):
                TCGA_trans_line['id']=line
            line = line.rstrip().split('\t')
            ESGO_id=line[0].split(".")[0]

            try:
                TCGA_id=TCGA_id_trans[ESGO_id]
                TCGA_trans_line[TCGA_id]='\t'.join(line[1:len(line)])
                print(TCGA_id)
            except:
                print('not a lnc')
    
    with open(r'E:\实验室\TCGA\TCGA数据\PRAD\annotated_TCGA_matrix.txt','w') as f_w:
        f_w.write(TCGA_trans_line['id'])
        for k,v in TCGA_trans_line.items():
            if k !='id':
                f_w.write(k+'\t'+v+'\n')
        f_w.close()


if __name__ == "__main__":

    annotation(r'E:\实验室\TCGA\gencode.v36.long_noncoding_RNAs.gtf')





