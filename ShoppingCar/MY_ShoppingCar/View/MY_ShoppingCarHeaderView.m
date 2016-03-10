//
//  MY_ShoppingCarHeaderView.m
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import "MY_ShoppingCarHeaderView.h"

#define kViewHeight AUTO_MATE_HEIGHT(42)

@interface MY_ShoppingCarHeaderView ()

@property (nonatomic, strong) UIView *lineView;    /**< 分割线 */
@property (nonatomic, strong) UIButton *selectBtn;    /**< 选择按钮 */
@property (nonatomic, strong) UIImageView *titleImg;    /**< 标题图片 */
@property (nonatomic, strong) UILabel *titleLab;    /**< 标题文字 */

@end

@implementation MY_ShoppingCarHeaderView

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = hexColor(FAFAFA);
        _lineView.layer.borderColor = hexColor(C8C7CC).CGColor;
        _lineView.layer.borderWidth = 0.3;
    }
    return _lineView;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(headerViewSelectButtonClicked:section:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    }
    return _selectBtn;
}

- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] init];
        _titleImg.image = [UIImage imageNamed:@"iconfont-SHOP-60x60"];
    }
    return _titleImg;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = systemFont(16);
    }
    return _titleLab;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = hexColor(FFFFFF);
        [self addSubview:self.lineView];
        [self addSubview:self.selectBtn];
        [self addSubview:self.titleImg];
        [self addSubview:self.titleLab];
    }
    return self;
}

/**
 *  @author Mai, 16-01-20 17:01:23
 *
 *  选择按钮被点击
 */
- (void)headerViewSelectButtonClicked:(UIButton *)sender section:(NSInteger)section{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarHeaderViewSelectButtonClicked:section:)]) {
        [self.delegate shoppingCarHeaderViewSelectButtonClicked:sender section:self.tag-100];
    }
}

- (void)setShopModel:(MY_ShoppingCarModel *)shopModel {
    _titleLab.text = shopModel.brandName;
    _selectBtn.selected = shopModel.select;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    int offsetX = (kViewHeight - AUTO_MATE_HEIGHT(30)) * 0.5;
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(10)));
    }];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(AUTO_MATE_HEIGHT(35)));
        make.left.equalTo(self).offset(AUTO_MATE_WIDTH(10));
        make.centerY.equalTo(self).offset(offsetX);
    }];
    [_titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(AUTO_MATE_HEIGHT(20)));
        make.left.equalTo(_selectBtn.mas_right).offset(AUTO_MATE_WIDTH(10));
        make.centerY.equalTo(self).offset(offsetX);
    }];
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleImg.mas_right).offset(AUTO_MATE_WIDTH(5));
        make.height.equalTo(@(AUTO_MATE_HEIGHT(20)));
        make.centerY.equalTo(self).offset(offsetX);
    }];
}

+ (CGFloat)getHeaderViewHeight {
    return kViewHeight;
}

@end
