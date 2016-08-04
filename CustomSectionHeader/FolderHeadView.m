//
//  FolderHeadView.m
//  CustomSectionHeader
//
//  Created by Vizard on 16/8/4.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#define SCREENSIZE [UIScreen mainScreen].bounds.size

#import "FolderHeadView.h"

@implementation FolderHeadView
{
    BOOL _created;/**< 是否创建过 */
    UILabel *_titleLabel;/**< 标题 */
    UILabel *_detailLabel;/**< 其他内容 */
    UIImageView *_imageView;/**< 图标 */
    UIButton *_btn;/**< 收起按钮 */
    BOOL _canFold;/**< 是否可展开 */
    
}

- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail type:(HeaderStyle)type section:(NSInteger)section canFold:(BOOL)canFold {
    if (!_created) {
        [self creatUI];
    }
    _titleLabel.text = title;
    if (type == HeaderStyleNoneDetail) {
        _detailLabel.hidden = YES;
    } else {
        _detailLabel.hidden = NO;
        _detailLabel.attributedText = [self attributeStringWith:detail];
    }
    _section = section;
    _canFold = canFold;
    if (canFold) {
        _imageView.hidden = NO;
    } else {
        _imageView.hidden = YES;
    }
}

- (NSMutableAttributedString *)attributeStringWith:(NSString *)money {
    NSString *str = [NSString stringWithFormat:@"妹子指数:%@", money];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:money];
    [ats setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:range];
    return ats;
}

- (void)creatUI {
    _created = YES;
    
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 90, 30)];
    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.layer.cornerRadius = 15;
    _titleLabel.clipsToBounds = YES;
    _titleLabel.adjustsFontSizeToFitWidth= YES;
    [self.contentView addSubview:_titleLabel];
    
    //其他内容
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(105, 5, 320-40, 30)];
    //    _detailLabel.backgroundColor = [UIColor greenColor];
    _detailLabel.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_detailLabel];
    
    //按钮
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(0, 0, SCREENSIZE.width, 30);
    //    _btn.backgroundColor = [UIColor redColor];
    [_btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btn];
    
    //图片
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREENSIZE.width - 30, 15, 15, 15)];
    _imageView.image = [UIImage imageNamed:@"fingerprint_lockscreen_icon"];
    [self.contentView addSubview:_imageView];
    
    //线
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, SCREENSIZE.width, 1)];
    line.image = [UIImage imageNamed:@"line"];
    [self.contentView addSubview:line];
}

- (void)setFold:(BOOL)fold {
    _fold = fold;
    if (fold) {
        _imageView.image = [UIImage imageNamed:@"fingerprint_lockscreen_icon"];
    } else {
        _imageView.image = [UIImage imageNamed:@"APC_yellow_acc"];
    }
}

#pragma mark = 按钮点击事件
- (void)btnClick:(UIButton *)btn {
    if (_canFold) {
        if ([self.delegate respondsToSelector:@selector(foldHeaderInSection:)]) {
            [self.delegate foldHeaderInSection:_section];
        }
    }
}
@end
