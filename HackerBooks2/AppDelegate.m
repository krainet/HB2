//
//  AppDelegate.m
//  HackerBooks2
//
//  Created by RAMON ALBERTI DANES on 19/4/15.
//  Copyright (c) 2015 Krainet. All rights reserved.
//


#import "Config.h"

#import "AppDelegate.h"
#import "AGTCoreDataStack.h"
#import "RADBook.h"
#import "RADTag.h"
#import "RADBookMulti.h"
#import "RADLibTableViewController.h"
#import "RADBookViewController.h"


@interface AppDelegate ()
@property (strong,nonatomic) AGTCoreDataStack *stack;
@property (nonatomic) NSUInteger displayType;

@property (strong,nonatomic) RADBookMulti *allBooks;

//Book Count
@property (nonatomic, readonly) NSUInteger bookCount;

//Sorted tags may be
@property (nonatomic, readonly) NSArray *tags;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    //Core data Stack
    self.stack = [AGTCoreDataStack coreDataStackWithModelName:@"Model"];
    
    //[self.stack zapAllData];
    
    //Load data from jSON
    [self loadRemoteData];
    
    
    //Process data
    // Data for first View => Fetch of all tags, each of them with their books
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[RADTag entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RADTagAttributes.name ascending:YES selector:@selector(caseInsensitiveCompare:)]];
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                                              managedObjectContext:self.stack.context
                                                                                sectionNameKeyPath:RADTagAttributes.name
                                                                                         cacheName:nil];

    

    // Controlador de tabla de libros con NSFetchedResultsController
    RADLibTableViewController *libraryVC = [[RADLibTableViewController alloc] initWithFetchedResultsController:results style:UITableViewStyleGrouped];
    
    //Detectar Pantalla
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        //Somos tablet
        [self prepareForIpadwithTVC:libraryVC];
    } else {
        //Somos phone
        [self prepareForIphone];
    }
    
    // Arranco el autosave
    [self autoSave];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



#pragma mark - Configurators
-(void)prepareForIpadwithTVC:(RADLibTableViewController*) tVC {
    
    //Creamos modelo
    
    //Creamos controlador
    RADBook *bookModel=nil;
    RADBookViewController *bookVC = [[RADBookViewController alloc]initWithModel:bookModel];
    
    
    //Creamos Combinador
    UINavigationController *navLibVC = [[UINavigationController alloc]initWithRootViewController:tVC];
    UINavigationController *navBookVC = [[UINavigationController alloc]initWithRootViewController:bookVC];
    UISplitViewController *splitVC = [[UISplitViewController alloc]init];
    splitVC.viewControllers=@[navLibVC,navBookVC];
    
    //Asignamos delegados
    //splitVC.delegate=bookVC;
    tVC.delegate=bookVC;
    
    
    //Asignamos root
    self.window.rootViewController=splitVC;
    
    
}

-(void)prepareForIphone{

    //Creamos modelo
    
    //Creamos controlador
    
    //Creamos Combinador
    //UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:libVC];
    
    //Asegnamos delegados (delegado de si mismo)
    //libVC.delegate=libVC;
    
    //Asignamos root
    //self.window.rootViewController=navVC;

}

#pragma mark - Utils

-(RADBook *) getLastSelectedBook{
    // Recuperamos la clave del lastSelectedBook de NSUserDefaults, que será la URL al ObjectID
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    RADBook *lastBook = [defaults objectForKey:LAST_SELECTED_BOOK];
    
    return lastBook;
}

-(void) saveLastSelectedBook: (RADBook *) book{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //TODO OJO  quitar esto
    [defaults setObject:book forKey:LAST_SELECTED_BOOK];
    [defaults synchronize];
}

#pragma mark - JSON
-(void) loadRemoteData{
    
    // Download JSON & put into nsData
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:JSON_URL]];
    NSURLResponse *response = [[NSURLResponse alloc]init];
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                              returningResponse:&response
                                                          error:&error];
    
    if (data!=nil) {
        id jsonData = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
        
        
        if (jsonData!=nil) {
            if ([jsonData isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dict in jsonData) {
                    [RADBook bookWithDictionary:dict stack:self.stack];
                }
            }
        }
        
        _allBooks = [RADBookMulti dictionary];
        
        
        
        
        //Salvamos
        [self saveDataToDB];
        NSLog(@"JSON successfully downloaded");
        
    }
    else{
        //Error
        NSLog(@"JSON Err: %@",error.localizedDescription);
    }
    
    
}

#pragma mark - JSON Processing
-(void) processJSONArray:(NSArray*)json{
    
    
    for (NSDictionary *dict in json) {
        RADBook *current = [RADBook bookWithDictionary:dict stack:self.stack];
        [self addBook: current];
        _bookCount++;
    }
}


-(void) addBook:(RADBook*) book{
    
    for (NSString *tag in book.tags) {
        
        [self.allBooks addObject:book
                        forKey:tag];
    }
}


#pragma mark - Persistence SQLITE

-(void) saveDataToDB{
    [self.stack saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error saving! : %@",error.description);
    }];
    NSLog(@"Saved!");
}




#pragma mark Aux Functions
-(void) trastearConDatos{
    
    //[self.stack zapAllData];
    
    //Crear un libro
    /*
    RADBook *book = [RADBook bookWithTitle:@"Saber es saber"
                                    Author:@"Ramon Alberti"
                                      Tags:@[@"Listos",@"Sabios"]
                                    PdfURL:@"https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf"
                                  ImageURL:@"http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg"
                                   InStack:self.stack];

    RADBook *book2 = [RADBook bookWithTitle:@"No se nada"
                                    Author:@"Pedrito Zamora"
                                      Tags:@[@"Listos",@"Buenos"]
                                    PdfURL:@"https://progit2.s3.amazonaws.com/en/2015-03-06-439c2/progit-en.376.pdf"
                                  ImageURL:@"http://hackershelf.com/media/cache/b4/24/b42409de128aa7f1c9abbbfa549914de.jpg"
                                   InStack:self.stack];
    
    

    [self saveDataToDB];
    
    NSLog(@"Nombre del 1 es : %@",[book valueForKey:@"title"]);
    
    
    // Buscamos los libros y ponemos un criterio de ordenación (nombre + fecha_mod)
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[RADBook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:RADBookAttributes.title ascending:YES]];
    // Número de resultados que devolverá en cada lote:20
    req.fetchBatchSize = 20;
    
    //Queremos todas las notas de la libreta exs
    //req.predicate = [NSPredicate predicateWithFormat:@"notebook = %@",exs];
    
    
    
    NSArray *results = [self.stack
                        executeFetchRequest:req
                        errorBlock:^(NSError *error) {
                            NSLog(@"Error al buscar! %@",error);
                        }];
    
    //NSLog(@"%@",book3);
    
    // Eliminamos libro
    //[self.stack.context deleteObject:book];
    
    
    // Guardar
    //[self save];
     */
 }
 

#pragma mark - Autosave

-(void) autoSave{
    
    if (AUTO_SAVE) {
        NSLog(@"Autoguardando");
        [self.stack saveWithErrorBlock:^(NSError *error) {
            NSLog(@"Error al autoguardar!");
        }];
        
        // Pongo en mi "agenda" una nueva llamada a autoSave
        [self performSelector:@selector(autoSave)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY_IN_SECONDS];
        
    }
}


#pragma mark - Unused
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
