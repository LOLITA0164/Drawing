//
//  DrawingBoardCtrl.h
//  Drawing
//
//  Created by LOLITA on 17/6/21.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingBoardCtrl : UIViewController

@property (strong, nonatomic) IBOutlet UIView *ControlPanelView;


- (IBAction)Slider:(UISlider *)sender;

- (IBAction)SegmentControl:(UISegmentedControl *)sender;

- (IBAction)RevokeBtn:(UIButton *)sender;

- (IBAction)SaveBtn:(UIButton *)sender;

- (IBAction)ForwardBtn:(UIButton *)sender;


@end
