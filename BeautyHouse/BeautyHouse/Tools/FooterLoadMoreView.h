//
//  FooterLoadMoreView.h
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FooterLoadMoreView : UICollectionReusableView
@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property (nonatomic, retain) UILabel *tipsLabel;

- (void)startAnimation;
- (void)stopAnimation;
- (BOOL)isAnimating;
- (void)noMoreData;
- (void)restartLoadData;
@end

NS_ASSUME_NONNULL_END
