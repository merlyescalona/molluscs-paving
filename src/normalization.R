data<-read.table("codon.usage.to.normalize.txt",sep=",")
dataSum=sum(data)
data2=data/dataSum
write.table(format(data2,digits=10), file="codon.usage.norm.txt",row.names=F,col.names=F)
