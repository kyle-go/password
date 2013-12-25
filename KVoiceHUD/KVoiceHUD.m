
#import "KVoiceHUD.h"
#import <AVFoundation/AVFoundation.h>

#define HUD_WIDTH               260
#define HUD_HEIGHT              200
#define WAVE_UPDATE_FREQUENCY   0.05

@interface KVoiceHUD () <AVAudioRecorderDelegate>

@end

@implementation KVoiceHUD {
    NSUInteger      _voiceLevel;
    CGRect          _showRect;
	AVAudioRecorder *_recorder;
	NSTimer         *_timer;
}

- (id)initWithParentView:(UIView *)view
{
    self = [super initWithFrame:view.bounds];
    if (self) {
        self.contentMode = UIViewContentModeRedraw;
        
		self.hidden = YES;
        self.alpha = 0.0;
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.618];
        
        //音量0~7, 共8个等级
        _voiceLevel = 0;
        
        _showRect = CGRectMake(self.center.x - (HUD_WIDTH / 2), self.center.y - (HUD_HEIGHT / 2), HUD_WIDTH, HUD_HEIGHT);
    }
    return self;
}

- (void)startRecording {
    self.hidden = NO;
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 1.0;
    }];
    
    self.recordTime = 0.0;
    [self setNeedsDisplay];
    
	AVAudioSession *audioSession = [AVAudioSession sharedInstance];
	NSError *err = nil;
	[audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
	if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
    
    err = nil;
	[audioSession setActive:YES error:&err];
	if(err){
        NSLog(@"audioSession: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
	
	NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
	[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
	[recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
	[recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    /*
     [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
     [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
     [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
     */
	
	err = nil;
	NSData *audioData = [NSData dataWithContentsOfFile:self.recordFilePath options: 0 error:&err];
	if(audioData)
	{
		[[NSFileManager defaultManager] removeItemAtPath:self.recordFilePath error:&err];
	}
	
	err = nil;
	_recorder = [[ AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:self.recordFilePath] settings:recordSetting error:&err];
	if(!_recorder){
        NSLog(@"recorder: %@ %d %@", [err domain], [err code], [[err userInfo] description]);
        return;
	}
	
	[_recorder setDelegate:self];
	[_recorder prepareToRecord];
	_recorder.meteringEnabled = YES;
	
	[_recorder recordForDuration:(NSTimeInterval)20];
	_timer = [NSTimer scheduledTimerWithTimeInterval:WAVE_UPDATE_FREQUENCY target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
}

- (void)endRecording{
    [_timer invalidate];
    [_recorder stop];
    _recorder = nil;
    _timer = nil;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    [self setNeedsDisplay];
}

- (void)updateMeters {
    [_recorder updateMeters];
    
    CGFloat voice = [_recorder averagePowerForChannel:0];
    //NSLog(@"meter:%5f", voice);
    
    //-56   0
    //-48   1
    //...
    //0     7
    voice *= -1;
    if (voice > 56.0) {
        voice = 56.0;
    }
    _voiceLevel = 7 - voice/8;
    //NSLog(@"voiceProgress = %d", voiceProgress);
    
    self.recordTime += WAVE_UPDATE_FREQUENCY;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *strokeColor = [UIColor colorWithRed:0.618 green:0.618 blue:0.618 alpha:0.8];
    UIColor *fillColor = [UIColor colorWithRed:0.5827 green:0.5827 blue:0.5827 alpha:1.0];
    UIColor *gradientColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    
    NSArray *gradientColors = [NSArray arrayWithObjects:
                               (id)fillColor.CGColor,
                               (id)gradientColor.CGColor, nil];
    CGFloat gradientLocations[] = {0, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradientColors, gradientLocations);
    
    UIBezierPath *border = [UIBezierPath bezierPathWithRoundedRect:_showRect cornerRadius:10.0];
    CGContextSaveGState(context);
    [border addClip];
    CGContextDrawRadialGradient(context, gradient,
                                CGPointMake(_showRect.origin.x+HUD_WIDTH/2, 120), 10,
                                CGPointMake(_showRect.origin.x+HUD_HEIGHT/2, 195), 215,
                                kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    
    CGContextRestoreGState(context);
    [strokeColor setStroke];
    border.lineWidth = 3.0;
    [border stroke];
    
    //Draw sound
    [[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4] set];
    CGContextSetLineWidth(context, 8.0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGFloat interval = 14;
    CGFloat x = _showRect.origin.x + _showRect.size.width - 100;
    CGFloat y = _showRect.origin.y + _showRect.size.height - 40;
    
    for (NSUInteger i = 0; i <= _voiceLevel; i++) {
        CGContextMoveToPoint(context, x, y - interval*i);
        CGContextAddLineToPoint(context, x + 8 * (i+1), y - interval*i);
    }
    CGContextStrokePath(context);
    
    //draw microphone
    UIImage *imgMicrophone = [UIImage imageNamed:@"micro"];
    [imgMicrophone drawAtPoint:CGPointMake(_showRect.origin.x + _showRect.size.width/2 - imgMicrophone.size.width/2 - 50, _showRect.origin.y + _showRect.size.height/2 - imgMicrophone.size.height/2 + 10)];
}

@end
