//
//  RADNotesViewController.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 25/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADNotesViewController.h"
#import "RADNoteViewController.h"
#import "RADBook.h"
#import "RADNote.h"
#import "Config.h"

@interface RADNotesViewController ()
    @property (strong, nonatomic) RADBook *book;
@end

@implementation RADNotesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Notas del Libro";
    UIBarButtonItem *add = [[UIBarButtonItem alloc]
                            initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                            target:self action:@selector(addNewNote:)];
    
    self.navigationItem.rightBarButtonItem = add;
    [self setupNotifications];
}


#pragma mark Init
-(id) initWithFetchedResultsController:(NSFetchedResultsController *)aFetchedResultsController
                                 style:(UITableViewStyle)aStyle
                              book:(RADBook *) book{
    if(self = [super initWithFetchedResultsController:aFetchedResultsController style:aStyle]){
        _book = book;
        self.title = self.book.title;
    }
    return self;
}




#pragma mark - DataSource
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar la nota
    RADNote *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    // Crear la celda
    static NSString *noteCellId = @"NoteCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:noteCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:noteCellId];
    }
    // Sincornizar nota -> celda
    cell.imageView.image = nil;
    cell.textLabel.text = n.name;
    
    // devolverla
    return cell;
    
}


#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // Averiguar la nota
    RADNote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    // Crear el controlador
    RADNoteViewController *nVC = [[RADNoteViewController alloc] initWithModel:note];
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
}


-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        RADNote *n = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [self.fetchedResultsController.managedObjectContext deleteObject:n];
    }
}



#pragma mark - Utils
-(void) addNewNote:(id) sender{
    [RADNote noteWithName:@"Nueva nota" Book:self.book context:self.book.managedObjectContext];
}


#pragma mark -  Notifications
-(void) setupNotifications{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatTagsDidChange:)
               name:RADBOOK_DID_CHANGE_NOTIFICATION
             object:nil];
}

-(void) tearDownNotifications{
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}
-(void)notifyThatTagsDidChange:(NSNotification*) notification{
    NSLog(@"Ha cambiado!");
    [self.tableView reloadData];
}
-(void) dealloc{
    [self tearDownNotifications];
}



#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
