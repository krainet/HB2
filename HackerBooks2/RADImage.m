#import "RADImage.h"
#import "AGTCoreDataStack.h"
#import "RADHelpers.h"
#import "AGTAsyncImage.h"


@interface RADImage ()

// Private interface goes here.

@end

@implementation RADImage

#pragma mark - Properties

// Observables
+(NSArray *) observableKeys{
    // Observo las propiedades de las relaciones
    return @[RADImageAttributes.imageUrl,RADImageAttributes.imageData];
}


//setter-getter transciend
-(void) setImage:(UIImage *) image{
    // Sincronizar con photoData
    self.imageData = UIImageJPEGRepresentation(image, 0.9);
}

-(UIImage *) image{
    return [UIImage imageWithData:self.imageData];
}


#pragma mark - Inits
+(instancetype) photoWithImage:(UIImage *) image
                      imageURL:(NSURL *) imageURL
                         stack:(AGTCoreDataStack *) stack{
    
    RADImage *photo = [NSEntityDescription insertNewObjectForEntityForName:[RADImage entityName]
                                                    inManagedObjectContext:stack.context];
    photo.imageData = UIImageJPEGRepresentation(image, 0.9);
    photo.imageUrl = [imageURL absoluteString];
    
    return photo;
}

#pragma mark Static methods
+(instancetype) photoWithImageURL:(NSString *)imageURL
                          context:(NSManagedObjectContext *)context{
    // Pasamos la imagen a un data
    RADImage *photo = [self insertInManagedObjectContext:context];
    
    NSManagedObjectContext * privateContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    privateContext.persistentStoreCoordinator = context.persistentStoreCoordinator;
    
    [privateContext performBlock:^{
        
        NSURL *url = [NSURL URLWithString:imageURL];
        
        [RADImage downLoadPhotoWithURL:url statusOperationWith:^(NSData *data) {
            photo.imageData = data;
        } failure:^(NSError *error) {
            photo.imageData = nil;
        }];
        
    }];
    
    return photo;
}


+(instancetype) photoWithAsyncImageURL:(NSString *)imageURL Context:(NSManagedObjectContext*) context{
    // Pasamos la imagen a un data
    RADImage *photo = [self insertInManagedObjectContext:context];
    
    NSManagedObjectContext * privateContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    privateContext.persistentStoreCoordinator = context.persistentStoreCoordinator;
    
    [privateContext performBlock:^{
        
        NSURL *url = [NSURL URLWithString:imageURL];
        
        [RADImage downLoadPhotoWithURL:url statusOperationWith:^(NSData *data) {
            photo.imageData = data;
        } failure:^(NSError *error) {
            photo.imageData = nil;
        }];
        
    }];
    
    return photo;
}

#pragma mark - Download
+(void)downLoadPhotoWithURL:(NSURL *)url statusOperationWith:(void(^)(NSData *data))success failure:(void (^)(NSError *error))failure{
    [RADHelpers downloadDataWithURL:url statusOperationWith:^(NSData *data, NSURLResponse *response, NSError *error) {
        success(data);
    } failure:^(NSURLResponse *response, NSError *error) {
        NSLog(@"Error al cargar la imagen");
        failure(error);
    }];
    
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context{
    
    // Set action for observables
    
}



@end
