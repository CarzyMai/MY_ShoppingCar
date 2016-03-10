//
//  MY_ShoppingCarEndView.h
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MY_ShoppingCarEndViewDelegate <NSObject>

@optional
/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  全选按钮被点击
 */
- (void)shoppingCarEndViewSelectButtonClicked:(UIButton *)sender;

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  全选按钮被点击
 */
- (void)shoppingCarEndViewClearingButtonClickedWithSelectGoodsArray:(NSMutableArray *)goodsArray;

@end

@interface MY_ShoppingCarEndView : UIView
@property (nonatomic) id<MY_ShoppingCarEndViewDelegate>delegate;
@property (nonatomic, strong) NSMutableArray *selectGoodsArray;    /**< 选择的商品 */
@property (nonatomic, strong) UIButton *selectBtn;    /**< 选择按钮 */
@end
