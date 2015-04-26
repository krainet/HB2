//
//  RADBookViewController.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

@import UIKit;
@class RADBook;
#import "RADLibTableViewController.h"


@interface RADBookViewController : UIViewController<RADLibTableViewControllerDelegate,UISplitViewControllerDelegate>

#pragma mark - Properties
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *notesButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *favoriteButton;


- (IBAction)favoriteAction:(id)sender;
- (IBAction)pdfAction:(id)sender;
- (IBAction)noteAction:(id)sender;


@property (strong,nonatomic) RADBook *model;

#pragma mark - Init
-(id) initWithModel: (RADBook *) model;


@end
