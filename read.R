
'''
@文件    :readcount.r
@说明    :
@时间    :2021/04/03 16:23:33
@作者    :陆柏成
@版本    :1.0
@Email   :lu_baicheng@163.com
'''





library("biomaRt")
library('curl')
rm(list = ls())
options(stringsAsFactors = F)
setwd("C:\\Users\\陆柏成\\Desktop\\rna-seq\\肾集合管癌")

#导入各数据集

tumor1<-read.table("SRR4448015.txt",header = T)
colnames(tumor1)[7]<-("tumor1")
tumor1<-tumor1[,-(2:6)]

control1<-read.table("SRR4448016.txt",header = T)
colnames(control1)[7]<-("control1")
control1<-control1[,-(2:6)]

tumor2<-read.table("SRR4448017.txt",header = T)
colnames(tumor2)[7]<-("tumor2")
tumor2<-tumor2[,-(2:6)]

control2<-read.table("SRR4448018.txt",header = T)
colnames(control2)[7]<-("control2")
control2<-control2[,-(2:6)]

tumor3<-read.table("SRR4448019.txt",header = T)
colnames(tumor3)[7]<-("tumor3")
tumor3<-tumor3[,-(2:6)]

control3<-read.table("SRR4448020.txt",header = T)
colnames(control3)[7]<-("control3")
control3<-control3[,-(2:6)]

tumor4<-read.table("SRR4448021.txt",header = T)
colnames(tumor4)[7]<-("tumor4")
tumor4<-tumor4[,-(2:6)]

control4<-read.table("SRR4448022.txt",header = T)
colnames(control4)[7]<-("control4")
control4<-control4[,-(2:6)]


tumor5<-read.table("SRR4448023.txt",header = T)
colnames(tumor5)[7]<-("tumor5")
tumor5<-tumor5[,-(2:6)]

tumor6<-read.table("SRR4448024.txt",header = T)
colnames(tumor6)[7]<-("tumor6")
tumor6<-tumor6[,-(2:6)]

control6<-read.table("SRR4448025.txt",header = T)
colnames(control6)[7]<-("control6")
control6<-control6[,-(2:6)]

tumor7<-read.table("SRR4448026.txt",header = T)
colnames(tumor7)[7]<-("tumor7")
tumor7<-tumor7[,-(2:6)]

control7<-read.table("SRR4448027.txt",header = T)
colnames(control7)[7]<-("control7")
control7<-control7[,-(2:6)]





#整合数据表

tumor_count<-merge(tumor1,tumor2,by="Geneid")
tumor_count<-merge(tumor_count,tumor3,by="Geneid")
tumor_count<-merge(tumor_count,tumor4,by="Geneid")
tumor_count<-merge(tumor_count,tumor5,by="Geneid")
tumor_count<-merge(tumor_count,tumor6,by="Geneid")
tumor_count<-merge(tumor_count,tumor7,by="Geneid")

control_count<-merge(control1,control2,by="Geneid")
control_count<-merge(control_count,control3,by="Geneid")
control_count<-merge(control_count,control4,by="Geneid")
control_count<-merge(control_count,control6,by="Geneid")
control_count<-merge(control_count,control7,by="Geneid")

raw_count <- merge(tumor_count,control_count, by="Geneid")

ENSEMBL <- gsub("\\.\\d*", "", raw_count$Geneid)  #去除小数，只取整 

row.names(raw_count)<- ENSEMBL       


#biomartID转换
my_mart<- useMart("ENSEMBL_MART_ENSEMBL")
datasets <- listDatasets(my_mart)
my_dataset <- useDataset("hsapiens_gene_ensembl",mart =  my_mart)
my_ensemble_gene_id<-row.names(raw_count)
options(timeout = 2000000)
my_symbols<- getBM(attributes = c("ensembl_gene_id","hgnc_symbol"),filters = "ensembl_gene_id",values = my_ensemble_gene_id,mart = my_dataset )


#需要去外面的ecxel第一列手动输入”ensembl_gene_id“，用来后续匹配
readcount<-raw_count[,-1]
write.csv(readcount, file='readcount.csv')
readcount<-read.csv("readcount.csv",header = T)
readcount<-merge(my_symbols,readcount,by="ensembl_gene_id")
write.csv(readcount, file='readcount_end.csv')

