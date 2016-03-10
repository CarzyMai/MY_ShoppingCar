//
//  ETShoppingCarController.m
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import "MY_ShoppingCarController.h"
#import "MY_ShoppingCarEndView.h"
#import "MY_ShoppingCarCell.h"
#import "MY_ShoppingCarHeaderView.h"
#import "MY_ShoppingCarManager.h"
#import "MY_KeyBordDoneView.h"
#import "MY_ShoppingCarModel.h"
#import "MY_ShoppingCarChangeNumberView.h"
#import "UIColor+Extend.h"

@interface MY_ShoppingCarController () <UITableViewDelegate, UITableViewDataSource, MY_ShoppingCarCellDelegate, MY_ShoppingCarHeaderViewDelegate, MY_ShoppingCarEndViewDelegate, MY_KeyboardDoneViewDelegate, UITextFieldDelegate> {
    int goodsCount; // 数量输入框改变的数量
    NSIndexPath *myIndexPath; // 数量输入框改变对应cell的位置
}

@property (nonatomic, strong) UITableView *tableView;    /**< RootTableView */
@property (nonatomic, strong) MY_ShoppingCarEndView *endView;    /**< 视图下方的View */
@property (nonatomic, strong) MY_ShoppingCarManager *dataManager;    /**< 数据管理者 */

@end

@implementation MY_ShoppingCarController

#pragma mark - 懒加载控件
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(250, 250, 250);
    }
    return _tableView;
}

- (MY_ShoppingCarEndView *)endView {
    if (!_endView) {
        _endView = [[MY_ShoppingCarEndView alloc] init];
        _endView.delegate = self;
    }
    return _endView;
}

- (MY_ShoppingCarManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [MY_ShoppingCarManager shareManager];
        _dataManager.endView = self.endView;
    }
    return _dataManager;
}

#pragma mark - 系统方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 添加键盘弹出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    // 添加键盘收起的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 移除所注册的通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [self.view endEditing:YES];
    MY_KeyBordDoneView *doneView = [self.view viewWithTag:1888];
    [doneView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
    [self requestData];
}

- (void)requestData {
    __block MY_ShoppingCarController *blockSelf = self;
    // 初始化数据，请求
    [self.dataManager acquireDataWithType:ShoppingCarTypeTTT target:self Success:^{
        // 添加控件
        [blockSelf.view addSubview:self.tableView];
        [blockSelf.view addSubview:self.endView];
        // 控件布局
        [blockSelf layoutSubviews];
    } error:^{
        // 错误处理
    }];
}

- (void)setNav {
    self.view.backgroundColor = hexColor(FAFAFA);
    
    self.navigationItem.title = @"购物车列表";
}

#pragma mark - 通知方法
/**
 *  键盘出现的通知方法
 */
- (void)keyboardShow:(NSNotification *)not {
    //获取键盘的高度
    NSDictionary *userInfo = [not userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    
    MY_KeyBordDoneView *doneView = [[MY_KeyBordDoneView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-AUTO_MATE_HEIGHT(100)-height, SCREEN_WIDTH, AUTO_MATE_HEIGHT(50))];
    doneView.alpha = 0;
    doneView.delegate = self;
    doneView.tag = 1888;
    [self.view addSubview:doneView];
    
    [UIView animateWithDuration:0.8 animations:^{
        doneView.alpha = 1;
    }];
}

/**
 *  键盘收起的通知方法
 */
- (void)keyboardHidden:(NSNotification *)not {
    MY_KeyBordDoneView *doneView = [self.view viewWithTag:1888];
    [doneView removeFromSuperview];
}

#pragma mark - tableview代理方法
/**
 *  @author Mai, 16-01-21 09:01:25
 *
 *  返回每个分区里的行数
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%ld",[self.dataManager getCurrentRowWithSection:section]);
    return [self.dataManager getCurrentRowWithSection:section];
}

/**
 *  @author Mai, 16-01-21 09:01:48
 *
 *  有多少个分区
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"%ld",[self.dataManager getCurrentSection]);
    return [self.dataManager getCurrentSection];
}
/**
 *  @author Mai, 16-01-21 09:01:04
 *
 *  在这里快速返回Cell显示在Tableview上，不做过多的数据逻辑处理
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_ShoppingCarCell *cell = [MY_ShoppingCarCell shoppingCarCellWithTableView:tableView];
    return cell;
}

/**
 *  @author Mai, 16-01-21 09:01:04
 *
 *  在这里做Cell的数据逻辑处理
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_ShoppingCarCell *shoppingCarCell = (MY_ShoppingCarCell *)cell;
    shoppingCarCell.delegate = self;
    shoppingCarCell.model = [self.dataManager getModelWithIndex:indexPath];
    shoppingCarCell.indexPath = indexPath;
}

/**
 *  @author Mai, 16-01-21 09:01:54
 *
 *  返回cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MY_ShoppingCarCell getCellHeight];
}

/**
 *  @author Mai, 16-01-21 09:01:04
 *
 *  在这里快速返回HeaderView显示在Tableview上，不做过多的数据逻辑处理
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MY_ShoppingCarHeaderView *headerView = [[MY_ShoppingCarHeaderView alloc] init];
    return headerView;
}

/**
 *  @author Mai, 16-01-21 09:01:04
 *
 *  在这里做HeaderView的数据逻辑处理
 */
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    MY_ShoppingCarHeaderView *headerView = (MY_ShoppingCarHeaderView *)view;
    headerView.delegate = self;
    headerView.tag = section+100;
    headerView.shopModel = [self.dataManager getTitleWithSection:section];
}

