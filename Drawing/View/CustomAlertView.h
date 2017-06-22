//
//  CustomAlertView.h
//  Drawing
//
//  Created by LOLITA on 17/6/22.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertView : UIView

/**
 边框颜色
 */
@property(nonatomic,copy)UIColor *borderColor;

/**
 填充色
 */
@property(nonatomic,copy)UIColor *fillColor;

-(instancetype)initPoint:(CGPoint)point datas:(NSArray *)datas;

-(void)show;

-(void)dismiss;


@end
