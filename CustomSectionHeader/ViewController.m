//
//  ViewController.m
//  CustomSectionHeader
//
//  Created by Vizard on 16/8/4.
//  Copyright © 2016年 Vizard. All rights reserved.
//

#import "ViewController.h"
#import "FolderHeadView.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, FoldSectionHeaderViewDelegate>

@property(nonatomic, strong) UITableView* tableView;/**< tableview */
@property(nonatomic, strong) NSArray* array;/**< 数组 */
@property(nonatomic, strong) NSDictionary* foldInfoDic;/**< 存储开关字典 */


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self creatArray];
    [self creatTableView];
}

- (void)creatArray {
    _array = @[@"小乔",@"大乔",@"甄姬",@"蔡文姬",@"鲍三娘",@"貂蝉",@"祝融",@"孙尚香"];
    _foldInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                   @"0":@"1",
                                                                   @"1":@"1",
                                                                   @"2":@"1",
                                                                   @"3":@"0"
                                                                   }];
}

- (void)creatTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    
    if (section == 0) {
        return folded?_array.count:0;
    } else if (section == 1) {
        return folded?_array.count-5:0;
    } else if (section == 2) {
        return folded?_array.count:0;
    } else {
        return folded?_array.count:0;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FolderHeadView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!headerView) {
        headerView = [[FolderHeadView alloc] initWithReuseIdentifier:@"header"];
    }
    
    if (section == 0) {
        [headerView setFoldSectionHeaderViewWithTitle:@"吕布貂蝉" detail:@"9999" type: HeaderStyleWithDetail section:0 canFold:YES];
    } else if (section == 1) {
        [headerView setFoldSectionHeaderViewWithTitle:@"蜀国一身正气" detail:@"nil" type:HeaderStyleWithDetail section:1 canFold:YES];
    } else if (section == 2){
        [headerView setFoldSectionHeaderViewWithTitle:@"魏国甄姬" detail:@"90k" type:HeaderStyleWithDetail section:2 canFold:YES];
    } else {
        [headerView setFoldSectionHeaderViewWithTitle:@"东吴二乔" detail:@"777" type:HeaderStyleWithDetail section:3 canFold:YES];
    }
    headerView.delegate = self;
    NSString *key = [NSString stringWithFormat:@"%d", (int)section];
    BOOL folded = [[_foldInfoDic valueForKey:key] boolValue];
    headerView.fold = folded;
    return headerView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_array objectAtIndex:indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)foldHeaderInSection:(NSInteger)SectionHeader {
    NSString *key = [NSString stringWithFormat:@"%d",(int)SectionHeader];
    BOOL folded = [[_foldInfoDic objectForKey:key] boolValue];
    NSString *fold = folded ? @"0" : @"1";
    [_foldInfoDic setValue:fold forKey:key];
    NSMutableIndexSet *set = [[NSMutableIndexSet alloc] initWithIndex:SectionHeader];
    [_tableView reloadSections:set withRowAnimation:UITableViewRowAnimationLeft];
    
}
@end
