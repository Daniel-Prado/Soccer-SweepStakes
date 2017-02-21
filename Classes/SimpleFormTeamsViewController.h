//
//  SimpleFormTeamsViewController.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 03/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SimpleFormTeamsViewControllerDelegate;

@interface SimpleFormTeamsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
	
	id <SimpleFormTeamsViewControllerDelegate> delegate;
	NSArray *arrayEquipos;
	id equipoYaSeleccionado;
	
	bool visitante;
	
}

-(IBAction)cancelForm;

@property(nonatomic,retain) id <SimpleFormTeamsViewControllerDelegate> delegate;
//@property(nonatomic,retain) IBOutlet UITextField *txt;

@property(nonatomic,retain) NSArray *arrayEquipos;
@property(nonatomic,retain) id equipoYaSeleccionado;
@property bool visitante;

@end

@protocol SimpleFormTeamsViewControllerDelegate

-(void) saveFormEquipo:(NSString*)nombre Escudo:(NSString*)escudo Indice:(int)i;

@end
