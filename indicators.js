import React, {Component} from 'react';
import {View, Animated, StyleSheet, Dimensions} from 'react-native';

const LAYOUT_DEFAULT = 'default';
const LAYOUT_DARK_VERTICAL = 'dark-vertical';

const SCREEN_WIDTH = Dimensions.get('window').width;

const DarkVertical = ({anim, style = {}}) => {
  const styles = StyleSheet.create({
    container: {
      width: 24,
      height: 100,
      margin: 20,
      backgroundColor: 'rgba(0, 0, 0, 0.7)',
      borderRadius: 10,
      alignItems: 'center',
      paddingBottom: 7,
      justifyContent: 'flex-end',
    },
    volumeIndicator: {
      width: 10,
      backgroundColor: "rgba(255, 255, 255, 0.85)",
      borderRadius: 5,
    },
  });

  const height = anim.interpolate({
    inputRange: [0, 1],
    outputRange: [0, 86],
  });

  return (
    <View style={[styles.container, style]}>
      <Animated.View style={[styles.volumeIndicator, {height} ]} />
    </View>
  );
};

const Default = ({anim, style = {}}) => {
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

  const width = anim.interpolate({
    inputRange: [0, 1],
    outputRange: [0, SCREEN_WIDTH],
  });

  return (
    <View style={[styles.container, style]}>
      <Animated.View style={[styles.volumeIndicator, {width} ]} />
    </View>
  );
};

export default class extends Component {

  state = {
    anim: new Animated.Value(0),
  };

  componentWillReceiveProps(newProps){
    const {volume} = this.props;
    if (newProps.volume){
      this._animate(newProps.volume, !volume);
    }
  }

  _animate = (volume, instant = false) => {
    const { anim } = this.state;
    Animated.timing(
      anim,
      {
        toValue: volume,
        duration: instant ? 0 : 150,
      }
    ).start();
  };

  render() {
    const {layout} = this.props;
    const {anim} = this.state;

    switch(layout){
      case LAYOUT_DARK_VERTICAL:
        return <DarkVertical anim={anim} {...this.props} />;
        break;
      default:
        return <Default anim={anim} {...this.props} />;
    }
  }
}