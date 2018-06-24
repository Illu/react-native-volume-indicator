
import { NativeModules, NativeEventEmitter } from 'react-native';

const { RNVolumeIndicator } = NativeModules;

export const volumeManagerEmitter = new NativeEventEmitter(RNVolumeIndicator);

export default RNVolumeIndicator;
