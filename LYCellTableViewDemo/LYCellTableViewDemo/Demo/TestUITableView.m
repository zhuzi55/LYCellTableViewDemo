//
//  TestUITableView.m
//  Demo20210123OC
//
//  Created by liyz on 2022/7/4.
//

#import "TestUITableView.h"

@interface TestUITableView()<UIGestureRecognizerDelegate>



@end

@implementation TestUITableView

//** 让手势支持多响应
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

@end
