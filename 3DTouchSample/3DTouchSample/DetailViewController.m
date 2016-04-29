//
//  DetailViewController.m
//  3DTouchSample
//
//  Created by RichardLeung on 15/10/31.
//  Copyright © 2015年 RL. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property(nonatomic,strong)UIImageView *imageViewShow;

@end

@implementation DetailViewController

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        self.title =title;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor redColor];
    UIImage *image =[UIImage imageNamed:self.title];
    _imageViewShow =[[UIImageView alloc]initWithImage:image];
    _imageViewShow.frame =self.view.bounds;
    [self.view addSubview:_imageViewShow];
}

- (NSArray <id <UIPreviewActionItem>> *)previewActionItems
{
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"赞" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了赞");
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"踩" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了踩");
    }];
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了取消");
    }];
    return @[action1, action2, action3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
