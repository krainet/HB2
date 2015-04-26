//
//  RADNotesViewController.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 25/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "AGTCoreDataTableViewController.h"

@class RADNotesViewController;
@class RADBook;
@class RADNote;


@protocol RADNotesViewControllerDelegate <NSObject>

@optional
-(void) notesViewController:(RADNotesViewController*) vc
                     didSelectNote:(RADNote*)newBook;

@end


@interface RADNotesViewController : AGTCoreDataTableViewController<RADNotesViewControllerDelegate>

@property (weak, nonatomic) id<RADNotesViewControllerDelegate> delegate;

-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                 style:(UITableViewStyle)aStyle
                              book:(RADBook *) book;


@end
