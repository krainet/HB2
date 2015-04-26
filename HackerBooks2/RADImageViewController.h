//
//  RADImageViewController.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 25/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RADImage;

@interface RADImageViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
- (IBAction)takePicture:(id)sender;
- (IBAction)deletePhoto:(id)sender;

@property(nonatomic, strong)  RADImage *model;

-(id) initWithModel:(RADImage*) model;


@end
