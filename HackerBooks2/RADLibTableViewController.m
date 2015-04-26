//
//  RADLibTableViewController.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#define RADLIBRARY_TAGS_DID_CHANGE_NOTIFICATION @"RADLibrary_Tags_Changed"

#import "RADBook.h"
#import "RADBookViewController.h"

#import "RADBook.h"
#import "RADHelpers.h"
#import "RADImage.h"
#import "RADTag.h"
#import "Config.h"

@interface RADLibTableViewController ()

@end

@implementation RADLibTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNotifications];
    self.title=@"Hacker Books";
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


#pragma mark - DataSource
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RADBook *book = [self bookAtIndexPath:indexPath];
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = book.title;
    cell.detailTextLabel.text=book.author;
    cell.imageView.image = book.images.image;
    cell.detailTextLabel.text = [book bookAuthors];
    
    return cell;
}


#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Get selected book
    RADBook *book = [self bookAtIndexPath:indexPath];
    
    // TODO: Guardar en NSUserdefaults el book.
    
    
    //Delegate & Notification
    if ([self.delegate respondsToSelector:@selector(libraryTableViewController:didSelectBook:)]) {
        [self.delegate libraryTableViewController:self didSelectBook:book];
    }
    // Mando también la notificación
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    NSNotification *n = [NSNotification
                         notificationWithName:RADBOOK_DID_CHANGE_NOTIFICATION
                         object:self
                         userInfo:@{BOOK_KEY:book}];
    [nc postNotification:n];

}


#pragma mark - Utils
- (RADBook *) bookAtIndexPath:(NSIndexPath *) indexPath{
    
    RADTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    RADBook *book = [[tag.books allObjects] objectAtIndex:indexPath.row];
    return book;
}

#pragma mark -  Notifications
-(void) setupNotifications{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(notifyThatTagsDidChange:)
               name:RADLIBRARY_TAGS_DID_CHANGE_NOTIFICATION
             object:nil];
    
}

-(void) tearDownNotifications{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

-(void)notifyThatTagsDidChange:(NSNotification*) notification{
    
    [self.tableView reloadData];
}

-(void) dealloc{
    [self tearDownNotifications];
}

#pragma mark - Book Delegate
-(void) libraryTableViewController:(RADLibTableViewController*) vc
                     didSelectBook:(RADBook*)newBook{
    
}

#pragma mark - Unused

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
