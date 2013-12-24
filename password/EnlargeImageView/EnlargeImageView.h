//
//  HYShowImageView.h
//  heyiweixindemo
//
//  Created by 余成海 on 13-12-9.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EnlargeImageView : UIScrollView

//显示图像大图
-(void)showImage:(UIImage*)image inView:(UIView*)parentsView fromPoint:(CGPoint)point;
-(void)showImage:(UIImage*)image inView:(UIView*)parentsView fromRect:(CGRect)rect;

@end
