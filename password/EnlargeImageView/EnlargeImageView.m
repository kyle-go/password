//
//  HYShowImageView.m
//  heyiweixindemo
//
//  Created by 余成海 on 13-12-9.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import "EnlargeImageView.h"

#define PHOTOWIDTH 320
#define PHOTOHEIGHT 586
#define color_with_rgba(a,b,c,d) [UIColor colorWithRed:a/255.0 green:b/255.0 blue:c/255.0 alpha:d]

@interface EnlargeImageView ()

@end

@implementation EnlargeImageView {
    CGFloat _oldImageWidth;
    CGFloat _oldImageHeight;
    CGFloat _imageHWScale;
    CGRect _oldRect;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)showImage:(UIImage*)image inView:(UIView*)parentsView fromRect:(CGRect)rect
{
    _oldRect = rect;
    self.frame = CGRectMake(0, 0, PHOTOWIDTH, PHOTOHEIGHT);
    self.backgroundColor = color_with_rgba(0, 0, 0, 0.1);
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    _imageHWScale = rect.size.height/rect.size.width;
    
    UIImageView *showView = [[UIImageView alloc] initWithFrame:rect];
    showView.tag = 'show';
    showView.contentMode = UIViewContentModeScaleAspectFit;
    showView.image = image;
    showView.userInteractionEnabled = YES;
    [self addSubview:showView];
    
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewTap:)];
    [self addGestureRecognizer:singleTap];
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewPinch:)];
    [self addGestureRecognizer:pinchGesture];
    
    [parentsView addSubview:self];
    
    [UIView animateWithDuration:0.5f animations:^{
        [showView setFrame:CGRectMake(0, 0, PHOTOWIDTH, PHOTOHEIGHT)];
        self.backgroundColor = color_with_rgba(0, 0, 0, 0.8);
    }];
}

//点击 (查看视图,取消视图)
-(void)handleViewTap:(UITapGestureRecognizer *)sender
{
    [UIView animateWithDuration:0.5f animations:^{
        UIImageView *showView = (UIImageView *)[self viewWithTag:'show'];
        showView.frame = _oldRect;
        self.backgroundColor = color_with_rgba(0, 0, 0, 0.0);
    } completion:^(BOOL finished){[self removeFromSuperview];}];
}

//缩放图片
-(void)handleViewPinch:(UIPinchGestureRecognizer *)sender
{
    CGPoint oldGesturePoint;
    UIImageView *imageView = (UIImageView *)[self viewWithTag:'show'];
    if ([sender state] == UIGestureRecognizerStateBegan) {
        if (_oldImageWidth == 0) {
            _oldImageWidth = PHOTOWIDTH;
        }
        if (_oldImageHeight == 0) {
            _oldImageHeight = (imageView.image.size.height/imageView.image.size.width)*PHOTOWIDTH;
        }
        oldGesturePoint = [sender locationInView:self];
    }
    
    CGRect frame = imageView.frame;
    frame.size.width = _oldImageWidth * sender.scale;
    frame.size.height = _oldImageHeight * sender.scale;
    imageView.frame = frame;
    
    self.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
    //imageView.center = CGPointMake(imageView.center.x/2 - (sender.scale-1)*oldGesturePoint.x/2, imageView.center.y/2 - (sender.scale-1)*oldGesturePoint.y/2);
    
    NSLog(@"@@@@point = x=%f y=%f", imageView.center.x, imageView.center.y);
    
    CGPoint centerPoint = CGPointMake(self.contentSize.width/2, self.contentSize.height/2);;
    if (imageView.frame.size.width < PHOTOWIDTH) {
        centerPoint.x = PHOTOWIDTH/2;
    }
//    else {
//        centerPoint.x = self.contentSize.width/2 - (sender.scale-1)*oldGesturePoint.x/2;
//    }
    if (imageView.frame.size.height < PHOTOHEIGHT) {
        centerPoint.y = PHOTOHEIGHT/2;
    }
//    else {
//        centerPoint.y = self.contentSize.height/2 - (sender.scale-1)*oldGesturePoint.y/2;
//    }
    imageView.center = centerPoint;
    
    if ([sender state] == UIGestureRecognizerStateEnded) {
        if (imageView.frame.size.width < PHOTOWIDTH) {
            [UIView animateWithDuration:0.5f animations:^{
                imageView.frame = CGRectMake(0, (PHOTOHEIGHT - _imageHWScale*PHOTOWIDTH)/2.0, PHOTOWIDTH, PHOTOWIDTH * _imageHWScale);
            }];
        }
        _oldImageWidth = imageView.frame.size.width;
        _oldImageHeight = imageView.frame.size.height;
    }
}

@end
