//
//  LoadingView.m
//  Drawing
//
//  Created by LOLITA on 17/6/22.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "LoadingView.h"
#define degree 10.0     //两根线之间的角度

@interface LoadingView()

@property(strong,nonatomic)ItemView *leftView;
@property(strong,nonatomic)ItemView *middleView;
@property(strong,nonatomic)ItemView *rightView;
@property(strong,nonatomic)NSTimer *timer;

@end


@implementation LoadingView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        double ratio  = sin( degree/180.0 * M_PI);
        
        double radius = self.viewHeight*ratio/(1+ratio) *1.0;
        
        self.middleView.frame = CGRectMake(0, -self.viewHeight, radius*2, self.viewHeight*2);
        self.middleView.centerX = self.centerX;
        [self addSubview:self.middleView];
        
        self.leftView.frame = self.middleView.frame;
        self.leftView.transform = CGAffineTransformMakeRotation(ratio*3);
        [self addSubview:self.leftView];
        
        self.rightView.frame = self.middleView.frame;
        self.rightView.transform = CGAffineTransformMakeRotation(-ratio*2);
        [self addSubview:self.rightView];
        
        
        
        UIView *circle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 4)];
        circle.center = CGPointMake(self.centerX, 0);
        circle.backgroundColor = RandColor;
        circle.layer.cornerRadius = circle.viewHeight/2.0;
        circle.layer.masksToBounds = YES;
        [self addSubview:circle];
        
    }
    return self;
}



-(void)startLoading{
    [self.timer setFireDate:[NSDate date]];
}


-(void)stopLoading{
    [self.timer invalidate];
    self.timer = nil;
    [self removeFromSuperview];
}




-(NSTimer *)timer{
    if (_timer==nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeatAction) userInfo:nil repeats:YES];
    }
    return _timer;
}

-(void)repeatAction{
    
    double ratio  = sin( degree/180.0 * M_PI);
    CGFloat time = 0.25;
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.leftView.transform = CGAffineTransformMakeRotation(ratio*2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:time delay:time*2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.leftView.transform = CGAffineTransformMakeRotation(ratio*3);
        } completion:nil];
    }];
    
    
    
    [UIView animateWithDuration:time delay:time options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.rightView.transform = CGAffineTransformMakeRotation(-ratio*3);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.rightView.transform = CGAffineTransformMakeRotation(-ratio*2);
        } completion:nil];
    }];
}



-(ItemView *)leftView{
    if (_leftView==nil) {
        _leftView = [ItemView new];
        _leftView.backgroundColor = [UIColor clearColor];
    }
    return _leftView;
}

-(ItemView *)middleView{
    if (_middleView==nil) {
        _middleView = [ItemView new];
        _middleView.backgroundColor = [UIColor clearColor];
    }
    return _middleView;
}

-(ItemView *)rightView{
    if (_rightView==nil) {
        _rightView = [ItemView new];
        _rightView.backgroundColor = [UIColor clearColor];
    }
    return _rightView;
}



@end















@implementation ItemView


-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    double ballDiameter = self.bounds.size.width;     //小球直径径
    double ballRadius = ballDiameter / 2.0;                //小球半径

    CGPoint fixPoint = CGPointMake(self.bounds.size.width/2.0, 0);
    
    UIBezierPath *middlePath = [UIBezierPath bezierPath];
    [middlePath moveToPoint:fixPoint];
    [middlePath addLineToPoint:CGPointMake(fixPoint.x, self.bounds.size.height - ballDiameter)];
    [middlePath addArcWithCenter:CGPointMake(middlePath.currentPoint.x, middlePath.currentPoint.y+ballRadius) radius:ballRadius-0.8 startAngle:M_PI*3/2.0 endAngle:M_PI*7/2.0 clockwise:YES];
    [RandColor set];
    [middlePath fill];
    [middlePath stroke];
    
}


@end
