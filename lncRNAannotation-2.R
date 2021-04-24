'''
@文件    :lncRNA-2.r
@说明    :
@时间    :2021/04/24 13:43:03
@作者    :陆柏成
@版本    :1.0
@Email   :lu_baicheng@163.com
'''


#install.packages("DealGPL570")
#BiocManager::install("limma")
library(DealGPL570)#处理GEO数据库中GPL570平台下所有的表达谱原始数据，将原始数据处理成表达谱数据
library(limma)
setwd("C:\\Users\\陆柏成\\Desktop\\DKD")#设置工作路径
file<-list.files(pattern = "GSE79973_RAW.tar",full.names = T)#将从GEO中下载的GSE79973_RAW.tar原始数据导入
result<-DealGPL570(file = file)#用DealGPL570这个包处理GSE79973的原始数据，第一列探针ID，第二列GENE symbol，后面就是样本的基因表达值
ENSG<-read.table("ENSG.txt",header = F,quote="",sep = "\t",check.names = F)
Ref<-read.table("Ref.txt",header = F,quote="",sep = "\t",check.names = F)
Ensembl_ZS<-read.table("Ensembl_ZS.txt",header = T,quote="",sep = "\t",check.names = F)
Refseq_ZS<-read.table("Refseq_ZS.txt",header = T,quote="",sep = "\t",check.names = F)

ENSG_lnc<-Ensembl_ZS[which(Ensembl_ZS$`Gene type`=="lncRNA"),]#将基因类型是lncrna的ENsembleID提取出来
REF_lnc<-Refseq_ZS[which(Refseq_ZS$`Gene type`=="lncRNA"),]#将基因类型是lncrna的RefseqID提取出来

m<-as.character(ENSG_lnc$`Gene stable ID`)
prode_ENSG_lnc<-ENSG[which(ENSG[,2]%in%c(m)),]  #找到探针与ENsembleID当中基因类型是Lncrna的对应关系
n<-as.character(REF_lnc$`RefSeq ncRNA ID`)
prode_REF_lnc<-Ref[which(Ref[,2]%in%c(n)),]#找到探针与RefseqID当中基因类型是lncrna的对应关系


result_prode_ENSG_lnc<-unique(prode_ENSG_lnc[,1])
result_prode_REF_lnc<-unique(prode_REF_lnc[,1])
expre<-result[which(result$probe_id%in%c(as.character(union(result_prode_ENSG_lnc,result_prode_REF_lnc)))),]
expre<-expre[!duplicated(expre[,'probe_id']),]#将探针ID进行去重，因为一个探针会对应多个基因
expre<-aggregate(x=expre[,3:(ncol(expre))],by=list(expre$symbol),FUN=mean)#将一个基因对应多个探针取平均值
#差异表达分析Start
group<-rep(c("case","control"),10)#根据geo数据库中信息提示，按照case,control顺序，依次划分了10组。
design<-model.matrix(~0+factor(group))
colnames(design)<-levels(factor(group))
rownames(design)<-colnames(expre[,2:ncol(expre)])
fit<-lmFit(expre[,2:ncol(expre)],design)
cont.matrix<-makeContrasts("case-control",levels = c("case","control"))
fit2<-contrasts.fit(fit,cont.matrix)
fit2<-eBayes(fit2)
tempOutput<-topTable(fit2,coef=1,n=Inf,adjust="BH")
diff<-na.omit(tempOutput)#去除空值行
#差异表达分析Finsh
diff<-cbind(expre$Group.1,diff)
expre_df<-diff[which(diff$'P.Value'<0.01),]#得到差异表达的lncrna
names(expre_df)[1]<-"Gene_symbol"
write.table(expre_df,"expre_df.txt",row.names = F,col.names = T,sep = "\t",quote =F)
