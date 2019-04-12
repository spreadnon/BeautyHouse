//
//  UIControl+Block.h
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (Block)
- (void)addActionforControlEvents:(UIControlEvents)controlEvents Completion:(void (^)(void))completion;
@end

NS_ASSUME_NONNULL_END
