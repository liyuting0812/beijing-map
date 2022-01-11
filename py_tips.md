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
```

```python
#使用字典替换数值
data['col']=car_price['col'].replace({'two':2,'three':3,"four":4,'six':6,"five":5,"eight":8,"twelve":12})
```

```python
#去重查看 set元组去重特性
print(set(data["cols"]))
#去重drop_duplicated
print(data[''].drop_duplicates())
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

