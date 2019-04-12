//
//  OrderViewController.m
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableCell.h"
@interface OrderViewController ()
@property (nonatomic,strong) NSMutableArray *dataArr;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self addData];
}

-(void)refresh{
    [self.refreshControl endRefreshing];
    self.loadMoreView.tipsLabel.hidden = YES;
}

- (void)loadMore{
    [self addData];
    [self.loadMoreView stopAnimation];//数据加载成功后停止旋转菊花
    if (self.dataArr.count > 60) {//当数据条目大于60的时候，提示没有更多数据。如果是网络数据，那么就是服务器没有数据返回的时候触发该方法
        [self.loadMoreView noMoreData];
    }
}

//加载数据
- (void)addData{
    NSDate *date = [[NSDate alloc]init];
    for (int i = 0; i < 20; i++) {
        [self.dataArr addObject:date];
    }
    [self.tableView reloadData];
}

#pragma mark tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width,  10.0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"OrderTableCell";
    OrderTableCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[OrderTableCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
//    cell.textLabel.text = @"封装成了对象";
//    cell.detailTextLabel.text = @"这里有个坑";
    return cell;
}


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArr;
}

@end
