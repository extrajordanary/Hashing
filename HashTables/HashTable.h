//
//  HashTable.h
//  HashTables
//
//  Created by Daniel Haaser on 11/25/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HashTable : NSObject

// -------------------------------------------
//          Implement these Methods!
// -------------------------------------------

- (void)setObject:(id)object forKey:(NSString*)key;

- (id)objectForKey:(NSString*)key;

@end
