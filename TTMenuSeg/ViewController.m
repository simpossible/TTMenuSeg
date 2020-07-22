//
//  ViewController.m
//  TTMenuSeg
//
//  Created by simp on 2020/7/15.
//  Copyright © 2020 simp. All rights reserved.
//

#import "ViewController.h"

#import "TTMenuSeg.h"
#import "TTMenuSegLabelDecrator.h"
#import "TTMenuSeqTestCell.h"
#import "SimpleUseController.h"
#import "DecoratorTestControllerViewController.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MENU SEG";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
                
    // Do any additional setup after loading the view.
}


#pragma mark - tableview


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return TTMenuSeqFunTypeCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTMenuSeqTestCell *cell = (TTMenuSeqTestCell *)[tableView dequeueReusableCellWithIdentifier:@"seq"];
    if (!cell) {
        cell = [[TTMenuSeqTestCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"seq"];
        cell.funcType = indexPath.row;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TTMenuSeqFunType type = indexPath.row;
    if (type == TTMenuSeqFunTypeBase) {
        [self.navigationController pushViewController:[[SimpleUseController alloc] init] animated:YES];
    }else if (type == TTMenuSeqFunTypeDecorater) {
        [self.navigationController pushViewController:[[DecoratorTestControllerViewController alloc] init] animated:YES];
    }
}

@end
