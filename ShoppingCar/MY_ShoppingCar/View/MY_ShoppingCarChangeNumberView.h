//
//  MY_ShoppingCarChangeNumberView.h
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MY_ShoppingCarChangeNumberViewDelegate <NSObject>

@optional
/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量加按钮被点击
 */
- (void)shoppingCarChangeNumberViewAddButtonClicked:(UIButton *)sender;

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量减按钮被点击
 */
- (void)shoppingCarChangeNumberViewSubtractButtonClicked:(UIButton *)sender;

@end

@interface MY_ShoppingCarChangeNumberView : UIView

+ (CGFloat)getChangeNumberViewHeight;

+ (CGFloat)getChangeNumberViewWidth;

@property (nonatomic) NSInteger count;    /**< 数量 */
@property (nonatomic) NSInteger maxCount;    /** 最大数量 */
@property (nonatomic, strong) UITextField *countTextField;    /**< 数量 */
@property (nonatomic, strong) UIButton *addButton;    /**< 加按钮 */
@property (nonatomic, strong) UIButton *subtractButton;    /**< 减按钮 */

@property (nonatomic) id<MY_ShoppingCarChangeNumberViewDelegate>delegate;

@end
