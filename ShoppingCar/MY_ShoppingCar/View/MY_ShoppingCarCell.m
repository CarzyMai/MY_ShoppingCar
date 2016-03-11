//
//  MY_ShoppingCarCell.m
//  ShoppingCar
//
//  Created by 麥展毅 on 16/1/16.
//  Copyright © 2016年 麥展毅. All rights reserved.
//

#import "MY_ShoppingCarCell.h"


#define kCellHeight AUTO_MATE_HEIGHT(103)

@interface MY_ShoppingCarCell () <UITextFieldDelegate, MY_ShoppingCarChangeNumberViewDelegate> {
    NSInteger currentPrice; //现价
    NSInteger costPcice; //原价
    int stock; //库存
    NSIndexPath *thisIndexPath; //对应cell的位置
}
@end

@implementation MY_ShoppingCarCell

+ (MY_ShoppingCarCell *)shoppingCarCellWithTableView:(UITableView *)tableView {
    MY_ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[MY_ShoppingCarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])];
    }
    return cell;
}

+ (CGFloat)getCellHeight {
    return kCellHeight;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"Unselected"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"Selected"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(shoppingCarCellSelectButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _selectBtn.imageEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    }
    return _selectBtn;
}

- (UIImageView *)productImg {
    if (!_productImg) {
        _productImg = [[UIImageView alloc] init];
        _productImg.backgroundColor = [UIColor redColor];
    }
    return _productImg;
}

- (UILabel *)productNameLab {
    if (!_productNameLab) {
        _productNameLab = [[UILabel alloc] init];
        _productNameLab.font = systemFont(14);
        _productNameLab.numberOfLines = 0;
    }
    return _productNameLab;
}

- (UILabel *)sizeLab {
    if (!_sizeLab) {
        _sizeLab = [[UILabel alloc] init];
        _sizeLab.font = systemFont(10);
        _sizeLab.textColor = hexColor(AAAAAA);
        _sizeLab.numberOfLines = 0;
    }
    return _sizeLab;
}

- (UILabel *)costPriceLab {
    if (!_costPriceLab) {
        _costPriceLab = [[UILabel alloc] init];
        _costPriceLab.font = systemFont(12);
        _costPriceLab.textAlignment = NSTextAlignmentRight;
    }
    return _costPriceLab;
}

- (UILabel *)currentPriceLab {
    if (!_currentPriceLab) {
        _currentPriceLab = [[UILabel alloc] init];
        _currentPriceLab.font = systemFont(14);
        _currentPriceLab.textColor = hexColor(FF6600);
        _currentPriceLab.textAlignment = NSTextAlignmentRight;
    }
    return _currentPriceLab;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"iconfont-lajitong"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(shoppingCarCellDeleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton.backgroundColor = [UIColor greenColor];
    }
    return _deleteButton;
}

- (MY_ShoppingCarChangeNumberView *)changeView {
    if (!_changeView) {
        _changeView = [[MY_ShoppingCarChangeNumberView alloc] init];
        _changeView.delegate = self;
        _changeView.countTextField.delegate = self;
    }
    return _changeView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = hexColor(FAFAFA);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.selectBtn];
        [self.contentView addSubview:self.productImg];
        [self.contentView addSubview:self.productNameLab];
        [self.contentView addSubview:self.sizeLab];
        [self.contentView addSubview:self.costPriceLab];
        [self.contentView addSubview:self.currentPriceLab];
        [self.contentView addSubview:self.deleteButton];
        [self.contentView addSubview:self.changeView];
    }
    return self;
}

/**
 *  @author Mai, 16-01-20 17:01:33
 *
 *  重写set方法，对控件赋值
 */
- (void)setModel:(Products *)model {
    _model = model;
    currentPrice = model.productPrice;
    costPcice = model.originPrice;
    [_productImg sd_setImageWithURL:[NSURL URLWithString:[[model.productPicUri stringByAppendingString:@"@!product-list"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:[UIImage imageNamed:@"icon_default_lamp"]];
    _productNameLab.text = model.productName;
    _sizeLab.text = [NSString stringWithFormat:@"规格: %@",model.productNum];
    _costPriceLab.attributedText = [self disposeContentext:[NSString stringWithFormat:@"%ld元",model.originPrice]];
    _currentPriceLab.text = [NSString stringWithFormat:@"%ld元",currentPrice];
    _changeView.countTextField.text = [NSString stringWithFormat:@"%ld",model.productQty];
    //    _changeView.maxCount = [model.stock integerValue];
    _selectBtn.selected = model.select;
    //    stock = [model.stock intValue];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    thisIndexPath = indexPath;
}

/**
 *  @author Mai, 16-01-20 17:01:25
 *
 *  选择按钮被点击
 */
- (void)shoppingCarCellSelectButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarCellSelectButtonClicked:indexPath:)]) {
        [self.delegate shoppingCarCellSelectButtonClicked:sender indexPath:thisIndexPath];
    }
}

