//
//  DrawingCtrl.m
//  Drawing
//
//  Created by LOLITA on 17/6/20.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "DrawingCtrl.h"
#import "ApplyTableCtrl.h"
#import "UIBezierPathView.h"        //
#import "CoreGraphicsView.h"        //

@interface DrawingCtrl ()

@property (strong,nonatomic) UIBezierPathView *BezierPathView;
@property (strong,nonatomic) CoreGraphicsView *CoreGraphicsView;


@end

@implementation DrawingCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}


-(void)initUI{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.BezierPathView];

    [self.view addSubview:self.CoreGraphicsView];
    
    self.title = @"贝塞尔曲线/CGContextRef";
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    [rightBtn setTitle:@"应用" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    

}


-(void)rightBtnAction{
    ApplyTableCtrl *ctrl = [ApplyTableCtrl new];
    [self.navigationController pushViewController:ctrl animated:YES];
}




-(UIBezierPathView *)BezierPathView{
    if (_BezierPathView==nil) {
        _BezierPathView = [[UIBezierPathView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, (kScreenHeight-64)/2.0)];
        _BezierPathView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _BezierPathView;
}

-(CoreGraphicsView *)CoreGraphicsView{
    if (_CoreGraphicsView==nil) {
        _CoreGraphicsView = [[CoreGraphicsView alloc] initWithFrame:CGRectMake(0, self.BezierPathView.bottom, kScreenWidth, kScreenHeight-self.BezierPathView.viewHeight)];
        _CoreGraphicsView.backgroundColor = [UIColor whiteColor];
    }
    return _CoreGraphicsView;
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
