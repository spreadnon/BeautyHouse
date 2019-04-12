//
//  OrderTableCell.m
//  BeautyHouse
//
//  Created by iOS123 on 2019/4/12.
//  Copyright © 2019 iOS123. All rights reserved.
//

#import "OrderTableCell.h"
#import "Masonry.h"
#import "EdgeInsetsLabel.h"
@interface OrderTableCell()
@property (nonatomic,strong) UIImageView *mainImageView;
@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) EdgeInsetsLabel *typeLabel;
@property (nonatomic,strong) UIView *footerView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *houseLabel;
@property (nonatomic,strong) UILabel *addressLabel;
@end
@implementation OrderTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self buildUI];
    }
    return self;
}

- (void)buildUI{
    [self.contentView addSubview:self.mainImageView];
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.footerView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.houseLabel];
    [self.contentView addSubview:self.addressLabel];
    
    [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(280);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainImageView.mas_top).offset(20);
        make.left.equalTo(self.mainImageView.mas_left).offset(20);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mainImageView.mas_bottom).offset(-1);
        make.left.equalTo(self.mainImageView.mas_left).offset(1);
        make.right.equalTo(self.mainImageView.mas_right).offset(-1);
        make.height.mas_equalTo(80);
    }];
    
    [self.userImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.footerView.mas_top).offset(-20);
        make.left.equalTo(self.mainImageView.mas_left).offset(20);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mainImageView.mas_bottom).offset(-100);
        make.left.equalTo(self.userImageView.mas_right).offset(20);
        make.centerY.equalTo(self.userImageView.mas_centerY);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mainImageView.mas_bottom).offset(-20);
        make.left.equalTo(self.mainImageView.mas_left).offset(20);
    }];
    
    [self.houseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.addressLabel.mas_top).offset(-5);
        make.left.equalTo(self.mainImageView.mas_left).offset(20);
    }];
}

- (UIImageView *)mainImageView{
    if (!_mainImageView) {
        _mainImageView = [[UIImageView alloc]init];
        _mainImageView.backgroundColor = [self colorWithHex:0xf1f1f1 alpha:1.0];
        //添加边框
        CALayer * layer = [_mainImageView layer];
        layer.borderColor = [[UIColor lightGrayColor] CGColor];
        layer.borderWidth = 0.8f;
        //添加四个边阴影
        _mainImageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;//阴影颜色
        _mainImageView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
        _mainImageView.layer.shadowOpacity = 0.2;//不透明度
        _mainImageView.layer.shadowRadius = 1.0;//半径
        _mainImageView.layer.masksToBounds = YES;
        _mainImageView.layer.cornerRadius = 2;
    }
    return _mainImageView;
}

- (UIImageView *)userImageView{
    if (!_userImageView) {
        _userImageView = [[UIImageView alloc]init];
        _userImageView.backgroundColor = [UIColor blackColor];
        _userImageView.layer.masksToBounds = YES;
        _userImageView.layer.cornerRadius = 12;
    }
    return _userImageView;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]init];
        _footerView.backgroundColor = [UIColor whiteColor];
    }
    return _footerView;
}

- (EdgeInsetsLabel*)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[EdgeInsetsLabel alloc]init];
        _typeLabel.text = @"厨房";
        _typeLabel.layer.masksToBounds = YES;
        _typeLabel.layer.cornerRadius = 2;
        _typeLabel.font = [UIFont systemFontOfSize:10];
        _typeLabel.numberOfLines = 1;
        _typeLabel.backgroundColor = [UIColor whiteColor];
        _typeLabel.textColor = [UIColor blackColor];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
        _typeLabel.contentInset = UIEdgeInsetsMake(-5, -10, -5, -10);
    }
    return _typeLabel;
}

- (UILabel*)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.text = @"jeremychen";
        _nameLabel.font = [UIFont systemFontOfSize:13];
        _nameLabel.numberOfLines = 1;
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UILabel*)houseLabel{
    if (!_houseLabel) {
        _houseLabel = [[UILabel alloc]init];
        _houseLabel.text = @"jeremychen·s House";
        _houseLabel.font = [UIFont boldSystemFontOfSize:18];
        _houseLabel.numberOfLines = 1;
        _houseLabel.backgroundColor = [UIColor whiteColor];
        _houseLabel.textColor = [UIColor blackColor];
    }
    return _houseLabel;
}

- (UILabel*)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.text = @"Apple Software Upgrade Center (888) 840–8433";
        _addressLabel.font = [UIFont systemFontOfSize:13];
        _addressLabel.numberOfLines = 1;
        _addressLabel.backgroundColor = [UIColor whiteColor];
        _addressLabel.textColor = [UIColor blackColor];
    }
    return _addressLabel;
}


- (UIColor *)colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

@end
