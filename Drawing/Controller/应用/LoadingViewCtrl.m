//
//  LoadingViewCtrl.m
//  Drawing
//
//  Created by LOLITA on 17/6/22.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "LoadingViewCtrl.h"
#import "LoadingView.h"

@interface LoadingViewCtrl ()

@property(strong,nonatomic)LoadingView *loadingView;

@end

@implementation LoadingViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}


-(void)initUI{
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.loadingView.center = self.view.center;
    [self.view addSubview:self.loadingView];
    [self.loadingView startLoading];
    
    
    WS(ws);
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(100.0/*延迟执行时间*/ * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [ws.loadingView stopLoading];
    });
    
}




-(LoadingView *)loadingView{
    if (_loadingView==nil) {
        _loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
        _loadingView.backgroundColor = [UIColor clearColor];
    }
    return _loadingView;
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
