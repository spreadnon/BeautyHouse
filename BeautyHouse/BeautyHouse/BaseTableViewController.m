//
//  BaseTableViewController.m
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Masonry.h"
#import "ProductViewController.h"

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    //下拉
    [self.tableView addSubview:self.refreshControl];
    //上拉
    self.loadMoreView = [[FooterLoadMoreView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
    self.tableView.tableFooterView = self.loadMoreView;
}


- (void)refresh{}
- (void)loadMore{}
- (void)endRefresh{
}

- (void)showFooterRefresh{}
- (void)hideFooterRefresh{}

#pragma mark tableView代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellIdentifier = @"cellIdentifier";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"封装成了对象";
    cell.detailTextLabel.text = @"这里有个坑";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    /*self.refreshControl.isRefreshing == NO加这个条件是为了防止下面的情况发生：
     每次进入UITableView，表格都会沉降一段距离，这个时候就会导致currentOffsetY + scrollView.frame.size.height   > scrollView.contentSize.height 被触发，从而触发loadMore方法，而不会触发refresh方法。
     */
    if ( currentOffsetY + scrollView.frame.size.height  > scrollView.contentSize.height &&  self.refreshControl.isRefreshing == NO  && self.loadMoreView.isAnimating == NO && self.loadMoreView.tipsLabel.isHidden ){
        [self.loadMoreView startAnimation];//开始旋转菊花
        [self loadMore];
    }
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 100;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        _refreshControl.tintColor = [UIColor grayColor];
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
        [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (FooterLoadMoreView *)loadMoreView{
    if (!_loadMoreView) {
        self.loadMoreView = [[FooterLoadMoreView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        self.tableView.tableFooterView = self.loadMoreView;
    }
    return _loadMoreView;
}

@end
