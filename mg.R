#多因素的竞争风险模型
#1341名单克隆丙种球蛋白病患者,结局事件为发生浆细胞恶性肿瘤，也有在发生恶性肿瘤之前就死亡的，为竞争事件

#加载数据
#install.packages("cmprsk")
#install.packages("survival")
#install.packages("riskRegression")
#install.packages("prodlim")
#install.packages("lava")
library(prodlim)
library(lava)
library(cmprsk)
library(survival)
library(riskRegression)
ormg <- mgus2  
# write.csv(ormg,"C:\\Users\\Catherine\\Desktop\\回归分析\\data\\ormg.csv")
# ?mgus2 
dim(ormg) #1384*11
head(ormg)
mg1 <- ormg[complete.cases(ormg),]
mg1 <- mg1[,-1]
View(mg1)
class(dt)  #data.frame
str(mg1)


mg1$etime <- ifelse(mg1$pstat == 0, mg1$futime, mg1$ptime)
mg1$event <- ifelse(mg1$pstat == 0, 2*mg1$death, 1)
mg1$event <- factor(mg1$event, 0:2) #三个等级，得病1，没得没死0，没得死了2
mg1$sex <- ifelse(mg1$sex == 'M',2,1)
mg1$hgb <- ifelse(mg1$hgb <= 16,(ifelse(mg1$hgb>=11,0,1)),1)
mg1$creat <- ifelse(mg1$creat <= 1.2,(ifelse(mg1$creat>=0.6,0,1)),1)

#Kaplan-Meier生存曲线

# install.packages("KMunicate")
library(KMunicate)
par(mfrow = c(1,1))
fit1 <- survfit(Surv(etime,death) ~ sex,data =mg1)
fit2 <- survfit(Surv(etime,death) ~ pstat,data =mg1)
fit3 <- survfit(Surv(etime,death) ~ hgb,data =mg1)
fit4 <- survfit(Surv(etime,death) ~ creat,data =mg1)
summary(fit1)
pt <- seq(0,max(mg1$etime),by= 100)
pt

KMunicate(fit=fit2,time_scale = pt)
ggsurvplot(fit1, data = mg1,
           surv.median.line = "hv",  # 增加中位生存时间
           conf.int = TRUE)
ggsurvplot(fit2, data = mg1,
           surv.median.line = "hv",  # 增加中位生存时间
           conf.int = TRUE)
ggsurvplot(fit3, data = mg1,
           surv.median.line = "hv",  # 增加中位生存时间
           conf.int = TRUE)
ggsurvplot(fit4, data = mg1,
           surv.median.line = "hv",  # 增加中位生存时间
           conf.int = TRUE)

#残差
res.cox1 <- coxph(Surv(etime, death) ~ age +mspike , data =  mg1)
res.cox2 <- coxph(Surv(etime, death) ~ age , data =  mg1)
res.cox3 <- coxph(Surv(etime, death) ~ mspike , data =  mg1)
res.cox
res.cox1
test.ph <- cox.zph(res.cox1);test.ph
ggcoxzph(test.ph,point.col = "darkblue")
?ggcoxzph

#异常值
ggcoxdiagnostics(res.cox3, type = "dfbeta",
                 linear.predictions = FALSE, ggtheme = theme_bw())
ggcoxdiagnostics(res.cox2, type = "dfbeta",
                 linear.predictions = FALSE, ggtheme = theme_bw())
ggcoxdiagnostics(res.cox2, type = "deviance",
                 linear.predictions = FALSE, ggtheme = theme_bw())
ggcoxfunctional(Surv(etime, death) ~ age + log(age) + sqrt(age), data = mg1)
ggcoxfunctional(Surv(etime, death) ~ mspike + log(mspike) + sqrt(mspike), data = mg1)
#ROC曲线绘制
#1 一个模型某个时间点ROC
#构建多因素比例风险模型
# fgr1 <- FGR(Hist(etime,death)~age+hgb+sex+mspike+creat+pstat, data = mg1, cause = 1)
# ?FGR
summary(fgr1)
cols<- c("age","sex","hgb","mspike","creat","pstat")
col1 <- c("age","sex","hgb","creat","pstat")
My.stepwise.coxph(Time = "etime", 
                  Status = "death", 
                  variable.list =cols , 
                  data = mg1)
result1 <- coxph(formula = Surv(etime, death) ~ age + creat + pstat + hgb + 
        sex, data = mg1, method = "efron")
a<-cox.zph(result1)
plot(a[6])
print(a)
Summary(result1)
basehaz(result1,centered = T)

#计算10年，20年和30年的AUC值、ROC值
fit1 <- Score(list('model1' = fgr1),
              formula = Hist(etime, death)~1,
              data = mg1, 
              se.fit = 1, times = c(30,90,150),
              plots = "ROC", metrics = "auc")
?Score
fit1
#提取AUC
d <- as.data.frame(fit1$AUC$score);
a <- d[d$times %in% c(30,90,150),];a
a$AUC_com <- paste(round(a$AUC,3),'(',round(a$lower,3),',',round(a$upper,3),')',sep='')
#list里面对象要和formula对应，都是竞争风险；times可以是单个时间点也可以是多个。
#se.fit表示要计算标准误
#fit打印出来可以看到各个时间点的AUC和置信区间，为后面绘图制作图例。

#################作图
col = c("darkcyan", "tomato", "purple") #制作颜色变量
col[1]
plotROC(fit1,
        xlab="1-Specificity",
        ylab="Sensitivity",
        col=col[1],
        legend = "",
        cex = 1,
        auc.in.legend = F,#控制是否显示图例
        times=30)

#2.一个模型的多个时间点ROC
plotROC(fit1,
     
        col=col[2],
        legend = "",
        cex = 0.5,
        auc.in.legend = F,#控制是否显示图例
        times=90,add = T)
plotROC(fit1,
        
        col=col[3],
        legend = "",
        cex = 0.5,
        auc.in.legend = F,#控制是否显示图例
        times=150,add = T)
#加上图例
leg <- paste(c("30个月：","90个月：","150个月："),a$AUC_com)
legend(0.6,0.4,legend = leg, cex=1,bty='n', col = col, lwd=2)

