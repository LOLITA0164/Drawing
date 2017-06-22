//
//  ApplyTableCtrl.m
//  Drawing
//
//  Created by LOLITA on 17/6/22.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "ApplyTableCtrl.h"
#import "LoadingViewCtrl.h"     //自定义加载动画
#import "AlertCtrl.h"           //自定义弹窗
#import "DrawingBoardCtrl.h"    //画板

@interface ApplyTableCtrl ()

@property(strong,nonatomic)NSArray *items;

@end

@implementation ApplyTableCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = @[@[@"贝塞尔-动画",[LoadingViewCtrl class]],
               @[@"贝塞尔-自定义弹窗",[AlertCtrl class]],
               @[@"贝塞尔-画板",[DrawingBoardCtrl class]]];
    
    self.tableView.tableFooterView = [UIView new];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    NSArray *item = _items[indexPath.row];
    cell.textLabel.text = item.firstObject;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:[[_items[indexPath.row] lastObject] new] animated:YES];
    
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
