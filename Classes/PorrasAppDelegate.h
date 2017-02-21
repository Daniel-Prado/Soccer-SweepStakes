//
//  PorrasAppDelegate.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 30/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PorrasNavController.h"

@interface PorrasAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
	IBOutlet UITabBarController *rootController;
	IBOutlet PorrasNavController *porrasNavController;
	
	NSArray *arrayEquipos;
    
@private
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) NSArray *arrayEquipos;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) IBOutlet UITabBarController *rootController;
@property (nonatomic, retain, readonly) IBOutlet PorrasNavController *porrasNavController;


- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end

