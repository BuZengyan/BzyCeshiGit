//
//  ViewController.m
//  3DTouchSample
//
//  Created by RichardLeung on 15/10/31.
//  Copyright © 2015年 RL. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>

@property(nonatomic,strong)UITableView *tableViewList;
@property(nonatomic,strong)NSArray *arrayData;

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"复仇者";
    
    [self.view addSubview:self.tableViewList];
    
    //注册3d-touch代理
    [self registerPreview];
    
    //判断是不是从快捷方式（UIMutableApplicationShortcutItem）点击进入的
    [self shortCut];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shortCut) name:@"ShortCut" object:nil];
}

-(void)shortCut
{
    if ([_shortcutName length]>0) {
        [self.navigationController popToViewController:self animated:NO];
        DetailViewController *detailVC =[[DetailViewController alloc]initWithTitle:self.shortcutName];
        [self.navigationController pushViewController:detailVC animated:NO];
    }
}

-(void)registerPreview
{
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:self.tableViewList];
    }
    else {
        NSLog(@"该设备不支持3D-Touch");
    }
}

#pragma mark - UIViewControllerPreviewingDelegate
//轻按peek
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获取点击的indexPath
    NSIndexPath * indexPath =[_tableViewList indexPathForRowAtPoint:location];
    
    UITableViewCell * cell = [_tableViewList cellForRowAtIndexPath:indexPath];
    if (!cell) {
        return nil;
    }
    DetailViewController *detailVC =[[DetailViewController alloc]initWithTitle:[self.arrayData objectAtIndex:indexPath.row]];
    detailVC.preferredContentSize = CGSizeMake(0, 0);
    //即将预览时显示高清的位置，其他位置被毛玻璃覆盖
    previewingContext.sourceRect = cell.frame;
    return detailVC;
}

//重按peek
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self.navigationController pushViewController:viewControllerToCommit animated:NO];
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text =[self.arrayData objectAtIndex:indexPath.row];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailVC =[[DetailViewController alloc]initWithTitle:[self.arrayData objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:detailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma mark - Getter
- (NSArray *)arrayData
{
    if (!_arrayData) {
        _arrayData =@[@"钢铁侠",@"雷神",@"黑寡妇",@"美国队长"];
    }
    return _arrayData;
}

- (UITableView *)tableViewList
{
    if (!_tableViewList) {
        _tableViewList =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableViewList.delegate =self;
        _tableViewList.dataSource =self;
        _tableViewList.tableFooterView =[[UIView alloc]init];
        [_tableViewList registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
    }
    return _tableViewList;
}

@end
