//
//  UIBezierPathView.m
//  Drawing
//
//  Created by LOLITA on 17/6/20.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "UIBezierPathView.h"

//      UIBezierPath位于UIKit库中, 是针对Core Graphics库中的CGPathRef的封装

@implementation UIBezierPathView

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
     1.创建对象
     2.设置相关属性
     3.渲染
     */
    
    UIBezierPath *path;
    
    //创建一个对象
    {
        path = [UIBezierPath bezierPath];
    }

    
    //矩形
    {
        //1.创建对象
        path  = [UIBezierPath bezierPathWithRect:CGRectMake(10, 20, 40, 40)];
        //2.设置相关属性
        path.lineCapStyle   = kCGLineCapRound;      //终点线条形状
        path.lineJoinStyle  = kCGLineJoinRound;     //连接处的形状
        path.lineWidth      = 5;                    //宽度
        [RandColor set];
        //3.渲染
        [path stroke];                              //完成绘制
    }
    
    
    //椭圆 －－ 宽高相等则为圆形
    {
        
        // 参数一: 矩形范围
        path  = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(80, 20, 80, 40)];
        path.lineWidth      = 5;                    //宽度
        [[UIColor redColor] setFill];
        [path fillWithBlendMode:kCGBlendModeNormal alpha:0.2];
    }
    
    
    
    //圆角矩形  －－  圆角大小为矩形一半时则为圆形
    {
        // 参数一: 矩形范围
        // 参数二: 圆角半径, 如果半径大于矩形短边的一半, 则按照一半处理

        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(200, 20, 50, 50) cornerRadius:10];
        path.lineWidth      = 5;                    //宽度
        [RandColor set];
        [path stroke];
    }
    
    
    //圆角可选矩形  －－ UIRectCornerAllCorners则为圆角矩形
    {
        // 参数一: 矩形范围
        // 参数二: 圆弧位置, 可以多选
        // 参数三: 圆弧半径
        path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 100, 50, 50) byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 20)];
        path.lineWidth      = 10;                    //宽度
        /*
         路径的终点形状, 该属性适用于开放路径的起点和终点, 默认为kCGLineCapButt(方形结束, 结束位置正好为精确位置), 其他可选项为kCGLineCapRound(圆形结束, 结束位置超过精确位置半个线宽)和kCGLineCapSquare(方形结束, 结束位置超过精确位置半个线宽)
         */
        path.lineCapStyle   = kCGLineCapSquare;         //线条终点形状
        path.lineJoinStyle  = kCGLineJoinRound;         //连接处形状
        [RandColor set];
        [path stroke];
        [RandColor setFill];
        [path fill];
    }
    
    
    //圆弧
    {
        // 参数一: 圆弧圆心
        // 参数二: 圆弧半径
        // 参数三: 开始弧度
        // 参数四: 结束弧度
        // 参数五: 是否为顺时针
        path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(180, 150) radius:50 startAngle:M_PI endAngle:0 clockwise:YES];
        path.lineWidth      = 5;                    //宽度
        [RandColor set];
        [path stroke];
    }
    
    
    
    //已知路径
    {
        path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(250, 150)];
        [path addLineToPoint:CGPointMake(kScreenWidth-10, 150)];
        UIBezierPath * pathNew = [UIBezierPath bezierPathWithCGPath:path.CGPath];
        pathNew.lineWidth = 5;
        [RandColor setStroke];
        [pathNew stroke];
    }
    

    
    
    
    
    
    //路径中－－－增加圆弧
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(20, 200)];        //起点
        path.lineWidth = 5;
        // 参数一: 圆弧圆心
        // 参数二: 圆弧半径
        // 参数三: 开始弧度
        // 参数四: 结束弧度
        // 参数五: 是否为顺时针
        [path addArcWithCenter:CGPointMake(80, 200) radius:40 startAngle:M_PI endAngle:0 clockwise:NO];
        [path addLineToPoint:CGPointMake(140, 200)];
        [path stroke];
    }
    
    
    //路径中－－－增加二次贝塞尔曲线
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 5;
        [path moveToPoint:CGPointMake(160, 200)];         //起点
        // 参数一: 曲线的终点位置
        // 参数二: 控制点
        [path addQuadCurveToPoint:CGPointMake(200, 200) controlPoint:CGPointMake(170, 150)];
        [path stroke];
    }
    
    
    //路径中－－－增加三次贝塞尔曲线
    {
        UIBezierPath *path = [UIBezierPath bezierPath];
        path.lineWidth = 5;
        DLog(@"---%@",path.empty?@"YES":@"NO");
        [path moveToPoint:CGPointMake(220, 230)];
        // 参数一: 曲线的终点位置
        // 参数二: 第一控制点
        // 参数三: 第二控制点
        [path addCurveToPoint:CGPointMake(300, 180) controlPoint1:CGPointMake(240, 100) controlPoint2:CGPointMake(250, 300)];
        [path closePath];
        [RandColor setStroke];
        [path stroke];
        [RandColor setFill];
        [path fill];
        
        
//        [path removeAllPoints];       //清除掉路径中所有的点，（已经渲染到画布上的图形是不受到影响的，只是路径上的点被清楚了）
        
        
        DLog(@"+路径是否为空:%@",path.empty?@"YES":@"NO");         //路径是否为空
        DLog(@"%@",NSStringFromCGRect(path.bounds));    // 封闭所有路径点的最小矩形范围 , 不包括控制点
        DLog(@"当前点:%@",NSStringFromCGPoint(path.currentPoint));
        CGPoint point = CGPointMake(225, 245);
        DLog(@"+封闭路径中是否包含点%@:%@",NSStringFromCGPoint(point),[path containsPoint:point]?@"YES":@"NO");
        
        
        
        //新增一个路径
        UIBezierPath *linePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(210, 160, 100, 78)];
        [path appendPath:linePath];
        [path stroke];
        
    }
    
    
    
    // 路径反转－－－当前路径的起点作为当前点
    {

        [path moveToPoint:CGPointMake(20, 280)];
        [path addLineToPoint:CGPointMake(40, 280)];
        
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        [path1 addArcWithCenter:CGPointMake(60, 280) radius:20 startAngle:M_PI endAngle:0 clockwise:YES];
        [path appendPath:path1];

        path = [path bezierPathByReversingPath];            // 路径反转  当前路径的起点作为当前点
        
        [path addLineToPoint:CGPointMake(50, 300)];
        
        path.lineWidth = 5;
        [[UIColor redColor] setStroke];
        
        [path stroke];
        
    }
    
    
    // 应用形变，位移，缩放
    {
        UIBezierPath * path1 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 260, 50, 50)];
        path1.lineWidth = 3;
        [[UIColor redColor] setStroke];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(30, -100);
        [path1 applyTransform:transform];
        [path1 stroke];
    }
    
    
}








































@end
