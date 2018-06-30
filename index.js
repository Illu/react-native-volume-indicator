import { NativeModules, NativeEventEmitter, View, StyleSheet, Dimensions, Animated } from 'react-native';
import React, {Component} from 'react';

const { RNVolumeIndicator } = NativeModules;

const SCREEN_WIDTH = Dimensions.get('window').width;
const volumeManagerEmitter = new NativeEventEmitter(RNVolumeIndicator);

// Subscription to volume changes
let subscription;
export const listenToVolumeChange = callback =>
  subscription = volumeManagerEmitter.addListener(
    'volumeChange',
    (volumeData) => {callback(volumeData.volume)});

export const stopListeningToVolumeChange = () => {
  subscription.remove();
};

export const getVolume = () => RNVolumeIndicator.getVolume();

// Actual Volume indicator component
export default class VolumeIndicator extends Component {

  constructor(props) {
    super(props);
    this.state = {
      volume: 0,
      widthAnim: new Animated.Value(0),
    };
  };

  componentDidMount() {
    getVolume().then(volume => {
      this.setState({ volume });
      this._AnimateChange(volume, true);
    });
    listenToVolumeChange(this._onVolumeChange);
  };

  componentWillUnmount() {
    stopListeningToVolumeChange();
  };

  _onVolumeChange = (volume) => {
    this.setState({ volume });
    this._AnimateChange(volume);
  };

  _AnimateChange = (volume, instant = false) => {
    const { widthAnim } = this.state;
    Animated.timing(
      widthAnim,
      {
        toValue: SCREEN_WIDTH * volume,
        duration: instant ? 0 : 150,
      }
    ).start();
  };

  render() {
    const { style, layout } = this.props;
    const { widthAnim } = this.state;
    return (
      <View style={[style, styles.container]}>
        <Animated.View style={[styles.volumeIndicator, {width: widthAnim} ]} />
      </View>
    );
  }
}

// Styles

const styles = StyleSheet.create({
  container: {
    width: SCREEN_WIDTH,
    height: 5,
    backgroundColor: 'transparent',
  },
  volumeIndicator: {
    height: 5,
    backgroundColor: "#0084b4",
  },
});
