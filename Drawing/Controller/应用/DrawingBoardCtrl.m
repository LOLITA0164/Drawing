//
//  DrawingBoardCtrl.m
//  Drawing
//
//  Created by LOLITA on 17/6/21.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "DrawingBoardCtrl.h"
#import "DrawingBoardView.h"

@interface DrawingBoardCtrl ()

@property(strong,nonatomic)DrawingBoardView *myView;

@end

@implementation DrawingBoardCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initUI];
}



-(void)initUI{
    
    self.view.backgroundColor = [UIColor grayColor];
    
    self.myView = [[DrawingBoardView alloc] initWithFrame:CGRectMake(10, 64+10, kScreenWidth-10*2, kScreenHeight*0.6)];
    self.myView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myView];
    
    
    self.ControlPanelView.frame = CGRectMake(10, self.myView.bottom, kScreenWidth-10*2, kScreenHeight-self.myView.bottom-10);
    [self.ControlPanelView adjustFrameWithX:NO Y:NO W:NO H:NO AdjustSubViews:YES];
    self.ControlPanelView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.ControlPanelView];
    
    
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

- (IBAction)Slider:(UISlider *)sender {
    self.myView.lineWidth = sender.value;
}

- (IBAction)SegmentControl:(UISegmentedControl *)sender {
    DLog(@"%ld",sender.selectedSegmentIndex);
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            self.myView.color = [UIColor redColor];
        }
            break;
        case 1:
        {
            self.myView.color = [UIColor blackColor];
        }
            break;
        case 2:
        {
            self.myView.color = [UIColor blueColor];
        }
            break;
        case 3:
        {
            self.myView.color = [UIColor yellowColor];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)RevokeBtn:(UIButton *)sender {
    [self.myView revokeLine];
}

- (IBAction)SaveBtn:(UIButton *)sender {
    [self.myView saveImage];
}

- (IBAction)ForwardBtn:(UIButton *)sender {
    [self.myView forwardLine];
}


@end
