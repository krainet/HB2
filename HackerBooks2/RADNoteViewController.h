//
//  RADNoteViewController.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 25/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RADNote.h"


@interface RADNoteViewController : UIViewController<UITextFieldDelegate>

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UIImageView *noteImage;
@property (weak, nonatomic) IBOutlet UITextField *noteName;
@property (weak, nonatomic) IBOutlet UITextView *noteText;
@property (weak, nonatomic) IBOutlet UILabel *noteTsAdd;
@property (weak, nonatomic) IBOutlet UILabel *noteTsUpd;

@property (weak, nonatomic) IBOutlet UIToolbar *bottomBar;




- (IBAction)gotoPicture:(id)sender;
- (IBAction)hideKeyBoard:(id)sender;


@property (strong,nonatomic) RADNote *model;


#pragma mark - Init
-(id) initWithModel: (RADNote *) model;

@end
