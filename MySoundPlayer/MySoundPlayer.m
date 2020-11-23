//
//  MySoundPlayer.m
//  MySoundPlayer
//
//  Created by Toshimi Ataku on 2020/11/20.
//  Copyright © 2020 Toshimi Ataku. All rights reserved.
//

#import "MySoundPlayer.h"

@implementation MySoundPlayer

NSString *filePath;
NSData *soundData;
NSSound *snd;

- (IBAction)chooseFile:(id)sender {
    id dlg = [NSOpenPanel openPanel];
    id filePathArray;
    
    [dlg runModal];

    filePathArray = [dlg URLs];
    if ([filePathArray count] <= 0)
        return;
    _filePath.stringValue = filePath = [filePathArray[0] path];
}

void fixWavLen()
{
    char b1, b2, b3, b4;
    char *buf = soundData.bytes;
    NSUInteger length;
    
    length = soundData.length - 8;
    buf[7] = b4 = length & 0xff;
    buf[6] = b3 = (length >> 8) & 0xff;
    buf[5] = b2 = (length >> 8) & 0xff;
    buf[4] = b1 = (length >> 8) & 0xff;
}

- (IBAction)loadSoundData:(id)sender {
    id f = [NSFileHandle fileHandleForReadingAtPath:filePath];
    soundData = [f readDataToEndOfFile];
    NSLog(@"Length=%lu", soundData.length);
    fixWavLen();
    snd = [[NSSound alloc] initWithData:soundData];
//    snd = [[NSSound alloc] initWithContentsOfFile:filePath byReference:NO];
//    snd.playbackDeviceIdentifier = @"Built-in Output";
    if (!snd) {
        NSLog(@"No Sound");
        return;
    }
}

- (IBAction)playSoundData:(id)sender {
    if (!snd) {
        NSLog(@"No Sound");
        return;
    }
    snd.loops = YES;
    if (![snd play]) {
        NSLog(@"Play failed");
    }
}

- (IBAction)stopSound:(id)sender {
    if (!snd) {
        NSLog(@"No Sound");
        return;
    }
    [snd stop];
}

- (IBAction)getInfo:(id)sender {
//    snd.playbackDeviceIdentifier = @"Built-in Output";
    if (!snd) {
        NSLog(@"No Sound");
        return;
    }
    _deviceName.stringValue = @"Built-in Output";
    _playing.state = [snd isPlaying] ? NSOnState : NSOffState;
}

@end
