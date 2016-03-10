//
//  MY_ShoppingCarModel.h
//  ETao
//
//  Created by AVGD－Mai on 16/3/1.
//  Copyright © 2016年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Products;
@interface MY_ShoppingCarModel : NSObject

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, strong) NSMutableArray<Products *> *products;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic) BOOL select;

@end

@interface Products : NSObject

@property (nonatomic, copy) NSString *productId;

@property (nonatomic, copy) NSString *productNum;

@property (nonatomic, copy) NSString *productType;

@property (nonatomic, copy) NSString *cartId;

@property (nonatomic, copy) NSString *specLength;

@property (nonatomic, copy) NSString *productName;

@property (nonatomic, copy) NSString *brandPicUri;

@property (nonatomic, assign) NSInteger originPrice;

@property (nonatomic, strong) NSArray *productDetailPicUirs;

@property (nonatomic, assign) NSInteger productPrice;

@property (nonatomic, copy) NSString *brandId;

@property (nonatomic, copy) NSString *productPicUri;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger productQty;

@property (nonatomic, copy) NSString *specWidth;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, copy) NSString *specHeight;

@property (nonatomic) BOOL select;

@end

