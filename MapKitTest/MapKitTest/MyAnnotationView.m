//
//  MyAnnotationView.m
//  MapKitTest
//
//  Created by ffm on 16/11/2.
//  Copyright © 2016年 ITPanda. All rights reserved.
//

#import "MyAnnotationView.h"

@implementation MyAnnotationView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    UIImageView *annotationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.png"]];
    annotationView.frame = self.bounds;
    [self addSubview:annotationView];
}


@end
