//
//  PorraDetailCustomCell.h
//  Porras
//
//  Created by Daniel Prado Rodríguez on 01/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PorraDetailCustomCell : UITableViewCell {
	UIImageView *escudoEquipoUno;
	UIImageView *escudoEquipoDos;
	UILabel *lblEquipoUno;
	UILabel *lblEquipoDos;
	
	UILabel *lblResultado;
}

@property (nonatomic,retain) IBOutlet UIImageView *escudoEquipoUno;
@property (nonatomic,retain) IBOutlet UIImageView *escudoEquipoDos;
@property (nonatomic,retain) IBOutlet UILabel *lblEquipoUno;
@property (nonatomic,retain) IBOutlet UILabel *lblEquipoDos;

@property (nonatomic,retain) IBOutlet UILabel *lblResultado;

@end
