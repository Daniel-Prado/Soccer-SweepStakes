//
//  ResultadoPartidoViewController.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 06/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "PorraCD.h"

@protocol ResultadoPartidoViewControllerDelegate;

@interface ResultadoPartidoViewController : UIViewController <UIAlertViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate> {
	
	id <ResultadoPartidoViewControllerDelegate> delegate;
	
	UIPickerView *resLocal;
	UIPickerView *resVisitante;
		
	UILabel *equipoLocal;
	UILabel *equipoVisitante;
	
	NSMutableArray *arrayMarcador;
	
	PorraCD *porra;
	
}

- (IBAction)cancelPartido;
- (IBAction)savePartido;

@property(nonatomic,retain) PorraCD *porra;
@property(nonatomic,retain) IBOutlet UILabel *equipoLocal;
@property(nonatomic,retain) IBOutlet UILabel *equipoVisitante;
@property(nonatomic,retain) IBOutlet UIPickerView *resLocal;
@property(nonatomic,retain) IBOutlet UIPickerView *resVisitante;
@property(nonatomic,retain) IBOutlet id <ResultadoPartidoViewControllerDelegate> delegate;

@end

@protocol ResultadoPartidoViewControllerDelegate

-(void) ModalDidEnd:(UIViewController*) controlador;

@end