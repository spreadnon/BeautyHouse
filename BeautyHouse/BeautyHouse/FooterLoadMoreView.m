//
//  FooterLoadMoreView.m
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import "FooterLoadMoreView.h"
#import "Masonry.h"
@implementation FooterLoadMoreView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:_activityView];
        
        _tipsLabel = [[UILabel alloc] initWithFrame:frame];
        _tipsLabel.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        _tipsLabel.text = @"没有更多数据";
        _tipsLabel.hidden = YES;
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor lightGrayColor];
        _tipsLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_tipsLabel];
        [_tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}

- (void)startAnimation{
    _activityView.hidden = NO;
    [_activityView startAnimating];
    _tipsLabel.hidden = YES;
}

- (void)stopAnimation{
    if (_activityView.isAnimating == NO){
        return;
    }
    _activityView.hidden = YES;
    [_activityView stopAnimating];
}

- (BOOL)isAnimating{
    return _activityView.isAnimating;
}

- (void)noMoreData{
    _tipsLabel.hidden = NO;
}

-(void)restartLoadData{
    _tipsLabel.hidden = YES;
}

@end
