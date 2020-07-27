//
//  SimpleUseController.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/22.
//  Copyright © 2020 simp. All rights reserved.
//

#import "SimpleUseController.h"

#import "TTMenuSeg.h"
#import "TTMenuSegLabelDecrator.h"


@interface SimpleUseController ()<UIScrollViewDelegate,TTMenuSegDelegate>

@property (nonatomic, strong) TTMenuSeg * segs;

@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation SimpleUseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 500)];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(1000, 500);
    
    self.title = @"基础使用";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    TTMenuSegItem *item = [[TTMenuSegItem alloc] init];
    item.fontName = @"PingFangSC-Semibold";
    item.selectFontSize = 24;
    item.defaultFontSize = 16;
    item.title = @"推荐";
    item.outWidth = 300;
    item.inset = UIEdgeInsetsMake(0, 6, 0, 6);
    
    UIView *v = [[UIView alloc] init];
    v.frame = CGRectMake(0, 0, 300, 300);
    v.backgroundColor = [UIColor orangeColor];
    [self.scrollView addSubview:v];
    
    
    TTMenuSegItem *item1 = [[TTMenuSegItem alloc] init];
    item1.fontName = @"PingFangSC-Semibold";
    item1.selectFontSize = 24;
    item1.defaultFontSize = 16;
    item1.title = @"最新";
    item1.outWidth = 200;
    v = [[UIView alloc] init];
    v.frame = CGRectMake(300,0 , 200, 300);
    v.backgroundColor = [UIColor redColor];
    [self.scrollView addSubview:v];
    
    
    TTMenuSegItem *item2 = [[TTMenuSegItem alloc] init];
    item2.fontName = @"PingFangSC-Semibold";
    item2.selectFontSize = 24;
    item2.defaultFontSize = 16;
    item2.title = @"热门信息";
    item2.outWidth = 100;
    v = [[UIView alloc] init];
    v.frame = CGRectMake( 500,0, 100, 300);
    v.backgroundColor = [UIColor blueColor];
    [self.scrollView addSubview:v];
    
    TTMenuSegItem *item3 = [[TTMenuSegItem alloc] init];
    item3.fontName = @"PingFangSC-Semibold";
    item3.selectFontSize = 24;
    item3.defaultFontSize = 16;
    item3.title = @"更多";
    item3.outWidth = 250;
    v = [[UIView alloc] init];
    v.frame = CGRectMake(600,0, 250, 300);
    v.backgroundColor = [UIColor yellowColor];
    [self.scrollView addSubview:v];
    
    self.segs = [[TTMenuSeg alloc] initWithItems:@[item,item1,item2,item3]];
//        self.segs = [TTMenuSeg ttDefaultSegWithStrings:@[@"推荐",@"热门",@"最新"]];
    self.segs.frame = CGRectMake(0,0, self.view.bounds.size.width, 64);
    
    [self.view addSubview:self.segs];
    
    self.segs.backgroundColor = [UIColor whiteColor];
    self.segs.delegate = self;
    [self.segs setOutOff:0];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.segs setOutOff:scrollView.contentOffset.x];
}

- (void)ttMenuSegItemSelected:(TTMenuSegItem *)item {
    [self.scrollView setContentOffset:(CGPointMake(item.expectOutOff, 0))];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
