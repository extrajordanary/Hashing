//
//  LinkedList.m
//  LinkedLists
//
//  Created by Daniel Haaser on 11/20/14.
//  Copyright (c) 2014 MakeSchool. All rights reserved.
//

#import "KeyValueLinkedList.h"
#import "Node.h"

@interface KeyValueLinkedList ()

@property (nonatomic, strong) Node* rootNode;
@property (nonatomic, weak) Node* lastNode;
@property (nonatomic, assign) NSUInteger objectCount;

@end

@implementation KeyValueLinkedList

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.objectCount = 0;
    }
    
    return self;
}

- (void)addObject:(id)object forKey:(NSString *)key
{
    Node* newNode = [Node new];
    newNode.data = object;
    newNode.key = key;
    
    // Special case: No root node yet
    if (!self.rootNode)
    {
        // If the root node doesn't exist, create it
        self.rootNode = newNode;
        self.lastNode = newNode;
    }
    else
    {
        [self addNodeToEnd:newNode];
    }
    
    self.objectCount++;
}

- (id)objectForKey:(NSString *)key
{
    Node* currentNode = self.rootNode;
    
    while (currentNode)
    {
        if ([currentNode.key isEqualToString:key])
        {
            return currentNode.data;
        }
        
        currentNode = currentNode.next;
    }
    
    return nil;
}

- (void)removeObjectForKey:(NSString *)key
{
    Node* previousNode = nil;
    Node* currentNode = self.rootNode;
    
    // Special case: root node
    if (self.rootNode && [self.rootNode.key isEqualToString:key])
    {
        self.rootNode = self.rootNode.next;
        self.objectCount--;
        return;
    }
    
    BOOL nodeFound = NO;
    
    while (currentNode)
    {
        if ([currentNode.key isEqualToString:key])
        {
            nodeFound = YES;
            break;
        }
        
        previousNode = currentNode;
        currentNode = currentNode.next;
    }
    
    if (nodeFound)
    {
        if (currentNode == self.lastNode)
        {
            self.lastNode = previousNode;
        }
    
        previousNode.next = currentNode.next;
        self.objectCount--;
    }
}

- (NSUInteger)count
{
    return self.objectCount;
}

- (void)addNodeToEnd:(Node*)node
{
    self.lastNode.next = node;
    self.lastNode = node;
}

@end
