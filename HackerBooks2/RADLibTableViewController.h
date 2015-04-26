//
//  RADLibTableViewController.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"

@class RADLibTableViewController;
@class RADBook;


//Delegate
@protocol RADLibTableViewControllerDelegate <NSObject>

@optional
-(void) libraryTableViewController:(RADLibTableViewController*) vc
                     didSelectBook:(RADBook*)newBook;

@end



@interface RADLibTableViewController : AGTCoreDataTableViewController<RADLibTableViewControllerDelegate>

    @property (weak, nonatomic) id<RADLibTableViewControllerDelegate> delegate;

@end
