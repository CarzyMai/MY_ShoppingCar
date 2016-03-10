//
//  MY_KeyBordDoneView.h
//  ShoppingCar
//
//  Created by 麥展毅 on 16/2/26.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MY_KeyboardDoneViewDelegate <NSObject>

@optional
/**
 *  键盘完成按钮点击
 */
- (void)keyBordDoneViewDoneButtonClick:(UIButton *)sender;

@end

@interface MY_KeyBordDoneView : UIView
@property (nonatomic) id<MY_KeyboardDoneViewDelegate>delegate;
@end
