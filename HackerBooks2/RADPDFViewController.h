//
//  RADPDFViewController.h
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 26/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RADBook;

@interface RADPDFViewController : UIViewController

@property(nonatomic, strong) RADBook *model;
@property (weak, nonatomic) IBOutlet UIWebView *pdfView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

-(id)initWithModel:(RADBook*) book;


@end
