//
//  BSPhotoPicker.m
//  BadmintonShow
//
//  Created by lizhihua on 12/30/15.
//  Copyright © 2015 LZH. All rights reserved.
//

#import "BSPhotoPicker.h"
#import "YYPhotoGroupView.h"
#import <AVFoundation/AVFoundation.h>

@interface BSPhotoPicker () <UIActionSheetDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIViewController *currentVC;
@property (nonatomic, copy) BSIdResultBlock idResultBlock;
@end

@implementation BSPhotoPicker

/// 单例
+ (instancetype)shareInstance {
    static BSPhotoPicker *_sharePicker = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharePicker = [[BSPhotoPicker alloc] init];
    });
    return _sharePicker;
}


+ (void)viewController:(UIViewController *)VC pickImageWithBlock:(BSIdResultBlock)block {

    BSPhotoPicker *sharePicker = [BSPhotoPicker shareInstance];
    if (block) sharePicker.idResultBlock = [block copy];
    
    sharePicker.currentVC = VC;
    [sharePicker initActionSheet];
}


#pragma mark 头像ActionSheet

- (void)initActionSheet {
    
    BSPhotoPicker *sharePicker = [BSPhotoPicker shareInstance];
    
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7 &&
        [[UIDevice currentDevice].systemVersion doubleValue] < 8) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:sharePicker.currentVC
                                                        cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
        [actionSheet showFromRect:CGRectMake(0, 0, kScreenWidth, kScreenHeigth / 2) inView:sharePicker.currentVC.view animated:YES];
    }
    
    else if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8) {
        UIAlertController *alertController =
        [UIAlertController alertControllerWithTitle:nil  message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self takePhotoAction];
        }];
        
        UIAlertAction *pickPhoto = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self openPhotoAlbumAction];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:takePhoto];
        [alertController addAction:pickPhoto];
        [sharePicker.currentVC presentViewController:alertController animated:YES completion:nil];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: return;  break;
        case 1: { [self takePhotoAction]; }  break;
        case 2: { [self openPhotoAlbumAction]; } break;
        default: break;
    }
}

- (void)takePhotoAction {
    [self takePhotoType:UIImagePickerControllerSourceTypeCamera];
}

- (void)openPhotoAlbumAction {
    [self takePhotoType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)takePhotoType:(UIImagePickerControllerSourceType)type
{
    BSPhotoPicker *sharePicker = [BSPhotoPicker shareInstance];

    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusAuthorized) {
        // do your logic
        if ([UIImagePickerController isSourceTypeAvailable:type]) {
            
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.sourceType = type;
            pickerController.allowsEditing = YES;
            pickerController.delegate = self;
            [sharePicker.currentVC presentViewController:pickerController animated:YES completion:nil];
        } else {
            [SVProgressHUD showErrorWithStatus:@"该设备无相机"];
        }
        
    } else if (authStatus == AVAuthorizationStatusDenied) {
        // denied
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在设备的：设置-隐私-相机 中允许访问相机。"
                                  delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    } else if (authStatus == AVAuthorizationStatusRestricted) {
        // restricted, normally won't happen
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // not determined?!
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo
                                 completionHandler:^(BOOL granted) {
                                     if (granted) {
                                         //                NSLog(@"Granted access to %@", AVMediaTypeVideo);
                                     } else {
                                         //                NSLog(@"Not granted access to %@", AVMediaTypeVideo);
                                     }
                                 }];
    } else {
        // impossible, unknown authorization status
    }
    
}


#pragma mark UIImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    BSPhotoPicker *sharePicker = [BSPhotoPicker shareInstance];
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if(image){
#warning 传出图片
            if (_idResultBlock) _idResultBlock(image,nil);
        }else{
            if (_idResultBlock) _idResultBlock(nil,nil);
            [SVProgressHUD showErrorWithStatus:@"图像获取失败"];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