/**
 *  @author Mai, 16-01-21 09:01:54
 *
 *  返回HeaderView的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [MY_ShoppingCarHeaderView getHeaderViewHeight];
}

/**
 *  @author Mai, 16-01-21 09:01:54
 *
 *  返回FooterView的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - KeyBordDoneView代理方法
/**
 *  @author Mai, 16-03-01 18:03:51
 *
 *  键盘完成被点击
 */
- (void)keyBordDoneViewDoneButtonClick:(UIButton *)sender {
    [self.view endEditing:YES];
    [self.dataManager changeGoodsCountWithIndexPath:myIndexPath count:goodsCount success:^{
        _endView.selectGoodsArray = [self.dataManager getSelectGoods];
        [_tableView reloadData];
    } error:^{
        [_tableView reloadData];
    }];
}

#pragma mark - ShoppingCarEndView代理方法
/**
 *  @author Mai, 16-02-26 10:02:10
 *
 *  全选按钮被点击
 */
- (void)shoppingCarEndViewSelectButtonClicked:(UIButton *)sender {
    [self.dataManager didSelectAllBtn:sender.selected];
    _endView.selectGoodsArray = [self.dataManager getSelectGoods];
    [_tableView reloadData];
}

/**
 *  @author Mai, 16-02-26 10:02:10
 *
 *  结算按钮被点击
 */
- (void)shoppingCarEndViewClearingButtonClickedWithSelectGoodsArray:(NSMutableArray *)goodsArray {
    
    NSMutableArray *shopsArray = [NSMutableArray arrayWithArray:goodsArray];
    
    for (MY_ShoppingCarModel *shopModel in shopsArray) {
        
        NSMutableArray *goodsArray = [NSMutableArray arrayWithArray:shopModel.products];
        
        for (Products *goodsModel in goodsArray) {
            
            if (!goodsModel.select) {
                
                [shopModel.products removeObject:goodsModel];
                
            }
        }
    }
}

#pragma mark - ShoppingCarHeaderView代理方法
/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  分区头的选择按钮被点击
 */
- (void)shoppingCarHeaderViewSelectButtonClicked:(UIButton *)sender section:(NSInteger)section{
    [self.dataManager didSelectSectionWithSection:section senderSelect:sender.selected];
    _endView.selectGoodsArray = [self.dataManager getSelectGoods];
    [_tableView reloadData];
}

#pragma mark - ShoppingCarCell代理方法
/**
 *  @author Mai, 16-01-20 17:01:51
 *
 *  购物车Cell上的选择按钮被点击
 */
- (void)shoppingCarCellSelectButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath{
    [self.dataManager didSelectCellWithIndexPath:indexPath senderSelect:sender.selected];
    _endView.selectGoodsArray = [self.dataManager getSelectGoods];
    [_tableView reloadData];
}

/**
 *  @author Mai, 16-01-20 17:01:20
 *
 *  购物车Cell上的删除按钮被点击
 */
- (void)shoppingCarCellDeleteButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath{
    
    _endView.selectGoodsArray = [self.dataManager getSelectGoods];
    [self.dataManager deleteDataWithIndexPath:indexPath tableView:_tableView];
}

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量加按钮被点击
 */
- (void)shoppingCarCellAddButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath{
    [self.dataManager didSelectCellAddButtonWithIndexPath:indexPath success:^{
        self.endView.selectGoodsArray = [self.dataManager getSelectGoods];
        [_tableView reloadData];
    } error:^{
        [_tableView reloadData];
    }];
}

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量减按钮被点击
 */
- (void)shoppingCarCellSubtractButtonClicked:(UIButton *)sender indexPath:(NSIndexPath *)indexPath{
    [self.dataManager didSelectCellSubtractButtonWithIndexPath:indexPath success:^{
        _endView.selectGoodsArray = [self.dataManager getSelectGoods];
        [_tableView reloadData];
    } error:^{
        [_tableView reloadData];
    }];
}

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量输入框数量改变
 */
- (void)shoppingCarCellChangeCountText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    goodsCount = [text intValue];
    myIndexPath = indexPath;
}

#pragma mark - 控件布局
- (void)layoutSubviews {
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self.view);
        make.bottom.equalTo(_endView.mas_top);
    }];
    [_endView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.height.equalTo(@(AUTO_MATE_HEIGHT(50)));
    }];
}

@end
