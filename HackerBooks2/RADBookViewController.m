//
//  RADBookViewController.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADBookViewController.h"

#import "RADLibTableViewController.h"
#import "RADNotesViewController.h"
#import "RADPDFViewController.h"

#import "RADBook.h"
#import "RADTag.h"
#import "RADNote.h"
#import "RADImage.h"


@interface RADBookViewController ()

@end

@implementation RADBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Inits
-(id) initWithModel:(RADBook *) model{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = model.title;
    }
    return self;
}


#pragma mark - RADLibTableViewControllerDelegate
-(void) libraryTableViewController:(RADLibTableViewController *)vc
                     didSelectBook:(RADBook *)newBook{
    // cambiamos modelo y sincronizamos con el nuevo
    self.model = newBook;
    [self syncWithModel];
}


#pragma mark - UISplitViewControllerDelegate
-(void) splitViewController:(UISplitViewController *)svc willChangeToDisplayMode:(UISplitViewControllerDisplayMode)displayMode{
    
    // Averiguar si la tabla se ve o no
    if (displayMode == UISplitViewControllerDisplayModePrimaryHidden) {
        
        // La tabla está oculta y cuelga del botón
        // Ponemos ese botón en mi barra de navegación
        self.navigationItem.leftBarButtonItem = svc.displayModeButtonItem;
    }else{
        // Se muestra la tabla: oculto el botón de la
        // barra de navegación
        self.navigationItem.leftBarButtonItem = nil;
    }
}

#pragma mark -  Utils
-(void) syncWithModel{
    
    self.title = self.model.title;
    
    [UIView transitionWithView:self.authorLabel
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.authorLabel.text = self.model.author;
                    } completion:nil];
    

    RADImage *img = self.model.images;
    NSString *strconcat=@"Tags: ";
    strconcat = [strconcat stringByAppendingString:[self.model bookTags]];
    self.tagsLabel.text=strconcat;
    
    
    if (self.model.isFavorite) {
        self.favoriteButton.title = @"★";
    }else{
        self.favoriteButton.title = @"☆";
    }

        
    [UIView transitionWithView:self.bookImage
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.bookImage.image = [UIImage imageWithData:img.imageData];
                    } completion:nil];
    
}


- (IBAction)favoriteAction:(id)sender {
    NSLog(@"Setting book as favorite");
    [self syncWithModel];
}

- (IBAction)pdfAction:(id)sender {
    RADPDFViewController *pdfVC = [[RADPDFViewController alloc] initWithModel:self.model];
    
    [self.navigationController pushViewController:pdfVC animated:YES];
}

- (IBAction)noteAction:(id)sender {
    
    // Crear un contorlador de notas
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RADNote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:RADNoteAttributes.name
                             ascending:YES
                             selector:@selector(caseInsensitiveCompare:)],
                            [NSSortDescriptor
                             sortDescriptorWithKey:RADNoteAttributes.ts_upd
                             ascending:NO]];
    req.fetchBatchSize = 20;
    
    req.predicate = [NSPredicate predicateWithFormat:@"books = %@", self.model];
    
    NSLog(@"Looking notes for book %@",self.model.title);
    
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.model.managedObjectContext
                                      sectionNameKeyPath:nil cacheName:nil];
        
    RADNotesViewController *nVC = [[RADNotesViewController alloc]initWithFetchedResultsController:fc style:UITableViewStylePlain book:self.model];
    
    
    [self.navigationController pushViewController:nVC
                                         animated:YES];

    
}




@end
