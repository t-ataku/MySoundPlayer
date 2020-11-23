//
//  NSObject+main2_m.m
//  GetSoundDeviceList
//
//  Created by Toshimi Ataku on 2020/11/20.
//  Copyright © 2020 Toshimi Ataku. All rights reserved.
//

#import "NSObject+main2_m.h"
#include <stdio.h>
#include <MacTypes.h>
#include <CoreAudio/CoreAudio.h>

@implementation NSObject (main2_m)


int main(int argc, const char * argv[])
{
    UInt32 sz;
    AudioHardwareGetPropertyInfo(kAudioHardwarePropertyDevices,&sz,NULL);
    AudioDeviceID *audioDevices=(AudioDeviceID *)malloc(sz + sizeof(AudioDeviceID));
    memset(audioDevices, '\377', sz + sizeof(AudioDeviceID));
    printf("sizeof(AudioDeviceID):%lu\n", sizeof(AudioDeviceID));
    AudioHardwareGetProperty(kAudioHardwarePropertyDevices,&sz,audioDevices);
    UInt32 deviceCount = (sz / sizeof(AudioDeviceID));

    UInt32 i;
    for(i=0;i<deviceCount;++i) {
        NSString *s;

        // get buffer list
        UInt32 outputChannelCount=0;
    {
        AudioDeviceGetPropertyInfo(
            audioDevices[i],0,false,
            kAudioDevicePropertyStreamConfiguration,
            &sz,NULL
            );
        AudioBufferList *bufferList=(AudioBufferList *)malloc(sz * sizeof(AudioBufferList));
        memset(bufferList, '\0', sizeof(sz * sizeof(AudioBufferList)));
        AudioDeviceGetProperty(
            audioDevices[i],0,false,
            kAudioDevicePropertyStreamConfiguration,
            &sz,bufferList
            );

        UInt32 j;
        for(j=0;j < bufferList->mNumberBuffers;++j)
            outputChannelCount += bufferList->mBuffers[j].mNumberChannels;

        free(bufferList);
    }

        // skip devices without any output channels
        if(outputChannelCount==0)
            continue;

        // output some device info
    {
        sz=sizeof(CFStringRef);

        AudioDeviceGetProperty(
            audioDevices[i],0,false,
            kAudioDevicePropertyDeviceUID,
            &sz,&s
            );
        NSLog(@"DeviceUID: [%@]",s);
//        [s release];

        AudioDeviceGetProperty(
            audioDevices[i],0,false,
            kAudioObjectPropertyName,
            &sz,&s
            );
        NSLog(@"    Name: [%@]",s);
//        [s release];

        NSLog(@"    OutputChannels: %d",outputChannelCount);
    }
    }
    return 0;
}

@end
