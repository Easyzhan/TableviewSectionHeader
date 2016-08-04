//
//  FolderHeadView.h
//  CustomSectionHeader
//
//  Created by Vizard on 16/8/4.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#import <UIKit/UIKit.h>

/**不显示 或者不显示 DetailLabel */
typedef NS_ENUM(NSInteger, HeaderStyle){
    HeaderStyleNoneDetail,
    HeaderStyleWithDetail
};


@protocol FoldSectionHeaderViewDelegate <NSObject>

- (void)foldHeaderInSection:(NSInteger)SectionHeader;

@end

@interface FolderHeadView : UITableViewHeaderFooterView

@property(nonatomic, assign) BOOL fold;/**< 是否折叠 */
@property(nonatomic, assign) NSInteger section;/**< 选中的section */
@property(nonatomic, weak) id<FoldSectionHeaderViewDelegate> delegate;/**< 代理 */


- (void)setFoldSectionHeaderViewWithTitle:(NSString *)title detail:(NSString *)detail type:(HeaderStyle)type section:(NSInteger)section canFold:(BOOL)canFold;


@end
