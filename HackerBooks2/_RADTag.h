// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADTag.h instead.

@import CoreData;
#import "RADHackerBooksBaseClass.h"

extern const struct RADTagAttributes {
	__unsafe_unretained NSString *name;
} RADTagAttributes;

extern const struct RADTagRelationships {
	__unsafe_unretained NSString *books;
} RADTagRelationships;

@class RADBook;

@interface RADTagID : NSManagedObjectID {}
@end

@interface _RADTag : RADHackerBooksBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _RADTag (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(RADBook*)value_;
- (void)removeBooksObject:(RADBook*)value_;

@end

@interface _RADTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