/**
 *  @author Mai, 16-01-20 17:01:50
 *
 *  删除按钮被点击
 */
- (void)shoppingCarCellDeleteButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarCellDeleteButtonClicked:indexPath:)]) {
        [self.delegate shoppingCarCellDeleteButtonClicked:sender indexPath:thisIndexPath];
    }
}

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量加按钮被点击
 */
- (void)shoppingCarChangeNumberViewAddButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarCellAddButtonClicked:indexPath:)]) {
        [self.delegate shoppingCarCellAddButtonClicked:sender indexPath:thisIndexPath];
    }
}

/**
 *  @author Mai, 16-01-20 17:01:30
 *
 *  数量减按钮被点击
 */
- (void)shoppingCarChangeNumberViewSubtractButtonClicked:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarCellSubtractButtonClicked:indexPath:)]) {
        [self.delegate shoppingCarCellSubtractButtonClicked:sender indexPath:thisIndexPath];
    }
}

#pragma mark - textField代理方法
/**
 *  @author Mai, 16-12-30 19:12:33
 *
 *  判断用户输入数量是否大于存库数量或为0,以及加减button是否能被点击
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([textField.text intValue] > 99) {
        textField.text = @"99";
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(shoppingCarCellChangeCountText:indexPath:)]) {
        [self.delegate shoppingCarCellChangeCountText:textField.text indexPath:thisIndexPath];
    }
}

/**
 *  @author Mai, 16-01-20 17:01:22
 *
 *  控件布局
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(AUTO_MATE_WIDTH(10));
        make.height.width.equalTo(@(AUTO_MATE_HEIGHT(35)));
        make.centerY.equalTo(self.contentView);
    }];
    [_productImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_selectBtn.mas_right).offset(AUTO_MATE_WIDTH(5));
        make.centerY.equalTo(self.contentView);
        make.height.width.equalTo(@(AUTO_MATE_HEIGHT(75)));
    }];
    [_productNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(AUTO_MATE_HEIGHT(11));
        make.width.equalTo(@(AUTO_MATE_WIDTH(110)));
        make.height.equalTo(@(AUTO_MATE_HEIGHT(25)));
        make.left.equalTo(_productImg.mas_right).offset(AUTO_MATE_WIDTH(10));
    }];
    [_sizeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_productNameLab.mas_bottom).offset(AUTO_MATE_HEIGHT(5));
        make.left.equalTo(_productImg.mas_right).offset(AUTO_MATE_WIDTH(10));
        make.width.equalTo(@(AUTO_MATE_WIDTH(85)));
        make.height.equalTo(@(AUTO_MATE_HEIGHT(20)));
    }];
    [_costPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_productNameLab);
        make.right.equalTo(self.contentView).offset(AUTO_MATE_WIDTH(-10));
        make.width.equalTo(@(AUTO_MATE_WIDTH(50)));
        make.height.equalTo(@(AUTO_MATE_WIDTH(10)));
    }];
    [_currentPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_sizeLab);
        make.right.equalTo(self.contentView).offset(AUTO_MATE_WIDTH(-10));
        make.width.equalTo(@(AUTO_MATE_WIDTH(60)));
        make.height.equalTo(@(AUTO_MATE_WIDTH(10)));
    }];
    [_changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(AUTO_MATE_WIDTH(85)));
        make.height.equalTo(@(AUTO_MATE_WIDTH(20)));
        make.left.equalTo(_productImg.mas_right).offset(AUTO_MATE_WIDTH(10));
        make.bottom.equalTo(self.contentView).offset(-AUTO_MATE_HEIGHT(12));
    }];
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(AUTO_MATE_WIDTH(15)));
        make.height.equalTo(@(AUTO_MATE_WIDTH(15)));
        make.left.equalTo(self.contentView).offset(AUTO_MATE_WIDTH(287));
        make.centerY.equalTo(_changeView);
    }];
}

/**
 *  @author Mai, 16-01-16 15:01:15
 *
 *  丰富文本
 *
 *  @param string 原价
 *
 *  @return 原价加横线
 */
- (NSAttributedString *)disposeContentext:(NSString *)string {
#warning 在iOS8下 删除线设置之后不出现  需要在初始化的地方进行设置一下删除线格式为默认  (iOS 8.1 BUG)
    //    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:string attributes:@ {NSStrikethroughStyleAttributeName: @ (NSUnderlineStyleNone)}];
    
    //删除线格式
    [attrString addAttribute:NSStrikethroughStyleAttributeName
                       value:@(NSUnderlineStyleSingle)
                       range:[string rangeOfString:[NSString stringWithFormat:@"%ld元", costPcice]]];
    //删除线颜色
    [attrString addAttribute:NSStrikethroughColorAttributeName
                       value:[UIColor colorWithRed:0.502  green:0.502  blue:0.502 alpha:1.0]
                       range:[string rangeOfString:[NSString stringWithFormat:@"%ld元", costPcice]]];
    
    return attrString;
}

@end
