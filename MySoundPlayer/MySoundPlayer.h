//
//  MySoundPlayer.h
//  MySoundPlayer
//
//  Created by Toshimi Ataku on 2020/11/20.
//  Copyright © 2020 Toshimi Ataku. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySoundPlayer : NSObject
@property (weak) IBOutlet NSTextField *filePath;
@property (weak) IBOutlet NSSlider *volume;
@property (weak) IBOutlet NSSlider *pastTime;
@property (weak) IBOutlet NSTextField *deviceName;
@property (weak) IBOutlet NSButton *playing;

- (IBAction)chooseFile:(id)sender;
- (IBAction)loadSoundData:(id)sender;
- (IBAction)playSoundData:(id)sender;
- (IBAction)getInfo:(id)sender;
- (IBAction)stopSound:(id)sender;

@end

NS_ASSUME_NONNULL_END
