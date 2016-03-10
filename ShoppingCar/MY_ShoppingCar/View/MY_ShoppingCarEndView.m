//
//  MY_ShoppingCarEndView.m
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import "MY_ShoppingCarEndView.h"
#import "MY_ShoppingCarModel.h"

@interface MY_ShoppingCarEndView ()
@property (nonatomic, strong) UILabel *allLab;    /**< 全选文字 */
@property (nonatomic, strong) UILabel *priceLab;    /**< 总价文字 */
@property (nonatomic, strong) UIButton *settlementBtn;    /**< 结算按钮 */
@end

@implementation MY_ShoppingCarEndView

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_selectBtn setBackgroundImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _selectBtn;
}

- (UILabel *)allLab {
    if (!_allLab) {
        _allLab = [[UILabel alloc] init];
        _allLab.text = @"全选";
        _allLab.font = [UIFont systemFontOfSize:16];
        _allLab.textAlignment = NSTextAlignmentCenter;
    }
    return _allLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [[UILabel alloc] init];
        _priceLab.text = @"合计:0.00元";
        _priceLab.font = [UIFont systemFontOfSize:16];
        _priceLab.textAlignment = NSTextAlignmentRight;
    }
    return _priceLab;
}

- (UIButton *)settlementBtn {
    if (!_settlementBtn) {
        _settlementBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settlementBtn.backgroundColor = hexColor(FF6600);
        [_settlementBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_settlementBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_settlementBtn addTarget:self action:@selector(settlementBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
    return _settlementBtn;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.selectBtn];
        [self addSubview:self.allLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.settlementBtn];
    }
    return self;
}

- (void)setSelectGoodsArray:(NSMutableArray *)selectGoodsArray {
    _selectGoodsArray = selectGoodsArray;
    NSInteger allCount = 0; //总数
    float price = 0.f;//总价
    for (MY_ShoppingCarModel *shopModel in selectGoodsArray) {
        for (Products *goodsModel in shopModel.products) {
            if (goodsModel.select) {
                price += (goodsModel.productQty * goodsModel.productPrice);
                allCount += goodsModel.productQty;
            }
        }
    }
    _priceLab.text = [NSString stringWithFormat:@"合计:%.2f",price];
    [_settlementBtn setTitle:[NSString stringWithFormat:@"结算(%ld)",allCount] forState:UIControlStateNormal];
}

- (void)selectBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarEndViewSelectButtonClicked:)]) {
        [self.delegate shoppingCarEndViewSelectButtonClicked:sender];
    }
}

- (void)settlementBtnClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarEndViewClearingButtonClickedWithSelectGoodsArray:)]) {
        [self.delegate shoppingCarEndViewClearingButtonClickedWithSelectGoodsArray:_selectGoodsArray];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(AUTO_MATE_HEIGHT(20)));
        make.left.equalTo(self).offset(AUTO_MATE_WIDTH(20));
        make.top.equalTo(self).offset(AUTO_MATE_HEIGHT(15));
    }];
    [_allLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectBtn.mas_right).offset(AUTO_MATE_WIDTH(5));
        make.height.equalTo(@(AUTO_MATE_HEIGHT(20)));
        make.width.equalTo(@(AUTO_MATE_WIDTH(35)));
        make.top.equalTo(self).offset(AUTO_MATE_HEIGHT(15));
    }];
    [_settlementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.right.top.bottom.equalTo(self);
        make.width.equalTo(@(AUTO_MATE_WIDTH(100)));
    }];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectBtn.mas_right).offset(AUTO_MATE_WIDTH(20));
        make.height.equalTo(@(AUTO_MATE_HEIGHT(20)));
        make.right.equalTo(_settlementBtn.mas_left).offset(-10);
        make.top.equalTo(self).offset(AUTO_MATE_HEIGHT(15));
    }];
    
}

@end
