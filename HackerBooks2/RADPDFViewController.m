//
//  RADPDFViewController.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 26/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADPDFViewController.h"
#import "RADBook.h"
#import "RADPdf.h"
#import "Config.h"

@interface RADPDFViewController ()

@end

@implementation RADPDFViewController

-(id)initWithModel:(RADBook*) book{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = book;
        self.title = book.title;
    }
    
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.activityView.hidden = YES;
    
    [self syncWithModel];
    
    // Alta en notificaciones de library
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:RADBOOK_DID_CHANGE_NOTIFICATION
             object:nil];
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // Baja en notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notificaciones
-(void) notifyThatBookDidChange:(NSNotification *) notification{
    
    // sacamos el nuevo libro
    RADBook *newBook = [notification.userInfo objectForKey:BOOK_KEY];
    self.model = newBook;
    [self syncWithModel];
}


#pragma mark - Util
-(void) syncWithModel{
    
    self.title = self.model.title;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    RADPdf *pdf=self.model.pdfs;
    NSURL *localURL = [self localURLForRemoteURL:[NSURL URLWithString:pdf.pdfUrl]];
    
    //Book exist
    if ([fm fileExistsAtPath:[localURL path]]) {
        [self.pdfView loadData:[NSData dataWithContentsOfURL:localURL]
                      MIMEType:@"application/pdf"
              textEncodingName:@"UTF-8"
                       baseURL:nil];
        
    }else{
        //Book not exist
        NSLog(@"Downloading book ...%@",self.model.title);
        self.activityView.hidden = NO;
        [self.activityView startAnimating];
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:pdf.pdfUrl]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.pdfView loadData:data
                              MIMEType:@"application/pdf"
                      textEncodingName:@"UTF-8"
                               baseURL:nil];
                
                [self.activityView stopAnimating];
                self.activityView.hidden = YES;
                
                [data writeToURL:localURL
                      atomically:YES];
            });
        });
    }
    
}


-(NSURL*)documentsDirectory{
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSURL *docs = [[fm URLsForDirectory:NSDocumentDirectory
                              inDomains:NSUserDomainMask] lastObject];
    return docs;
}

-(NSURL *) localURLForRemoteURL:(NSURL*) remoteURL{
    NSString *fileName = [remoteURL lastPathComponent];
    NSURL *local = [[self documentsDirectory] URLByAppendingPathComponent:fileName];
    return local;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
