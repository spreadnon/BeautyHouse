//
//  BaseTableViewController.h
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import "BaseViewController.h"
#import "FooterLoadMoreView.h"

@interface BaseTableViewController : BaseViewController
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) FooterLoadMoreView *loadMoreView;

- (void)refresh;
- (void)loadMore;
- (void)endRefresh;

- (void)showFooterRefresh;
- (void)hideFooterRefresh;
@end
