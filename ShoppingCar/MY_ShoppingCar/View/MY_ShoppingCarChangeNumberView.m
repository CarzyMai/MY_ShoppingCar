//
//  MY_ShoppingCarChangeNumberView.m
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import "MY_ShoppingCarChangeNumberView.h"

#define kViewHeight AUTO_MATE_HEIGHT(20)
#define kViewWidth AUTO_MATE_WIDTH(85)

@interface MY_ShoppingCarChangeNumberView () {
    NSInteger thisCount;
}

@end

@implementation MY_ShoppingCarChangeNumberView

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_normal"] forState:UIControlStateNormal];
        [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_no"] forState:UIControlStateDisabled];
        [_addButton addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _addButton;
}

- (UIButton *)subtractButton {
    if (!_subtractButton) {
        _subtractButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subtractButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_normal"] forState:UIControlStateNormal];
        [_subtractButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_no"] forState:UIControlStateDisabled];
        [_subtractButton addTarget:self action:@selector(subtractButtonClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _subtractButton;
}

- (UITextField *)countTextField {
    if (!_countTextField) {
        _countTextField = [[UITextField alloc] init];
        _countTextField.textAlignment = NSTextAlignmentCenter;
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        _countTextField.clipsToBounds = YES;
        _countTextField.font = [UIFont systemFontOfSize:14];
        _countTextField.backgroundColor = [UIColor whiteColor];
        _countTextField.text = @"1";
    }
    return _countTextField;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = hexColor(C8C7CC).CGColor;
        self.layer.borderWidth = 1;
        [self addSubview:self.addButton];
        [self addSubview:self.subtractButton];
        [self addSubview:self.countTextField];
    }
    return self;
}

- (void)addBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarChangeNumberViewAddButtonClicked:)])  {
        [self.delegate shoppingCarChangeNumberViewAddButtonClicked:sender];
    }
}

- (void)subtractButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarChangeNumberViewSubtractButtonClicked:)])  {
        [self.delegate shoppingCarChangeNumberViewSubtractButtonClicked:sender];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_subtractButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(@(AUTO_MATE_HEIGHT(20)));
    }];
    [_countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.width.equalTo(@(AUTO_MATE_WIDTH(45)));
        make.left.equalTo(_subtractButton.mas_right);
    }];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(@(AUTO_MATE_HEIGHT(20)));
    }];
}

+ (CGFloat)getChangeNumberViewWidth {
    return kViewWidth;
}

+ (CGFloat)getChangeNumberViewHeight {
    return kViewHeight;
}

@end
