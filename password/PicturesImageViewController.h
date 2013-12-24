//
//  PicturesImageViewController.h
//  password
//
//  Created by kyle on 12/24/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PicturesImageViewDelegate <NSObject>

- (void)picturesImage:(NSArray *)images;

@end

@interface PicturesImageViewController : UIViewController

@property (nonatomic, strong) id<PicturesImageViewDelegate> delegate;
@property (nonatomic, strong) NSArray *pictures;

@end
