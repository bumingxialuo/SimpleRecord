//
//  UIView+Snapshot.m
//  SimpleRecord
//
//  Created by xia on 2018/3/22.
//  Copyright © 2018年 xia. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)

- (UIImage *)takeSnapshotWithFrame:(CGRect)frame {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    UIImage *resultImg = [UIImage imageWithCGImage:CGImageCreateWithImageInRect(img.CGImage, frame)];
    return  resultImg;
}

@end
