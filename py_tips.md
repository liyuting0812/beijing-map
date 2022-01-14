```python
#高清显示图片_是为了将图片嵌入notebook及提高分辨率
%matplotlib inline
%config InlineBackend.figure_format="retina"
```

```python
#保证可以显示中文字体
plt.rcParams['font.sans-serif']=['SimHei']
#或者解决中文乱码问题
plt.rc("font",family="SimHei",size="15")  
```

```python
#正常显示负号
plt.rcParams['axes.unicode_minus']=False
#不看warning
warnings.filterwarnings('ignore')
```

```python
#获取数据
data=pd.read_csv(r'')
data.head()#查看前五行
data.info()#查看数据类型
data.duplicated().sum()#查看重复值
data.describe()#描述性统计
date.corr() #连续型数据相关系数
```

```python
#使用字典替换数值
data['col']=car_price['col'].replace({'two':2,'three':3,"four":4,'six':6,"five":5,"eight":8,"twelve":12})
```

```python
#数据归一化 消除数值型数据的量级影响
data=preprocessing.MinMaxScaler().fit_transform(data)
data=pd.DataFrame(data)
data.head()
```

```python
#有含义的分类变量 排序12345
from sklearn.preprocessing import LabelEncoder
carSize1=LabelEncoder().fit_transform(features1['carsize'])
#无意义的分类变量 one-shot编码
cate=features1.select_dtypes(include='object').columns
features1=features1.join(pd.get_dummies(features1[cate])).drop(cate,axis=1)
```

```python
#去重查看 set元组去重特性
print(set(data["cols"]))
#去重drop_duplicated
print(data[''].drop_duplicates())
```

```python
#去除缺失值行
data.dropna()
```

```python
#列变量改名
data=data.rename(columns={'':'',':',":",':'})
```



```python
data.drop(2,axis=0) #删第二行
data.drop(['a','b'],axis=1) #删a,b两列
```

```python
#箱线图 seaborn包 matplotlib.pyplot包
fig=plt.figure(figsize=(12,8)) #图片大小
fig.add_subplot(3,5,6) #图片位置 将figure分成 三行五列一共15个图，放在第六个位置上
sns.boxplot(x=data[''],data=data)

```

```python
#热力图
with sns.axes_style("white"):
sns.heatmap()
```

```python
#分类
bins=[1,2,3,4]
label=['','','']
aa=pd.cut(dd,bins,labels=label)
print(aa)
```

```python
#分组查看
data.groupby('cate')[''].count()
```



```python
#KMeans（以后会单独写这部分）
KMeans(
    n_clusters=8,
    init='k-means++',
    n_init=10,
    max_iter=300,
    tol=0.0001,
    precompute_distances='auto',
    verbose=0,
    random_state=None,
    copy_x=True,
    n_jobs=None,
    algorithm='auto',
)
# 评估指标——轮廓系数,前者为所有点的平均轮廓系数，后者返回每个点的轮廓系数
from sklearn.metrics import silhouette_score, silhouette_sample
```
