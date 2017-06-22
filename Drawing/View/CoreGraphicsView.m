//
//  CoreGraphicsView.m
//  Drawing
//
//  Created by LOLITA on 17/6/20.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "CoreGraphicsView.h"

@implementation CoreGraphicsView

/*
 
 {
 drawRect方法什么时候触发
 
 1.当view第一次显示到屏幕上时；
 2.当调用view的setNeedsDisplay或者setNeedsDisplayInRect:方法时。
 
 }
 
 */





-(void)drawRect:(CGRect)rect
{
    
    [super drawRect:rect];
    
    /*
     1.先在drawRect方法中获得上下文context；
     2.绘制图形（线，图形，图片等）；
     3.设置一些修饰属性；
     4.渲染到上下文，完成绘图。
     */
    
    
    //1.获取图形上下文，即画板
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //2.绘制图形
    
    /*****************************矩形*****************************/
    {
        CGContextAddRect(ctx, CGRectMake(10, 10, 40, 40));
        //3.设置相关属性
        [RandColor set];                    //颜色  CGContextSetStrokeColorWithColor(ctx, RandColor.CGColor);
        CGContextSetLineCap(ctx, kCGLineCapRound);      //起点和重点圆角
        CGContextSetLineJoin(ctx, kCGLineJoinRound);    //转角圆角
        CGContextSetLineWidth(ctx, 5);      //线条到宽度
        //4.渲染到画板上
        CGContextStrokePath(ctx);           //空心的
//        CGContextFillPath(ctx);             //填充路径（实心的）
    }
    
    
    
    /*****************************圆弧/圆*****************************/
    {
        CGContextAddArc(ctx, 100, 30, 30, 0, M_PI, 0);         //最后一个参数表示方向（顺时针或者逆时针）
        CGContextSetLineWidth(ctx, 2);                          //线条到宽度
        CGContextStrokePath(ctx);                               //半圆弧
//        CGContextFillPath(ctx);                                 //填充路径 半圆
    }
    
    
    
    /*****************************椭圆*****************************/
    CGContextAddEllipseInRect(ctx, CGRectMake(150, 10, 80, 40));        //在矩形内绘制椭圆
    CGContextStrokePath(ctx);                                           //空心
//    CGContextFillPath(ctx);                                           //实心
    
    
    CGContextAddEllipseInRect(ctx, CGRectMake(230, 20, 60, 60));        //在矩形内部绘制圆形  －－  画圆和画椭圆方法一样，椭圆只是设置不同的长宽
//    CGContextStrokePath(ctx);                                           //空心
    CGContextFillPath(ctx);                                             //实心
    
    
    /*****************************直线*****************************/
    CGContextMoveToPoint(ctx, 10, 120);                                 //起点
    CGContextAddLineToPoint(ctx, kScreenWidth-10, 120);                 //其他点
    //其他设置
    CGContextSetRGBStrokeColor(ctx, 0, 1, 0, 1);                        //RGB类型的颜色
    CGContextSetLineCap(ctx, kCGLineCapSquare);                         //起点和重点
    CGContextSetLineJoin(ctx, kCGLineJoinBevel);                        //转角
    CGContextSetLineWidth(ctx, 5);                                      //线条的宽度
    CGContextStrokePath(ctx);                                           //直线只能绘制空心的，不能调用CGContextFillPath(ctx)

    
    
    /*****************************使用直线绘制其他图形（可以不规则）*****************************/
    CGContextMoveToPoint(ctx, 20, 200);                                     //设置直线
    CGContextAddLineToPoint(ctx, 60, 150);
    CGContextAddLineToPoint(ctx, 80, 200);
    CGContextSetLineWidth(ctx, 5);                                          //线条的宽度
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextClosePath(ctx);                                                //起点和终点链接起来
    CGContextSetFillColorWithColor(ctx, [UIColor redColor].CGColor);        //设置填充色
    CGContextSetStrokeColorWithColor(ctx, [UIColor brownColor].CGColor);    //路径颜色
    CGContextDrawPath(ctx, kCGPathFillStroke);                              //fill  and  stroke
    /*
     kCGPathFill,
     kCGPathEOFill,
     kCGPathStroke,
     kCGPathFillStroke,
     kCGPathEOFillStroke
     */
    
    
    
    /*****************************绘制图片*****************************/
    UIImage *img = [UIImage imageNamed:@"QQ"];
    [img drawAtPoint:CGPointMake( 150, 145)];                                         //绘制到指定的点，图片size
//    [img drawInRect:CGRectMake(120, 140, img.size.width, img.size.height)];             //指定位置大小
//    [img drawAsPatternInRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight/2.0)];      //多个平铺
    
    
    
    
    
    /*****************************绘制文字*****************************/
    NSString *str = @"少年不识愁滋味，为赋新词强说愁\n而今识得愁滋味，却道天凉好个秋";
    //设置文字属性
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    NSDictionary *dic = @{NSForegroundColorAttributeName:RandColor,
                          NSFontAttributeName:[UIFont systemFontOfSize:BigSize],
                          NSParagraphStyleAttributeName:style};
    //绘制
    CGSize size = [str sizeWithAttributes:dic];
    CGRect strRect = CGRectMake((kScreenWidth-size.width)/2.0, 220, size.width, size.height);
    [str drawWithRect:strRect options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    
    
    
    
    CGContextAddRect(ctx, strRect);
    CGContextSetLineWidth(ctx, 1);
    [RandColor set];
    CGContextStrokePath(ctx);
    
    
    
    
    
    
    
    
    
    /*****************************绘制一个带边框的圆*****************************/
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextSetFillColorWithColor(ctx, [UIColor brownColor].CGColor);
    CGContextAddEllipseInRect(ctx, CGRectMake(250, 150, 50, 50));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
    
    
    
    
}


















@end
