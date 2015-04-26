// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to RADPdf.m instead.

#import "_RADPdf.h"

const struct RADPdfAttributes RADPdfAttributes = {
	.pdfData = @"pdfData",
	.pdfUrl = @"pdfUrl",
};

const struct RADPdfRelationships RADPdfRelationships = {
	.books = @"books",
};

@implementation RADPdfID
@end

@implementation _RADPdf

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pdf" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pdf";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pdf" inManagedObjectContext:moc_];
}

- (RADPdfID*)objectID {
	return (RADPdfID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic pdfData;

@dynamic pdfUrl;

@dynamic books;

@end

