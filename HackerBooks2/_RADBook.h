// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADBook.h instead.

@import CoreData;
#import "RADHackerBooksBaseClass.h"

extern const struct RADBookAttributes {
	__unsafe_unretained NSString *author;
	__unsafe_unretained NSString *title;
} RADBookAttributes;

extern const struct RADBookRelationships {
	__unsafe_unretained NSString *images;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *pdfs;
	__unsafe_unretained NSString *tags;
} RADBookRelationships;

@class RADImage;
@class RADNote;
@class RADPdf;
@class RADTag;

@interface RADBookID : NSManagedObjectID {}
@end

@interface _RADBook : RADHackerBooksBaseClass {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) RADBookID* objectID;

@property (nonatomic, strong) NSString* author;

//- (BOOL)validateAuthor:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) RADImage *images;

//- (BOOL)validateImages:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@property (nonatomic, strong) RADPdf *pdfs;

//- (BOOL)validatePdfs:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;

@end

@interface _RADBook (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(RADNote*)value_;
- (void)removeNotesObject:(RADNote*)value_;

@end

@interface _RADBook (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(RADTag*)value_;
- (void)removeTagsObject:(RADTag*)value_;

@end

@interface _RADBook (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthor;
- (void)setPrimitiveAuthor:(NSString*)value;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (RADImage*)primitiveImages;
- (void)setPrimitiveImages:(RADImage*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

- (RADPdf*)primitivePdfs;
- (void)setPrimitivePdfs:(RADPdf*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end
