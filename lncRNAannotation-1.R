'''
@文件    :lncRNA-1.r
@说明    :
@时间    :2021/04/24 13:43:03
@作者    :陆柏成
@版本    :1.0
@Email   :lu_baicheng@163.com
'''





#if(!requireNamespace("BiocManager",quietly = T))
#install.packages("BiocManager")
BiocManager::install("tidyverse")
library(tidyverse)
setwd("C:\\Users\\陆柏成\\Desktop\\DKD")  #设置文件所在路径
anno<-read.csv(file ="HG-U133_Plus_2.na36.annot.csv" ,header = T,sep = ",",quote = "\"",comment.char = "#",check.names = F) 
PER<-anno[,c("Probe Set ID","Ensembl","RefSeq Transcript ID")]
Ensembl<-PER[,c(1,2)]#提取探针ID和EnsembleID的对应关系
Refseq<-PER[,c(1,3)]#提取探针ID和RefSeq Transcript ID的对应关系
Ensembl[Ensembl$Ensembl=="---",]<-NA  #去除掉没有Ensemble但是以---填充的
Ensembl<-na.omit(Ensembl)#得到探针ID和EnsembleID一对多a的关系
test<-apply(Ensembl,1,function(x){paste(x[1],str_split(x[2],' /// ',simplify = T),sep = "\\\\")})#将以一对多用‘///’分割的转换成用‘\\\’一一对应
(pro_ense<-tibble(unlist(test)))
colnames(pro_ense)<-"lala"
(ENSG<-separate(pro_ense,sep = "[\\\\]+",lala,c("prodeID","ensemblID")))#最后将一对多转换成一对一
Refseq[Refseq$`RefSeq Transcript ID`=="---",]<-NA
Refseq<-na.omit(Refseq)#41090
test1<-apply(Refseq,1,function(x){paste(x[1],str_split(x[2],' /// ',simplify = T),sep = "\\\\")})#将以一对多用‘///’分割的转换成用‘\\\’一一对应
(pro_ref<-tibble(unlist(test1)))
colnames(pro_ref)<-"lala"
(Ref<-separate(pro_ref,sep = "[\\\\]+",lala,c("prodeID","refseqID")))#最后将一对多转换成一对一
Ref<-Ref[c(grep("NR",Ref$refseqID,fixed = F)),]#筛选ID以NR开头的
write.table(ENSG$ensemblID,"EnsemblID.txt",row.names = F,col.names = F,quote =F,sep = "\t")
write.table(Ref$refseqID,"RefseqID.txt",row.names = F,col.names = F,quote =F,sep = "\t")
write.table(ENSG,"ENSG.txt",row.names = F,col.names = F,quote =F,sep = "\t")
write.table(Ref,"Ref.txt",row.names = F,col.names = F,quote =F,sep = "\t")


