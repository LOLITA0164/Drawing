//
//  DrawingBoardView.h
//  Drawing
//
//  Created by LOLITA on 17/6/21.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingBoardView : UIView


/**
 线的颜色
 */
@property (nonatomic, strong) UIColor *color;

/**
 线的宽度
 */
@property (nonatomic, assign) CGFloat lineWidth;

/**
 纪录存在的线条
 */
@property (nonatomic, strong) NSMutableArray *allLines;




/**
 撤销一条线
 */
-(void)revokeLine;

/**
 保存图片
 */
-(void)saveImage;

/**
 恢复一条线
 */
-(void)forwardLine;



@end
