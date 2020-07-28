# TTMenuSeg

代码地址:[src](https://github.com/simpossible/TTMenuSeq)

滑动渐变标题是目前UI经常使用的，TTMenuSeg 封装了进度逻辑，并可根据进度进行自定义渐变

#### TTMenuSeg的基础使用
![](https://github.com/simpossible/TTMenuSeq/raw/master/doc/gif_menu.gif)

#### CocoaPods 导入
`pod 'TTMenuSeg','0.0.1'`

##### Code:
```
    self.segs = [TTMenuSeg ttDefaultSegWithStrings:@[@"推荐",@"热门",@"最新"]];
    self.segs.frame = CGRectMake(0,0, self.view.bounds.size.width, 64);
    [self.view addSubview:self.segs];
```

#### 如何自定义menu

1. 创建item
```
    TTMenuSegItem *item = [[TTMenuSegItem alloc] init];
    item.fontName = @"PingFangSC-Semibold"; //这里是item使用的字体
    item.selectFontSize = 24; //处于选中状态的字体大小
    item.defaultFontSize = 16; //处于非选中状态的字体大小
    item.title = @"推荐"; // 标题
    item.outWidth = 300; // 这个 item 所对应的外部滚动区域的大小 - scrollview 的content page
    item.inset = UIEdgeInsetsMake(0, 6, 0, 6); //标题的左右间距 上下没有实现
    [item setSelectedColor:0.12 g:0.12 b:0.13 a:1]; //选中颜色 可选 左边默认值
    [item setDefaultColor:0.6 g:0.64 b:0.7 a:1]; //默认颜色 可选 左边为默认值 

```
2. 将item 组装为数组创建menuseg
```
    self.segs = [[TTMenuSeg alloc] initWithItems:@[item,item1,item2,item3]];
    self.segs.frame = CGRectMake(0,0, self.view.bounds.size.width, 64);
    [self.view addSubview:self.segs];
```

3. 设置滚动的偏移量 偏移量与item的 outWidth 是相同的概念
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segs setOutOff:scrollView.contentOffset.x]; 
}
```

#### 拓展功能
1. 装饰，很多时候我们需要在标题下方或者其他地方添加一个小数字等
```
    TTMenuSegLabelDecrator *dec = [[TTMenuSegLabelDecrator alloc] init]; //创建一个装饰
    dec.postion = CGPointMake(1, 0.5); //设置装饰的位置 X = title.height * x  Y= title.width * y 这里是相对与title宽高布局
    dec.fontName = @"PingFangSC-Regular";    //装饰的字体
    dec.selectFontSize = 12; //同上
    dec.defaultFontSize = 10; //同上
    dec.content = @"哇"; //内容

    self.segs = [[TTMenuSeg alloc] initWithItems:@[item,item1,item2,item3]]; //创建好menuseg
    self.segs.frame = CGRectMake(0,146, self.view.bounds.size.width, 64); 
    [self.view addSubview:self.segs];
    [item addDecrator:dec]; //设置装饰
```
效果如下:

![](https://github.com/simpossible/TTMenuSeq/raw/master/doc/menuseg_dec.gif)


#release 0.0.1 更新
支持长于头部的多个title场景滚动

![](https://github.com/simpossible/TTMenuSeg/blob/master/doc/menguseg_scroll.gif)