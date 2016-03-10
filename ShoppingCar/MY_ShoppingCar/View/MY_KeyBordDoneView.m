//
//  MY_KeyBordDoneView.m
//  ShoppingCar
//
//  Created by 麥展毅 on 16/2/26.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import "MY_KeyBordDoneView.h"

@interface MY_KeyBordDoneView ()
@property (nonatomic, strong) UIButton *doneButton;
@end

@implementation MY_KeyBordDoneView

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneButton.layer.borderColor = hexColor(FF6600).CGColor;
        _doneButton.layer.borderWidth = 0.5f;
        _doneButton.layer.cornerRadius = 3;
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [_doneButton setTitleColor:hexColor(FF6600) forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _doneButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.doneButton];
    }
    return self;
}

- (void)doneButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(keyBordDoneViewDoneButtonClick:)]) {
        [self.delegate keyBordDoneViewDoneButtonClick:sender];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_doneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(AUTO_MATE_HEIGHT(5));
        make.height.equalTo(@(AUTO_MATE_HEIGHT(30)));
        make.right.equalTo(self).offset(AUTO_MATE_WIDTH(-10));
        make.width.equalTo(@(AUTO_MATE_WIDTH(50)));
    }];
}

@end
