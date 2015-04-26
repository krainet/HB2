// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADNote.m instead.

#import "_RADNote.h"

const struct RADNoteAttributes RADNoteAttributes = {
	.name = @"name",
	.text = @"text",
	.ts_add = @"ts_add",
	.ts_upd = @"ts_upd",
};

const struct RADNoteRelationships RADNoteRelationships = {
	.books = @"books",
	.images = @"images",
};

@implementation RADNoteID
@end

@implementation _RADNote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (RADNoteID*)objectID {
	return (RADNoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic name;

@dynamic text;

@dynamic ts_add;

@dynamic ts_upd;

@dynamic books;

@dynamic images;

@end

