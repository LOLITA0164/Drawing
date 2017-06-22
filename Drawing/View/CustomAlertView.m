//
//  CustomAlertView.m
//  Drawing
//
//  Created by LOLITA on 17/6/22.
//  Copyright © 2017年 LOLITA. All rights reserved.
//

#import "CustomAlertView.h"
#define kArrowHeight 10.f  //箭头高度 = 箭头到宽度
#define kArrowCurvature 5.f   //弯曲度
#define SPACE 2.f   //边距
#define scale [UIScreen mainScreen].bounds.size.height/667.0
#define ROW_HEIGHT 44*scale  //cell头部行高
#define TITLE_FONT [UIFont systemFontOfSize:16*scale]  //字体大小
#define RGB(r, g, b)    [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.f]
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

NSString *const cellId = @"cellId";

@interface CustomAlertView ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *table;

@property(strong,nonatomic)NSArray *datas;

@property (nonatomic) CGPoint showPoint;

@property (nonatomic, strong) UIButton *handerView;

@end

@implementation CustomAlertView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(instancetype)initPoint:(CGPoint)point datas:(NSArray *)datas{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.datas =  datas;
        self.showPoint = point;
        
        self.frame = [self getFrame];
        
        [self addSubview:self.table];
        
    }
    return self;
}


/**
 计算frame
 */
-(CGRect)getFrame{
    
    CGRect frame = CGRectZero;
    
    //获取高度
    CGFloat height = (self.datas.count) * ROW_HEIGHT + kArrowHeight;
    height = MIN(SCREEN_HEIGHT/3.0, height);
    
    //获取宽度
    CGFloat width = 0.0;
    for (NSString *value in self.datas) {
        CGSize size = [value sizeWithAttributes:@{NSFontAttributeName:TITLE_FONT}];
        width = MAX(size.width, width);
    }
    
    
    frame.size.height = height;
    frame.size.width = width + 10*2 + 20;
    frame.origin.x = self.showPoint.x - frame.size.width/2.0;
    frame.origin.y = self.showPoint.y;
    
    
    //限制边缘距离
    if (frame.origin.x <=5 ) {
        frame.origin.x = 5;
    }
    if (frame.origin.x + frame.size.width > SCREEN_WIDTH - 5) {
        frame.origin.x = SCREEN_WIDTH - 5 - frame.size.width;
    }
    
    return frame;
    
}


-(UITableView *)table{
    if (_table==nil) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(SPACE, kArrowHeight+SPACE, self.frame.size.width-SPACE*2, self.frame.size.height-kArrowHeight-SPACE*2)];
        _table.tableFooterView = [UIView new];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = [UIColor clearColor];
        _table.showsVerticalScrollIndicator = NO;
    }
    return _table;
}


#pragma mark - UITableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
 
    cell.textLabel.font = TITLE_FONT;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.datas[indexPath.row];
    
    //分割线满格
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ROW_HEIGHT;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    //消失
    [self dismiss];
    
}






#pragma mark - 显示
-(void)show{
    
    self.handerView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_handerView setFrame:[UIScreen mainScreen].bounds];
    [_handerView setBackgroundColor:[UIColor clearColor]];
    [_handerView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_handerView addSubview:self];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:_handerView];
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:_handerView];
    self.layer.anchorPoint = CGPointMake(arrowPoint.x / self.frame.size.width, arrowPoint.y / self.frame.size.height);
    self.frame = [self getFrame];
    self.alpha = 0.f;
    self.transform = CGAffineTransformMakeScale(0.001, 0.001);
    [UIView animateWithDuration:0.2f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
        self.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.transform = CGAffineTransformIdentity;  //sacle 比例为  1
        } completion:nil];
    }];
    
}



#pragma mark - 消失
-(void)dismiss{
    [UIView animateWithDuration:0.3f animations:^{
        self.transform = CGAffineTransformMakeScale(0.001, 0.001);
    } completion:^(BOOL finished) {
        [_handerView removeFromSuperview];
    }];
}




-(UIColor *)borderColor{
    if (_borderColor==nil) {
        _borderColor = [UIColor blueColor];
    }
    return _borderColor;
}


-(UIColor *)fillColor{
    if (_fillColor==nil) {
        _fillColor = [UIColor whiteColor];
    }
    return _fillColor;
}



-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGRect frame = CGRectMake(0, kArrowHeight, self.bounds.size.width, self.bounds.size.height - kArrowHeight );
    
    float xMin = CGRectGetMinX(frame);
    float yMin = CGRectGetMinY(frame);
    float xMax = CGRectGetMaxX(frame);
    float yMax = CGRectGetMaxY(frame);
    
    CGPoint arrowPoint = [self convertPoint:self.showPoint fromView:self.handerView];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(xMin, yMin)];
    [path addLineToPoint:CGPointMake(arrowPoint.x - kArrowHeight, yMin)];
    [path addCurveToPoint:arrowPoint
            controlPoint1:CGPointMake(arrowPoint.x - kArrowHeight + kArrowCurvature, yMin)
            controlPoint2:arrowPoint];
    [path addCurveToPoint:CGPointMake(arrowPoint.x + kArrowHeight, yMin)
            controlPoint1:arrowPoint
            controlPoint2:CGPointMake(arrowPoint.x + kArrowHeight - kArrowCurvature, yMin)];
    [path addLineToPoint:CGPointMake(xMax, yMin)];
    [path addLineToPoint:CGPointMake(xMax, yMax)];
    [path addLineToPoint:CGPointMake(xMin, yMax)];
    [path closePath];
    
    //填充色
    [self.fillColor setFill];
    [path fill];
    //线条颜色
    [self.borderColor setStroke];
    [path stroke];
    
    
}






@end
