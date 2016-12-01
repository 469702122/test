//
//  DrawView.m
//  01-画板
//
//  Created by xiaomage on 16/11/8.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "DrawView.h"

@interface DrawView ()

//1.一个路径只能对应一个状态
//2.想要有多种状态.分批次进行绘制.逐个进行绘制.


/** 当前绘制的路径 */
@property (nonatomic, strong) UIBezierPath *path;

/** 保存当前绘制的所有路径 */
@property (nonatomic, strong) NSMutableArray *pathArray;


@end

@implementation DrawView

- (NSMutableArray *)pathArray {
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    return _pathArray;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    //1.添加拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    
    
}


- (void)pan:(UIPanGestureRecognizer *)pan {
    //当前手指的点
    
    CGPoint curP = [pan locationInView:self];
    //1.线的起点,手指开始拖动的点
    if (pan.state == UIGestureRecognizerStateBegan) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:curP];
         self.path = path;
        //保存当前绘制的路径
        [self.pathArray addObject:path];
       
    }else if (pan.state == UIGestureRecognizerStateChanged) {
        //2.移动时,添加一根线到手指所在的点
        [self.path addLineToPoint:curP];
        //3.重绘
        [self setNeedsDisplay];
    }
    
}


- (void)drawRect:(CGRect)rect {
    //绘制路径
    for (UIBezierPath *path in self.pathArray) {
        [path stroke];
    }
}


@end
