//
//  RADImageViewController.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 25/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//

#import "RADImageViewController.h"
#import "RADImage.h"

@interface RADImageViewController ()

@end

@implementation RADImageViewController

#pragma mark - Init
-(id) initWithModel:(RADImage *)model{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _model = model;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}



#pragma mark - View Life cycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Me aseguro que la vista no ocupa toda la
    // pantalla, sino lo que queda disponible
    // dentro del navigation
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    // sincronizo modelo -> vista
    self.photoView.image = self.model.image;
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Sincronizo vista -> modelo
    self.model.image = self.photoView.image;
}


#pragma mark - Actions
- (IBAction)takePicture:(id)sender {
    
    // Creamos un UIImagePickerController
    UIImagePickerController *picker = [UIImagePickerController new];
    
    // Lo configuro
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        // Uso la cámara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }else{
        // Tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    // Lo muestro de forma modal
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         // Esto se va a ejecutar cuando termine la
                         // animación que muestra al picker.
                     }];
    
    
    
}

- (IBAction)deletePhoto:(id)sender {
    
    // la eliminamos del modelo
    self.model.image = nil;
    
    // sincronizo modelo -> vista
    CGRect oldRect = self.photoView.bounds;
    [UIView animateWithDuration:0.7
                     animations:^{
                         
                         self.photoView.alpha = 0;
                         self.photoView.bounds = CGRectZero;
                         self.photoView.transform = CGAffineTransformMakeRotation(M_PI_2);
                         
                     } completion:^(BOOL finished) {
                         
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldRect;
                         self.photoView.transform = CGAffineTransformIdentity;
                         self.photoView.image = nil;
                     }];
    
    
    
}

#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // ¡OJO! Pico de memoria asegurado, especialmente en
    // dispositivos antiguos
    
    
    // Sacamos la UIImage del diccionario
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // La guardo en el modelo
    self.model.image = img;
    
    // Quito de encima el controlador que estamos presentando
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 // Se ejecutará cuando se haya ocultado del todo
                             }];
}




#pragma mark - Memory Warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
