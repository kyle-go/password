//
//  PicturesImageViewController.m
//  password
//
//  Created by kyle on 12/24/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "PicturesImageViewController.h"
#import "EnlargeImageView.h"

@interface PicturesImageViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation PicturesImageViewController {
    NSMutableArray *imageViews;
    UIImageView    *addImageView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        imageViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"图片备注";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemAction target:self action:@selector(save)];
    
    int iIndex = 0;
    for (UIImage *image in self.pictures) {
        //只处理前3个
        if (iIndex == 3) {
            break;
        }
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(5 + (iIndex++)*105, 70, 100, 100)];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        iv.image = image;
        iv.backgroundColor = [UIColor whiteColor];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookBigPicture:)];
        [iv addGestureRecognizer:singleTap];
        iv.userInteractionEnabled = YES;
        [imageViews addObject:iv];
        [self.view addSubview:iv];
    }
    
    int iCount = self.pictures.count;
    if (iCount < 3) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(5 + iCount*105, 70, 100, 100)];
        iv.image = [UIImage imageNamed:@"add.png"];
        iv.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addImageTap:)];
        [iv addGestureRecognizer:singleTap];
        iv.userInteractionEnabled = YES;
        
        addImageView = iv;
        [self.view addSubview:iv];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)save
{
    [self.delegate picturesImage:imageViews];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addImageTap:(UIGestureRecognizer *)gestureRecognizer
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"本地图片", nil];
    
    [actionSheet showInView:self.view];
}

- (void)lookBigPicture:(UIGestureRecognizer *)guestureRecognizer
{
    UIImageView *iv = (UIImageView *)guestureRecognizer.view;
    EnlargeImageView *enLargeView = [[EnlargeImageView alloc] init];
    [enLargeView showImage:iv.image inView:self.navigationController.view fromRect:iv.frame];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    
    switch (buttonIndex) {
            //拍照
        case 0:
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            //选择本地图片
        case 1:
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:nil];
            break;
            //取消
        case 2:
            break;
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* mediaType = [info objectForKey:@"UIImagePickerControllerMediaType"];
    if ([mediaType isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(5, 70, 100, 100)];
        iv.image = image;
        iv.backgroundColor = [UIColor whiteColor];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookBigPicture:)];
        [iv addGestureRecognizer:singleTap];
        iv.userInteractionEnabled = YES;
        [self.view addSubview:iv];
        [imageViews addObject:iv];
        
        if (imageViews.count == 3) {
            [addImageView removeFromSuperview];
        } else {
            CGRect frame = addImageView.frame;
            frame.origin.x = 5 + 105*imageViews.count;
            addImageView.frame = frame;
        }
        
        NSInteger iIndex = 0;
        for (UIImageView *iv in imageViews) {
            CGRect frame = iv.frame;
            frame.origin.x = 5 + 105*(iIndex++);
            iv.frame = frame;
        }
        
        //dismiss self.
        [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
