//
//  AlertCtrl.m
//  Drawing
//
//  Created by LOLITA on 17/6/22.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "AlertCtrl.h"
#import "CustomAlertView.h"

@interface AlertCtrl ()

@property(strong,nonatomic)CustomAlertView *popView;

@end

@implementation AlertCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
    
}


-(void)initUI{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [self.view adjustFrame];
    self.clickBtn.center = self.view.center;
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)clickBtn:(UIButton *)sender {
    
    self.popView = [[CustomAlertView alloc] initPoint:CGPointMake(self.clickBtn.centerX, self.clickBtn.bottom) datas:@[@"苹果",@"香蕉",@"菠萝"]];
    [self.popView show];
    
}




@end
