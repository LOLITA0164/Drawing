//
//  DrawingBoardView.m
//  Drawing
//
//  Created by LOLITA on 17/6/21.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "DrawingBoardView.h"

@interface DrawingBoardView()

/**
 贝塞尔对象
 */
@property(nonatomic, strong) UIBezierPath *bezierPath;

/**
 被撤销的线
 */
@property(nonatomic, strong) NSMutableArray *revokeLines;

@end


@implementation DrawingBoardView


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        
        
    }
    
    return self;
}

-(UIColor *)color{
    if (_color==nil) {
        _color = [UIColor redColor];
    }
    return _color;
}

-(CGFloat)lineWidth{
    if (_lineWidth==0) {
        _lineWidth = 3;
    }
    return _lineWidth;
}

-(NSMutableArray *)allLines{
    if (_allLines==nil) {
        _allLines = [NSMutableArray array];
    }
    return _allLines;
}

-(NSMutableArray *)revokeLines{
    if (_revokeLines==nil) {
        _revokeLines = [NSMutableArray array];
    }
    return _revokeLines;
}





/**
 撤销操作
 */
-(void)revokeLine{
    if (self.allLines.count) {
        [self.revokeLines addObject:self.allLines.lastObject];
        [self.allLines removeLastObject];
        [self setNeedsDisplay];
    }
}


-(void)forwardLine{
    if (self.revokeLines.count){
        [self.allLines addObject:self.revokeLines.lastObject];
        [self.revokeLines removeLastObject];
        [self setNeedsDisplay];
    }
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.bezierPath = [UIBezierPath bezierPath];
    
    UITouch *touch = [touches anyObject];
    //获取触摸位置,贝塞尔的起点
    CGPoint point = [touch locationInView:self];
    [self.bezierPath moveToPoint:point];
    
    //构造线条信息
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:self.color forKey:@"color"];
    [tempDic setObject:[NSNumber numberWithFloat:self.lineWidth] forKey:@"lineWidth"];
    [tempDic setObject:self.bezierPath forKey:@"line"];
    
    //将线条的信息加到数组中去
    [self.allLines addObject:tempDic];
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    //获取触摸位置,线条其他的点
    CGPoint point = [touch locationInView:self];
    [self.bezierPath addLineToPoint:point];
    
    NSLog(@"移动到点：%@",NSStringFromCGPoint(point));
    
    [self setNeedsDisplay];
}




-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    DLog(@"有%ld条线",self.allLines.count);
    
    [self.allLines enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIColor *color = obj[@"color"];
        CGFloat width = [obj[@"lineWidth"] floatValue];
        UIBezierPath *path = obj[@"line"];
        
        [color setStroke];
        [path setLineWidth:width];
        [path stroke];
        
    }];
    
}





-(void)saveImage{
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(newImage , nil, nil, nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片成功"
                                                    message:@"您已将照片存储于图片库中，打开照片程序即可查看。"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}















@end
