//
//  RADNoteViewController.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 25/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADNoteViewController.h"
#import "RADImageViewController.h"

@interface RADNoteViewController ()

@end

@implementation RADNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Init
-(id) initWithModel:(RADNote *) model{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = model.name;
        [self syncWithModel];
    }
    NSLog(@"Model: %@",self.model);
    return self;
}



#pragma mark -  Utils
-(void) syncWithModel{
    self.noteName.text = self.model.name;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Asignamos delegados
    //self.nameView.delegate = self;
    
    // Alta en notificaciones de teclado
    //[self setupKeyboardNotifications];
    
    
    // Sincornizar modelo -> Vista
    
    // Fechas
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterShortStyle;
    
    self.noteTsAdd.text = [fmt stringFromDate:self.model.ts_add];
    self.noteTsUpd.text = [fmt stringFromDate:self.model.ts_upd];
    
    // Nombre
    self.noteName.text = self.model.name;
    
    
    // Texto
    self.noteText.text = self.model.text;
    
}


- (IBAction)gotoPicture:(id)sender{
    // Crear un controlador de fotos
    RADImageViewController *pVC = [[RADImageViewController alloc]
                                   initWithModel:self.model.images];
    
    // Push que te crió
    [self.navigationController pushViewController:pVC
                                         animated:YES];
}




- (IBAction)hideKeyBoard:(id)sender{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    // Buen momento para validar el texto
    
    [textField resignFirstResponder];
    
    return YES;
}

-(void) textFieldDidEndEditing:(UITextField *)textField{
    
    // Buen momento para guardar el texto
}

-(void) setupKeyboardNotifications{
    
    // Alta en notificaciones
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notifyThatKeyboardWillDisappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
    
}

// UIKeyboardWillShowNotification
-(void) notifyThatKeyboardWillAppear:(NSNotification *)n{
    
    // Sacar la duración de la animación del teclado
    double duration = [[n.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Sacar el tamaño (bounds) del teclado del objeto
    // userInfo que viene en la notificación
    NSValue *wrappedFrame = [n.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbdFrame = [wrappedFrame CGRectValue];
    
    
    // Calcular los nuevos bounds de self.textView
    // Hacerlo con una animación que coincida con la
    // del teclado
    CGRect currentFrame = self.noteText.frame;
    
    CGRect newRect = CGRectMake(currentFrame.origin.x,
                                currentFrame.origin.y,
                                currentFrame.size.width,
                                currentFrame.size.height -
                                kbdFrame.size.height +
                                self.bottomBar.frame.size.height);
    
    [UIView animateWithDuration:duration
                     animations:^{
                         self.noteText.frame = newRect;
                     }];
    
    
    
}

// UIKeyboardWillHideNotification
-(void)notifyThatKeyboardWillDisappear:(NSNotification *) n{
    
    // Sacar la duración de la animación del teclado
    double duration = [[n.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Devolver a self.textView su bounds original
    // mediante una animación que coincide con la
    // del teclado.
    [UIView animateWithDuration:duration
                     animations:^{
                         self.noteText.frame = CGRectMake(8,
                                                          150,
                                                          304,
                                                          359);
                         
                     }];
}







#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
