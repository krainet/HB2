// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADImage.h instead.

@import CoreData;
#import "RADHackerBooksBaseClass.h"

extern const struct RADImageAttributes {
	__unsafe_unretained NSString *imageData;
	__unsafe_unretained NSString *imageUrl;
} RADImageAttributes;

extern const struct RADImageRelationships {
	__unsafe_unretained NSString *books;
	__unsafe_unretained NSString *notes;
} RADImageRelationships;

@class RADBook;
@class RADNote;

@interface RADImageID : NSManagedObjectID {}
@end

@interface _RADImage : RADHackerBooksBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADImageID* objectID;

@property (nonatomic, strong) NSData* imageData;

//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* imageUrl;

//- (BOOL)validateImageUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADBook *books;

//- (BOOL)validateBooks:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _RADImage (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(RADNote*)value_;
- (void)removeNotesObject:(RADNote*)value_;

@end

@interface _RADImage (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (NSString*)primitiveImageUrl;
- (void)setPrimitiveImageUrl:(NSString*)value;

- (RADBook*)primitiveBooks;
- (void)setPrimitiveBooks:(RADBook*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
