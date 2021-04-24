'''
@�ļ�    :lncRNA-1.r
@˵��    :
@ʱ��    :2021/04/24 13:43:03
@����    :½�س�
@�汾    :1.0
@Email   :lu_baicheng@163.com
'''





#if(!requireNamespace("BiocManager",quietly = T))
#install.packages("BiocManager")
BiocManager::install("tidyverse")
library(tidyverse)
setwd("C:\\Users\\½�س�\\Desktop\\DKD")  #�����ļ�����·��
anno<-read.csv(file ="HG-U133_Plus_2.na36.annot.csv" ,header = T,sep = ",",quote = "\"",comment.char = "#",check.names = F) 
PER<-anno[,c("Probe Set ID","Ensembl","RefSeq Transcript ID")]
Ensembl<-PER[,c(1,2)]#��ȡ̽��ID��EnsembleID�Ķ�Ӧ��ϵ
Refseq<-PER[,c(1,3)]#��ȡ̽��ID��RefSeq Transcript ID�Ķ�Ӧ��ϵ
Ensembl[Ensembl$Ensembl=="---",]<-NA  #ȥ����û��Ensemble������---����
Ensembl<-na.omit(Ensembl)#�õ�̽��ID��EnsembleIDһ�Զ�a�Ĺ�ϵ
test<-apply(Ensembl,1,function(x){paste(x[1],str_split(x[2],' /// ',simplify = T),sep = "\\\\")})#����һ�Զ��á�///���ָ��ת�����á�\\\��һһ��Ӧ
(pro_ense<-tibble(unlist(test)))
colnames(pro_ense)<-"lala"
(ENSG<-separate(pro_ense,sep = "[\\\\]+",lala,c("prodeID","ensemblID")))#���һ�Զ�ת����һ��һ
Refseq[Refseq$`RefSeq Transcript ID`=="---",]<-NA
Refseq<-na.omit(Refseq)#41090
test1<-apply(Refseq,1,function(x){paste(x[1],str_split(x[2],' /// ',simplify = T),sep = "\\\\")})#����һ�Զ��á�///���ָ��ת�����á�\\\��һһ��Ӧ
(pro_ref<-tibble(unlist(test1)))
colnames(pro_ref)<-"lala"
(Ref<-separate(pro_ref,sep = "[\\\\]+",lala,c("prodeID","refseqID")))#���һ�Զ�ת����һ��һ
Ref<-Ref[c(grep("NR",Ref$refseqID,fixed = F)),]#ɸѡID��NR��ͷ��
write.table(ENSG$ensemblID,"EnsemblID.txt",row.names = F,col.names = F,quote =F,sep = "\t")
write.table(Ref$refseqID,"RefseqID.txt",row.names = F,col.names = F,quote =F,sep = "\t")
write.table(ENSG,"ENSG.txt",row.names = F,col.names = F,quote =F,sep = "\t")
write.table(Ref,"Ref.txt",row.names = F,col.names = F,quote =F,sep = "\t")

