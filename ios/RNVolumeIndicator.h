
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#endif

#import <AVFoundation/AVAudioSession.h>
#import "React/RCTEventEmitter.h"
#import <MediaPlayer/MediaPlayer.h>


@interface RNVolumeIndicator : RCTEventEmitter <RCTBridgeModule>
@property (nonatomic) BOOL onVolumeChangeNotification;

-(float)getVolume;

@end
  
