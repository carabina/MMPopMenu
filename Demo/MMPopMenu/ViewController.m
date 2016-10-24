//
//  ViewController.m
//  MMPopMenu
//
//  Created by 夏伟 on 2016/10/20.
//  Copyright © 2016年 夏伟. All rights reserved.
//

#import "ViewController.h"
#import "MMMenu.h"
#import <UIColor-MMAdditions/UIColor+MMAdditions.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions
- (IBAction)popMenuAction:(id)sender {
    [self showTipsMenu];
}

- (IBAction)popMenuAction2:(id)sender {
    [self showSearchMenu];
}

- (void)showTipsMenu {
    if ([MMMenu isShowingInView:self.view]) {
        [MMMenu dismissMenu:YES];
    } else {
        [MMMenu setTitleFont:[UIFont systemFontOfSize:14]];
        [MMMenu setTintColor:[UIColor whiteColor]];
        [MMMenu setLineColor:[UIColor mm_colorWithRGBHexString:@"0xDDDDDD"]];

        NSArray *menuItems = @[
                               [MMMenuItem menuItem: @"查看全部" image:[UIImage imageNamed:@"tips_menu_icon_status"] target:self action:@selector(p_changeTipStatus)],
                               [MMMenuItem menuItem:@"全部标注已读" image:[UIImage imageNamed:@"tips_menu_icon_mkread"] target:self action:@selector(p_markReadAll)],
                               ];
        [menuItems setValue:[UIColor mm_colorWithRGBHexString:@"0x222222"] forKey:@"foreColor"];

        CGRect senderFrame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 26), 0, 0, 0);
        [MMMenu showMenuInView:self.view
                      fromRect:senderFrame
                     menuItems:menuItems];
    }
}

- (void)showSearchMenu {
    if ([MMMenu isShowingInView:self.view]) {
        [MMMenu dismissMenu:YES];
    } else {
        [MMMenu setTitleFont:[UIFont systemFontOfSize:14]];
        [MMMenu setTintColor:[UIColor whiteColor]];
        [MMMenu setLineColor:[UIColor mm_colorWithRGBHexString:@"0xDDDDDD"]];

        NSArray *menuItems = @[
                                       [MMMenuItem menuItem:@"共享链接" image:[UIImage imageNamed:@"file_menu_icon_share"] target:self action:@selector(goToShareFileLink)],
                                       [MMMenuItem menuItem:@"文件信息" image:[UIImage imageNamed:@"file_menu_icon_info"] target:self action:@selector(goToFileInfo)],
                                       [MMMenuItem menuItem:@"删除文件" image:[UIImage imageNamed:@"file_menu_icon_delete"] target:self action:@selector(deleteCurFile)],
                                       ];
        [menuItems setValue:[UIColor mm_colorWithRGBHexString:@"0x222222"] forKey:@"foreColor"];

        CGRect senderFrame = CGRectMake(26, 0, 0, 0);
        [MMMenu showMenuInView:self.view
                      fromRect:senderFrame
                     menuItems:menuItems];
    }
}

- (void)p_changeTipStatus {

}

- (void)p_markReadAll {

}

- (void)goToShareFileLink {

}

- (void)goToFileInfo {

}

- (void)deleteCurFile {

}

@end
