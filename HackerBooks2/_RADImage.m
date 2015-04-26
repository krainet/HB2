// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADImage.m instead.

#import "_RADImage.h"

const struct RADImageAttributes RADImageAttributes = {
	.imageData = @"imageData",
	.imageUrl = @"imageUrl",
};

const struct RADImageRelationships RADImageRelationships = {
	.books = @"books",
	.notes = @"notes",
};

@implementation RADImageID
@end

@implementation _RADImage

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Image" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Image";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Image" inManagedObjectContext:moc_];
}

- (RADImageID*)objectID {
	return (RADImageID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageData;

@dynamic imageUrl;

@dynamic books;

@dynamic notes;

- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@end

