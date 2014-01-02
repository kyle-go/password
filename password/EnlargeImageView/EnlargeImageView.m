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
    CGFloat _imageHWScale;
    CGRect _oldRect;
    CGFloat _beganScale;
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
    
    UIImageView *imageView = (UIImageView *)[self viewWithTag:'show'];
    if ([sender state] == UIGestureRecognizerStateBegan) {
        _imageHWScale = imageView.image.size.height/imageView.image.size.width;
        _beganScale = self.zoomScale;
    }
    
    [self setZoomScale:_beganScale * sender.scale];
    
    if ([sender state] == UIGestureRecognizerStateEnded) {
        if (self.zoomScale < 1.0) {
            [self setZoomScale:1.0 animated:YES];
            self.contentOffset = CGPointMake(0, 0);
        } else if (self.zoomScale > 3.0) {
            [self setZoomScale:3.0 animated:YES];
        }
    }
}

#pragma mark - ScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (UIView *v in scrollView.subviews){
        return v;
    }
    
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
    //
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if (self.zoomScale < 1.0) {
        [self setZoomScale:1.0 animated:YES];
        self.contentOffset = CGPointMake(0, 0);
    } else if (self.zoomScale > 3.0) {
        [self setZoomScale:3.0 animated:YES];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:'show'];
    _imageHWScale = imageView.image.size.height/imageView.image.size.width;
    if (self.contentOffset.x<=0 && self.contentOffset.y<=0) {
        self.contentOffset = CGPointMake((imageView.image.size.width - PHOTOWIDTH)/2, imageView.image.size.width - PHOTOWIDTH);
    }
}

@end
