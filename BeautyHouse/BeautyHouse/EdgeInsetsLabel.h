//
//  EdgeInsetsLabel.h
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, EdgeInsetsLabelTextAlignment) {
    EdgeInsetsLabelTextAlignment_None, //default
    EdgeInsetsLabelTextAlignment_Top,
    EdgeInsetsLabelTextAlignment_Down,
};

@interface EdgeInsetsLabel : UILabel
@property (nonatomic) UIEdgeInsets contentInset;
@property (nonatomic, assign) EdgeInsetsLabelTextAlignment alignment;
@end

NS_ASSUME_NONNULL_END
