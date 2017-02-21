//
//  ParticipanteViewController.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 05/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonaCD.h"

@protocol ParticipanteViewControllerDelegate;

@interface ParticipanteViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {

	id <ParticipanteViewControllerDelegate> delegate;
	
	UITextField *nombreParticipante;
	UIPickerView *resLocal;
	UIPickerView *resVisitante;
	UIButton *btnEliminar;
	
	UILabel *equipoLocal;
	UILabel *equipoVisitante;
	
	NSMutableArray *arrayMarcador;
	
	PersonaCD *personaEditada;
	
}

- (IBAction)cancelParticipante;
- (IBAction)saveParticipante;
- (IBAction)eliminarParticipante;

@property(nonatomic,retain) PersonaCD* personaEditada;
@property(nonatomic,retain) IBOutlet UILabel *equipoLocal;
@property(nonatomic,retain) IBOutlet UILabel *equipoVisitante;
@property(nonatomic,retain) IBOutlet UITextField *nombreParticipante;
@property(nonatomic,retain) IBOutlet UIPickerView *resLocal;
@property(nonatomic,retain) IBOutlet UIPickerView *resVisitante;
@property(nonatomic,retain) IBOutlet id <ParticipanteViewControllerDelegate> delegate;
@property(nonatomic,retain) IBOutlet UIButton *btnEliminar;

@end

@protocol ParticipanteViewControllerDelegate

-(void) saveParticipanteNombre:(NSString*)nombre Resultado:(NSString*)resultado;
-(void) eliminarParticipante:(PersonaCD*)persona;
-(void) ModalDidEnd:(UIViewController *) controlador;

@end